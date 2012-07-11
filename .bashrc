#!/bin/sh

# If the admin prefers the better-looking way
[ -f /etc/bashrc ] && source /etc/bashrc


### GENERAL ###

export PS1="\u@\h:\W\\$ "

# My own binaries
export PATH="$HOME/bin:$PATH"

#export EMAIL="$USER@`dnsdomainname -f`"
export EMAIL="Daniel Werner <daniel.d.werner@gmail.com>"
export MAIL="$HOME/mail/inbox"
export MAILPATH="$MAIL:/var/mail/$USER"
unset MAILCHECK

export DEBFULLNAME="Daniel Werner"
export DEBEMAIL="$EMAIL"

#export TMPDIR="$HOME/tmp"

# Proxy settings
#export http_proxy=http://proxy:3128
#export ftp_proxy=http://proxy:3128
#export no_proxy="localhost"

# cd to dirs in . or projects
#export CDPATH="/home/projects/"

# Locale information
export LANGUAGE="en_GB:en"	# Python doesn't parse this correctly
export LANG="en_GB.UTF-8"
unset LC_ALL
#export LC_IDENTIFICATION=""		# Metadata about the locale information
#export LC_ADRESS="en_US.ISO-8859-1"	# Adress formats & location information
#export LC_CTYPE="en_US.ISO-8859-1"	# Upper/lowercase conversion
#export LC_COLLATE="en_US.ISO-859-1"	# Collation/sorting order
#export LC_MONETARY="C"			# Monetary numbers (dec comma/point)
#export LC_MEASUREMENT="de_DE"		# Measurement units (metric/imperial)
#export LC_MESSAGES="C"			# Message language and so on
#export LC_NAME="de_DE"			# Name format
#export LC_NUMERIC="C"			# Non-monetary numeric formats
#export LC_PAPER="de_DE"		# Paper size
#export LC_TELEPHONE="de_DE"		# Telephone number format
#export LC_TIME="de_DE"			# How to print time (24/12 hour clock)
export PAPERSIZE='A4'
export LESSCHARSET="utf-8"		# Make less display unicode
#export LESSCHARSET="latin9"		# Make less display iso-8859-15
#export MM_CHARSET="iso-8859-15"	# Used by MUA I don't use. Sheesh.

# Why?
unset USERNAME

# Users generally won't see annoying core files
[ "$UID" = "0" ] && ulimit -S -c 1000000 >/dev/null 2>&1

# Allow users to talk/wall to my tty
/usr/bin/mesg y

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# -rw-r--r--
# drwxrwxr-x
umask 0022

# Log me out for security
export TMOUT=0

# Don't wait for job termination notification
set -o notify

# Make ^D follow the snark rule: "What I tell you thrice is true"
#set -o ignoreeof
export IGNOREEOF=2

export HISTCONTROL=ignoredups
export HISTFILESIZE=5000
export HISTSIZE=500
export HISTIGNORE='shred *:vapor *:wipe *'

# man(1) default arguments, overridden by supplying -D as first flag
export MANOPT="--all"

# gzip(1) and bzip2(1) maximum compression
export GZIP="-9"
export BZIP="-9"
export ZIP="-9"

# OpenOffice.org
export OOO_FORCE_DESKTOP=gnome

# Shell options
shopt -s cdspell cmdhist extglob histverify xpg_echo #mailwarn nocaseglob

# xterm window caption
[ $TERM = 'xterm' -o $TERM = 'xterm-debian' -o $TERM = 'rxvt' ] &&
	export PROMPT_COMMAND='echo -ne "\033]0;$USER@$HOSTNAME: $PWD\007"'


# If not running interactively, don't do anything further
[ -z "$PS1" ] && return


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Colorize prompt & ls output with custom magic
if [ "$TERM" != "dumb" ]; then
    export PS1="\[\033[1;33m\]\u@\h:\W\$ \[\033[0m\]"

    if [ -r "$HOME/.dir_colors" ]; then
        eval "`dircolors -b $HOME/.dir_colors`"
    fi
fi

# Pipe less data through lesspipe first. This will activate extra
# features like displaying rpm/deb-packages ...
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"


### FUNCTIONS ###

# Copy whole trees via tar -- courtesy of Alan Cox
function cptree
{
  (cd "$1" && tar cf - .) | (cd "$2" && tar xpvf -);
}

# Append current ISO date to filename
function datify {
    mv "$1" "$1-`date '+%Y%m%d'`"
}

# Use vim as a pager
function v() { $@ | vim -R - ; }


### ALIASES ###

# Every user got a todo-list
alias todo="$EDITOR $HOME/$USER-todo"

# Generally useful aliases and functions
alias cd..='cd ..'
alias ls='ls -hpFv --color=auto'
alias l='ls -1'
alias ll='ls -l'
alias la='ls -a'
alias lla='la -l'
alias lld='ll -d'
# From pysh
alias lk='ll | grep ^l'

alias vim='vim -N'
alias vi='vim'
alias j='jed'

# Commonly used programs default options
#alias Mplayer='mplayer -fs -idx'
alias startx='startx 2>$HOME/.startx.log'
alias lynx="lynx -cfg $HOME/.lynxcfg"
alias bc='bc --quiet'

# Simulating non-GNU Unix programs
#alias less='less -RI'
alias whence='type -a'

# Convenience
#alias r='fc -s'
#alias shlvl='echo $SHLVL'
#alias realpwd='pwd -P'
alias pstree='pstree -hlG'

# Fault tolerance
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# Verbosity
alias shred='shred -v'
alias apack='apack -v'
alias aunpack='aunpack -v'

# Some aliases for the kill* commands for those who don't want
# to use violent words like 'kill'. Inspired by Jesux :-P
#alias sig='kill'
#alias sigall='killall'

### APPLICATIONS ###

export EDITOR="vim"
export VISUAL="vim"
export MAILREADER="mutt"

export BROWSER="elinks"

# less(1) is the default pager
#export PAGER="less -RI"	# bzr lessdiff croaks
export PAGER="less"

# Colored aterms
if type "aterm" &>/dev/null;  then
  alias redterm='aterm -tint red -tr -trsb -sh 70 -cr green +sb -sl 1000 -title RedTerm -fn 8x13 -fg White'
  alias blueterm='aterm -tint blue -tr -trsb -sh 70 -cr green +sb -sl 1000 -title BlueTerm -fn 8x13 -fg White'
  alias greenterm='aterm -tint green -tr -trsb -sh 40 -cr green +sb -sl 1000 -title GreenTerm -fn 8x13 -fg White'
  alias blackterm='aterm -tint black -tr -trsb -sh 90 -cr green +sb -sl 1000 -title BlackTerm -fn 8x13 -fg White'
fi

# enable bash completion in interactive shells
[ -f /etc/bash_completion ] && source /etc/bash_completion

# Source host-specific configuration
[ -f /etc/bashrc.local ] && source "/etc/bashrc.local"

# Command-not-found magic
conofo=/etc/bash_command_not_found
if [ -r $conofo ]; then
    . $conofo
fi
