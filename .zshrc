#
# danwerner's ZSH configuration
#

# No %*$(#& audible bell!!
setopt nobeep

################################
## Prompt

#autoload -U promptinit
#promptinit
#prompt suse

if autoload -U colors && colors; then
	export PS1="%{$fg[blue]%}%B%n@%m %~ %%%b%{$reset_colors%} "
else
	export PS1='%B%n@%m %~ %%%b '
fi

export PS2='  %B>%b '

################################
## Variables

export PATH="$HOME/bin:$HOME/.cabal/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/games"

export EMAIL="daniel.d.werner@gmail.com"
export MAIL="$HOME/mail/inbox"
export MAILPATH="$MAIL:/var/mail/$USER"
unset MAILCHECK

export DEBFULLNAME="Daniel Werner"
export DEBEMAIL="$EMAIL"

export EDITOR="vim"
export VISUAL="vim"
export MAILREADER="mutt"
export BROWSER="lynx"
export PAGER="less"


## Proxy settings
#export http_proxy=http://proxy:3128
#export ftp_proxy=http://proxy:3128
#export no_proxy="localhost"

## Locale information (disabled, should preferably be set by the OS)
#export LANGUAGE="en_GB:en"      # Python doesn't parse this correctly
#export LANG="en_GB.UTF-8"
#unset LC_ALL
#export LC_IDENTIFICATION=""            # Metadata about the locale information
#export LC_ADRESS="en_US.ISO-8859-1"    # Adress formats & location information
#export LC_CTYPE="en_US.ISO-8859-1"     # Upper/lowercase conversion
#export LC_COLLATE="en_US.ISO-859-1"    # Collation/sorting order
#export LC_MONETARY="C"                 # Monetary numbers (dec comma/point)
#export LC_MEASUREMENT="de_DE"          # Measurement units (metric/imperial)
#export LC_MESSAGES="C"                 # Message language and so on
#export LC_NAME="de_DE"                 # Name format
#export LC_NUMERIC="C"                  # Non-monetary numeric formats
#export LC_PAPER="de_DE"                # Paper size
#export LC_TELEPHONE="de_DE"            # Telephone number format
#export LC_TIME="de_DE"                 # How to print time (24/12 hour clock)
#export PAPERSIZE='A4'
#export LESSCHARSET="utf-8"             # Make less display unicode
#export LESSCHARSET="latin9"            # Make less display iso-8859-15

# Allow users to talk/wall to my tty
#/usr/bin/mesg y

# -rw-r--r--
# drwxrwxr-x
umask 0022

# Log me out for security
export TMOUT=0

[ -r /etc/zsh_command_not_found ] && source /etc/zsh_command_not_found

#############################
## Default Options

# man(1) default arguments, overridden by supplying -D as first flag
export MANOPT="--all"

# gzip(1) and bzip2(1) maximum compression
export GZIP="-9"
export BZIP="-9"
export ZIP="-9"

# OpenOffice.org
export OOO_FORCE_DESKTOP=gnome

alias ls='ls -hpFv --color=auto'
alias l='ls -1'
alias ll='ls -l'
alias la='ls -a'
alias lla='la -l'
alias lld='ll -d'
# From pysh
alias lk='ll | grep ^l'

alias grep='grep --color=auto'

alias vi='vim'
alias startx='startx 2>$HOME/.startx.log'
alias lynx='lynx -cfg $HOME/.lynxcfg'
alias bc='bc --quiet'
alias pstree='pstree -hlG'

# Fault tolerance
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# Verbosity
#alias shred='shred -v'
alias apack='apack -v'
alias aunpack='aunpack -v'

alias gst='git status'

# Pipe less data through lesspipe first. This will activate extra
# features like displaying rpm/deb-packages ...
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

###########################################
# Taken from Debian's default zshrc

if [[ -f ~/.dir_colors ]]; then
       eval `dircolors -b ~/.dir_colors`
else
       eval `dircolors -b /etc/DIR_COLORS`
fi

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                             /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

###########################################
# Taken from Gentoo's default zshrc

case $TERM in
    *xterm*|*rxvt*|screen)
            export mytitle="\e]0;%n@%m: %~\a"
            #precmd () {print -Pn $mytitle}
            chpwd () {print -Pn $mytitle}
            print -Pn $mytitle
    ;;
esac

bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:warnings' format '%BNo match!'

##########################################
## Completion

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name '' 
zstyle ':completion:*' ignore-parents parent pwd .. 
#zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/daniel/.zshrc'

autoload -Uz compinit
compinit
# The following lines were added by compinstall
# End of lines added by compinstall

setopt APPEND_HISTORY HIST_FCNTL_LOCK HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

setopt CORRECT DVORAK

# pyflakes
export PYTHONPATH="$HOME/.vim/bundle/pyflakes-vim/ftplugin/python/pyflakes"

#####################################
## Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory nomatch notify
unsetopt autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
#
