#!/usr/bin/perl

#- This script will try to produce some output compatible with Emacs
#- "compile" format out of the latest backtrace it can find in log4j
#- logfiles. Adding the following to .emacs will allow invoking it
#- with `M-=':
#-
#-  (defun get-trace ()
#-    (interactive)
#-    (compile "..path../show-trace-in-emacs.pl")
#-             )
#-
#-  (add-hook 'java-mode-hook
#-  	  '(lambda ()
#-            ...your other locally defined things...
#-  	      (local-set-key "\M-=" 'get-trace)
#-                ))

my @log4j = ( '/usr/local/tomcat5/fb/logs/fb.log4j',
              '/usr/local/tomcat5/metarate/logs/metarate.log4j' );
my %name2path =
 ( '^org.gc.frozen-bubble.servlets' => "/home/gc/dev/fb/servlets/src",
   '^org.gc.tools' => "/home/gc/dev/java-tools/src",
 );
my @tomcat_files =
  ( '/usr/local/tomcat5/fb/logs/fb.<DATE>.log',
    '/usr/local/tomcat5/metarate/logs/metarate.<DATE>.log',
  );
my $myclasses = 'org.gc';



my @traces;
my ($switches, $files) = partition(sub { /^-/ }, @ARGV);

if ( @$files ) {
    @log4j = @$files;
}

#- allow to find in logfiles for a segfault
if ("@$switches" =~ /-segfault/) {
    my ($DAY, $MONTH, $YEAR) = (localtime)[3,4,5];
    @log4j = @tomcat_files;
    foreach (@log4j) {
        s/<DATE>/sprintf("%d-%02d-%02d", $YEAR + 1900, $MONTH + 1, $DAY)/e;
    }
}


log4j:
foreach my $file ( @log4j ) {
    -f $file or next;
    my @contents = reverse( chomp_( `tail -n 1000 $file` ) );
    my @trace;
    foreach my $line ( @contents ) {
        if ( $line =~ /^\s+(at )?($myclasses\.\S+)\((\w+.java):(\d+)\)/ ) {
            push @trace, { fullpath => $2, file => $3, line => $4,
                           orig => $line };
        } else {
            if ( @trace ) {
                if ( $line =~ /^\s*\[[^\]]+\](\S+ \S+)/ ) {
                    my $date = $1;
                    if ( $line =~ /\s+(at )?($myclasses\.\S+)\((\w+.java):(\d+)\)/ ){
                        push @trace, { fullpath => $2, file => $3, line => $4,
                                       orig => $line };
                    }
                    push @traces,
                         { trace => \@trace, date => $date, log4j => $file };
                    next log4j;
                } elsif ( $line =~ /^java\.lang\..*Exception/ ) {
                    push @traces,
                         { trace => \@trace, date => stat_($file),
                           log4j => $file };
                    next log4j;
                }
            }
        }
    }
}

my $latest_trace = first( sort { $b->{date} cmp $a->{date} } @traces );
print "Latest trace found in ", basename($latest_trace->{log4j}),
      " at $latest_trace->{date}:\n\n";

line:
foreach my $line ( reverse( @{$latest_trace->{trace}} ) ) {

    foreach my $match ( sort { length($b) <=> length($a) } keys(%name2path) ) {
        if ( $line->{fullpath} =~ /$match/ ) {
            my ($package) = $line->{fullpath} =~ /(.*)\.\w+\.[^\.]+/;
            $package =~ s|\.|/|g;
            my $file = "$name2path{$match}/$package/$line->{file}";
            if (-f $file) {
                print "$file:$line->{line}:\n";
            } else {
                print "$line->{orig} -> PATH DOESN'T YIELD AN EXISTING FILE\n";
            }
            next line;
        }
    }

    print "$line->{orig} -> NOPATH\n";
}


sub max  { my $n = shift; $_ > $n and $n = $_ foreach @_; $n }
sub stat_ {
    my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blocks) = stat $_[0];
    my $modtime = max($mtime, $ctime);
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($modtime);
    return sprintf "%d-%02d-%02d %02d:%02d:%02d",
      $year+1900, $mon+1, $mday, $hour, $min, $sec;
}

sub chomp_ { my @l = map { my $l = $_; chomp $l; $l } @_; wantarray() ? @l : $l[0] }
sub first { $_[0] }
sub basename { local $_ = shift; s|/*\s*$||; s|.*/||; $_ }
sub partition(&@) {
    my $f = shift;
    my (@a, @b);
    foreach (@_) {
	$f->($_) ? push(@a, $_) : push(@b, $_);
    }
    \@a, \@b;
}
