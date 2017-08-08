#!/bin/sh

# Compile then run a java sourcefile (containing a "main" entry point)
javac $1 || exit $?

main=`echo $1 | perl -pe 's/\.java$//; s|/*\s*$||; s|.*/||;'`
shift
java $main $*
