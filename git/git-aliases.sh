#!/bin/bash

# {{ git
# Git alias
alias cdg='cd $(git rev-parse --show-toplevel)' #goto root dir

alias g="git status --short -b"
alias gn="git status --untracked-files=no --short -b"

alias ga="git add"
alias gap='git add --patch'
alias gai='git add -i'
alias gau="git add -u"

alias gc="git commit -m"
alias gca="git commit --amend"
alias gja="git --no-pager commit --amend --reuse-message=HEAD" # git just amend

alias gst="git stash"
alias gsta="git stash apply"

alias gmt="git mergetool"

alias gl="git log --pretty=format:'%C(yellow)%h%Creset%C(green)%d%Creset %ad %s %Cred(%an)%Creset' --date=short --decorate --graph"
alias glp="git log --pretty=format:'%C(yellow)%h%Creset%C(green)%d%Creset %ad %s %Cred(%an)%Creset' --date=short --decorate -p"
alias glps="git log --pretty=format:'%h %s (%an)' --date=short -n1 | pclip"
alias gls="git log --oneline --decorate --graph --stat"

alias grm="git rebase master"

alias gnb="git checkout -b"

alias gs="git show"
alias gss="git show --stat"
alias gsh^="git show HEAD^"
alias gsh^^="git show HEAD^^"

alias gd="git diff"
alias gds="git diff --stat"
alias gdc="git diff --cached"
alias gdcs="git diff --cached --stat"
alias ghe='git diff --name-only --diff-filter=U|grep "\.html\|\.min\.js"|xargs -I{} sh -c "git checkout --theirs {} && git add {}"'
alias gme='git diff --name-only --diff-filter=U|grep "\.html\|\.min\.js"|xargs -I{} sh -c "git checkout --our {} && git add {}"'
# show diff from the branch to current HEAD
alias gdp='git diff $(git branch | sed "s/[\* ]\+//g" | percol)..HEAD'

alias gps="git push"
alias gpf="git push --force"

alias gpl="git pull"
alias gpr="git pull -r"

alias gb="git branch"
# delete selected local branch
alias gbd='git branch -D $(git branch | sed "s/[\* ]\+//g" | percol)'

alias grh='git reset --hard HEAD'
alias gr1='git reset --hard HEAD^'
alias gr2='git reset --hard HEAD^^'

# "git commit only"
# Commits only what's in the index (what's been "git add"ed).
# When given an argument, uses that for a message.
# With no argument, opens an editor that also shows the diff (-v).
function gco () {
  if [ -z "$1" ]; then
    git commit -v
  else
    git commit -m "$1"
  fi
}

# "git commit all"
# Commits all changes, deletions and additions.
# When given an argument, uses that for a message.
# With no argument, opens an editor that also shows the diff (-v).
function gca () {
  git add --all && gco "$1"
}

function gfp ()  {
    if [ -z "$1" ]; then
        echo "Usage: gfp since [file]"
        echo "  Just alias of 'git format-patch -n --stdout since -- [file]'"
        echo "  'gfp since | git am' to apply the patch"
    fi
    git format-patch -n --stdout $1 -- $2
}

# switch to recent git branch or just another branch
#function grb () {
#    local crtb=`git branch | grep \*`
#    local ptn="no branch"
#    # compatible way to detect sub-strin in bash
#    # @see http://stackoverflow.com/questions/229551/string-contains-in-bash
#    if [ -z "${crtb##*$ptn*}" ]; then
#        # detached HEAD
#        git checkout $(git branch | sed '/no branch/d' | percol)
#    else
#        local myrbs=`git for-each-ref --sort=-committerdate refs/heads/ | sed -e s%.*refs\/heads\/%%g`
#        local crb=`git symbolic-ref --short HEAD`
#        git checkout `echo "$myrbs" | sed -e /$crb/d | percol`
#    fi
#}

# select a local git branch
function gsb () {
    local b=`git branch | sed "s/[\* ]\+//g" | percol`
    echo -n ${b} | pclip;
    echo ${b}
}

# print current branch name
function gcb () {
    local crb=`git symbolic-ref --short HEAD`
    echo -n ${crb} | pclip;
    echo ${crb}
}

# new local branch based on remote branch
#function gnr () {
#    local myrb=`git for-each-ref --sort=-committerdate refs/remotes/ | sed -e s%.*refs\/remotes\/%%g | percol`
#    local mylb=`echo -n $myrb | sed 's/.*\/\([^\/]\+\)$/\1/'`
#    git checkout -b $mylb $myrb
#}

