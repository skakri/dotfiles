#
# Basic setup
#

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

setopt appendhistory share_history notify hist_ignore_all_dups hist_ignore_space interactivecomments
unsetopt autocd beep extendedglob nomatch
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename ~/.zshrc

autoload -Uz compinit
compinit

#
# Key setup
#

bindkey -e
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
# note to myself – read keycodes with tput smkx; cat; tput rmkx

# roxterm
bindkey ';5D' emacs-backward-word
bindkey ';5C' emacs-forward-word

# urxvt
bindkey '^[Od' emacs-backward-word
bindkey '^[Oc' emacs-forward-word

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

# roxterm
bindkey ';5A' volume-up 
bindkey ';5B' volume-down

# urxvt
bindkey '^[Oa' volume-up
bindkey '^[Ob' volume-down

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

# roxterm
bindkey ';6D' song-prev
bindkey ';6C' song-next

# urxvt
bindkey '^[[d' song-prev
bindkey '^[[c' song-next

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
export EDITOR=vim
export LESS='-R -N'
export LESSOPEN='|~/.lessfilter %s'

#
# Functions and aliases
#

alias ls='ls --color=auto'

# TODO: Maybe move this to .ttytterrc?
alias ttytter='ttytter -dostream -ssl -ansi -readline -hold'

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

function switch_to_project {
    cd ~/projects/$1
}

function v {
    switch_to_project $1 && . virtualenv/bin/activate
}

function v3 {
    switch_to_project $1 && . virtualenv3/bin/activate
}

function p {
    v $1 && python manage.py shell
}

function p3 {
    v3 $1 && python manage.py shell
}

function activity {
    FULLNAME=$(git config --get user.name)
    git-cal --author=${FULLNAME}
    git-summary
    git-commits-since yesterday
    # pivotal_tools show stories --for=${FULLNAME}
}

function pngsplease {
    mkdir -p converted; rm -fI converted/*.png && find * -type f -print | xargs -i convert {}[0] converted/{}.png && cd converted && feh ./*.png
}

zipedit(){
    echo "Usage: zipedit archive.zip folder/file.txt"
    curdir=$(pwd)
    unzip "$1" "$2" -d /tmp 
    cd /tmp
    vim "$2" && zip --update "$curdir/$1"  "$2" 
    # remove this line to just keep overwriting files in /tmp
    rm -f "$2" # or remove -f if you want to confirm
    cd "$curdir"
}

alias lock='xscreensaver-command -lock'
alias dl='aria2c'
alias spr='google-chrome-unstable --show-paint-rects'

#
# PS + GIT
#

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr 'M' 
zstyle ':vcs_info:*' unstagedstr 'M' 
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats \
  '[%b] %c%u%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git 
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | grep '??' &> /dev/null ; then
    hook_com[unstaged]+='%F{1}??%f'
  fi  
}

precmd () { vcs_info }
PROMPT='%F{5}%F{3}%3~ ${vcs_info_msg_0_}%f%# '

BASE16_SCHEME="monokai"
BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL
