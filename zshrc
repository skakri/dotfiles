#
# Basic setup
#

[[ -r ${HOME}/.zshrc.pre ]] && source ${HOME}/.zshrc.pre

# Load autocompletion files.

for f in ~/.config/autocompletion/*; do
    . "$f"
done

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

setopt appendhistory share_history notify hist_ignore_all_dups hist_ignore_space interactivecomments
unsetopt autocd beep extendedglob nomatch
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename ~/.zshrc
zstyle ':completion:*' rehash true

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
# Volume controls.
#
# control-up            Volume +2%
# control-down          Volume -2%
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

#
# Spotify controls.
#
# control-shift-down    Play/Pause
# control-shift-left    Previous song
# control-shift-right   Next song
#

function song-prev {
    dbus-send --session --type=method_call --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
}

function song-next {
    dbus-send --session --type=method_call --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next
}

function song-play-pause {
    dbus-send --session --type=method_call --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
}
zle -N song-prev
zle -N song-next
zle -N song-play-pause

# roxterm
bindkey ';6D' song-prev
bindkey ';6C' song-next

# urxvt
bindkey '^[[d' song-prev
bindkey '^[[c' song-next
bindkey '^[[b' song-play-pause

#
# Other zsh line editor macros.
#

insert-sudo () {
    zle beginning-of-line; zle -U "sudo "
}

zle -N insert-sudo
bindkey "^@" insert-sudo  # Control + Space.

#
# Plugins
#

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#
# Other software
#

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Autoenv
[[ -x /usr/share/autoenv-git/activate.sh ]] && source /usr/share/autoenv-git/activate.sh

# virtualenvwrapper project home.
export PROJECT_HOME=~/projects

#
# Language settings
#

LANG=lv_LV.UTF-8
export LC_ALL=lv_LV.utf8

#
# Environment variables and quirks
#

#export _JAVA_AWT_WM_NONREPARENTING=1
export PYCHARM_JDK=/opt/java/jre
export PERL_LOCAL_LIB_ROOT="$HOME/perl5";
export PERL_MB_OPT="--install_base $HOME/perl5";
export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5";
export PERL5LIB="$HOME/perl5/lib/perl5/x86_64-linux-thread-multi:$HOME/perl5/lib/perl5";
export PATH="$HOME/perl5/bin:$HOME/bin:$PATH";
export EDITOR=vim
export LESS='-R -N'
export LESSOPEN='|~/.lessfilter %s'

# yaourt/zsh fix? https://github.com/archlinuxfr/yaourt/issues/11#issuecomment-44888428
ttyctl -f

#
# File type handling.
#

alias -s zip=dtrx
alias -s tar=dtrx
alias -s tar.gz=dtrx
alias -s tar.bz2=dtrx
alias -s xz=dtrx
alias -s rar=dtrx

#
# Functions and aliases
#

alias ls='ls --color=auto'
alias info='pinfo'
alias bc='bc -lq'
alias rdate='TZ="Europe/Riga" date'
alias reset++='echo -e "\e<"; reset; stty sane; tput rs1; clear; echo -e "\033c"'

function b {
    iptables -I INPUT -s "$1" -j DROP;
}

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

function activate_project {
    [[ -x /usr/bin/virtualenvwrapper.sh ]] && source /usr/bin/virtualenvwrapper.sh && workon $1
}

function v {
    switch_to_project $1 && activate_project $1
}

function p {
    v $1 && python manage.py shell
}

function cy { # check yourself before you wreck yourself
    flake8 --max-complexity 8 $1
}

function pngsplease {
    mkdir -p converted; rm -fI converted/*.png; find * -type f -print | xargs -i convert {}[0] converted/{}.png && cd converted && feh ./*.png
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

function man {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

function f {
    grep --color=auto -iR "$1" $2
}

 streaming() {
    INRES="1920x1080"
    OUTRES="1920x1080"
    FPS="60" # target FPS
    GOP="120" # i-frame interval, should be double of FPS, 
    GOPMIN="60" # min i-frame interval, should be equal to fps, 
    THREADS="4" # max 6
    CBR="2000k" # constant bitrate (should be between 1000k - 3000k)
    QUALITY="ultrafast"  # one of the many FFMPEG preset
    AUDIO_RATE="44100"
    STREAM_KEY="$1" # use the terminal command Streaming streamkeyhere to stream your video to twitch or justin
    SERVER="live-prg" # see http://bashtech.net/twitch/ingest.php for list

    ffmpeg -f x11grab -s "$INRES" -r "$FPS" -i :0.0 -f pulse -i default -f flv -ac 2 -ar $AUDIO_RATE \
    -vcodec libx264 -g $GOP -keyint_min $GOPMIN -b $CBR -minrate $CBR -maxrate $CBR -pix_fmt yuv420p\
    -s $OUTRES -preset $QUALITY -tune film -acodec libmp3lame -threads $THREADS -strict normal \
    -bufsize $CBR "rtmp://$SERVER.twitch.tv/app/$STREAM_KEY"
 }

alias lock='xscreensaver-command -lock'
alias dl='aria2c'
alias spr='google-chrome-unstable --show-paint-rects'
alias noblank='xset -dpms; xset s off'
alias blank='xset +dpms; xset s on'

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
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    PROMPT="remote // $HOST $PROMPT"
fi

BASE16_SCHEME="monokai"
BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

[[ -r ${HOME}/.zshrc.local ]] && source ${HOME}/.zshrc.local

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