function glsf () {
    local str=`git --no-pager log --oneline --stat $* |  percol`
    if [[ $str =~ ^[[:space:]]*([a-z0-9A-Z_.\/-]*).*$ ]]; then
        echo -n ${BASH_REMATCH[1]} |pclip;
        echo ${BASH_REMATCH[1]}
    fi
}

#function glmep () {
#    git log --author='[Cc]hen [Bb]in' --pretty=format:'%C(yellow)%h%Creset%C(green)%d%Creset %ad %s %Cred(%an)%Creset' --date=short --decorate -p `gcid`..HEAD
#}

function gchk () {
    if [ -z "$1" ]; then
        echo "Usage: gchk commit_id"
        echo "reset hard certain version of current working directory"
    else
        rm -rf $PWD/*
        git checkout $1 -- $PWD
    fi
}

function gsf () {
    local str=`git --no-pager show --stat $* |  percol`
    if [[ $str =~ ^[[:space:]]*([a-z0-9A-Z_.\/-]*).*$ ]]; then
        echo -n ${BASH_REMATCH[1]} |pclip;
        echo ${BASH_REMATCH[1]}
    fi
}

function glf () {
    local str=`git --no-pager log --oneline --decorate --stat $* | percol`
    if [[ $str =~ ^[[:space:]]*([a-z0-9A-Z_.\/-]*).*$ ]]; then
        echo -n ${BASH_REMATCH[1]} |pclip;
        echo ${BASH_REMATCH[1]}
    fi
}

function gdf () {
    local str=`git --no-pager diff --stat $*| percol`
    if [[ $str =~ ^[[:space:]]*([a-z0-9A-Z_.\/-]*).*$ ]]; then
        echo -n ${BASH_REMATCH[1]} |pclip;
        echo ${BASH_REMATCH[1]}
    fi
}

function gdcf () {
    local str=`git --no-pager diff --cached --stat $* |  percol`
    if [[ $str =~ ^[[:space:]]*([a-z0-9A-Z_.\/-]*).*$ ]]; then
        echo -n ${BASH_REMATCH[1]} |pclip;
        echo ${BASH_REMATCH[1]}
    fi
}

function gu(){
    local st=`git status --porcelain --untracked=no`
    if [ -z "$st" ]; then
        git pull --rebase
    else
        git stash && git pull --rebase && git stash pop
    fi
}

function gsrp(){
  if [ -z "$1" ]; then
      echo "Usage: gsrp old_string new_string (string could be perl regex)"
      echo "replace the content of file in latest git commit"
  elif [ $# -eq "2" ]; then
      git diff-tree --no-commit-id --name-only -r HEAD|xargs perl -pi -e "s/$1/$2/g"
  elif [ $# -eq "3" ]; then
      git diff-tree --no-commit-id --name-only -r $1|xargs perl -pi -e "s/$2/$3/g"
  fi
}

# git tools to handle commit id, need mooz's  ~/bin/percol.py which could be installed by `pip install  ~/bin/percol.py`
function gurl () {
    if [ -z "$1" ]; then
        echo "Usage: gurl commit-id"
        echo "get the full http url of commit"
    else
        local msg=`git remote -v|grep "origin *.* *(fetch)"|sed -e "s/origin *\(.*\) *(fetch)/\1/"`
        local url=""
      # github
        if [ "${msg:0:14}" == "git@github.com" ]; then
            echo https://github.com/`echo ${msg}|sed -e "s/^git\@github\.com\:\(.*\)\.git$/\1/"`/commit/$1
        fi
    fi
}

# pick commit id from `git log`
function gcid () {
    local commit_id=`git log --pretty=format:'%h %ad %s (%an)' --date=short --graph | percol|sed -e"s/^[ *|]*\([a-z0-9]*\) .*$/\1/"`
    echo ${commit_id}
}

#pick commit from `git log` and output its url
function gqurl () {
    local commit_id=`git log --pretty=format:'%h %ad %s (%an)' --date=short| percol|sed -e"s/^\([a-z0-9]*\) .*$/\1/"`
    gurl ${commit_id}
}

# list changed files from specifc commit to head
function glf () {
    local commit_id=`git log --pretty=format:'%h %ad %s (%an)' --date=short| percol|sed -e"s/^\([a-z0-9]*\) .*$/\1/"`
    git diff-tree --no-commit-id --name-only -r ${commit_id} -r HEAD
}

alias glfge='git diff-tree --no-commit-id --name-only -r `git log --pretty=format:"%h %ad %s (%an)" --date=short| percol|sed -e"s/^\([a-z0-9]*\) .*$/\1/"` -r HEAD|xargs ${GREPCMD}'

# }}
