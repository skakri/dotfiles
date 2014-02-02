#!/bin/zsh

#
# History
#

export HISTSIZE=5000
export HISTFILE="$HOME/.zsh_history"

export SAVEHIST=$HISTSIZE
setopt inc_append_history   # Commit to histfile after executing
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history        # Shared history

#
# Key setup
#

typeset -A key
key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# Control+larr/rarr
bindkey ';5D' emacs-backward-word
bindkey ';5C' emacs-forward-word

export WORDCHARS=''

#
# Shift+uarr/darr volume control
#

function volume-up {
    amixer set Master 2%+ -q
}

function volume-down {
    amixer set Master 2%- -q
}

zle -N volume-up
zle -N volume-down
bindkey ';5A' volume-up
bindkey ';5B' volume-down

# TODO: split out Master/MPD volume controls?

#
# Shift+larr/rarr prev/next song (MPD)
#

function song-prev {
    mpc prev --quiet
}

function song-next {
    mpc next --quiet
}
zle -N song-prev
zle -N song-next

bindkey ';6D' song-prev
bindkey ';6C' song-next

#
# Language settings
#

LANG=lv_LV.UTF-8
export LC_ALL=lv_LV.utf8

#
# Environment variables and quirks
#

export JAVA_HOME=/opt/java
export PYCHARM_JDK=/opt/java/jre
export PERL_LOCAL_LIB_ROOT="$HOME/perl5";
export PERL_MB_OPT="--install_base $HOME/perl5";
export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5";
export PERL5LIB="$HOME/perl5/lib/perl5/x86_64-linux-thread-multi:$HOME/perl5/lib/perl5";
export PATH="$HOME/perl5/bin:$HOME/.gem/ruby/2.0.0/bin:$HOME/bin:$PATH";
export EDITOR=nano

#
# Functions and aliases
#

function wlan1-30dbm {
    sudo iw reg set BO
    sudo iwconfig wlan1 txpower 30
}

function rand-ident {
    hostname
    sudo hostname `pwgen -A -0 10 1`
    hostname
    macchanger -s wlan1
    sudo macchanger -r wlan1
}

alias lock="xscreensaver-command -lock"
alias dl="aria2c"
