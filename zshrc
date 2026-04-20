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

# kitty
bindkey '^[[1;5D' emacs-backward-word
bindkey '^[[1;5C' emacs-forward-word

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

# kitty
bindkey '^[[1;5A' volume-up
bindkey '^[[1;5B' volume-down

#
# Spotify controls.
#
# control-shift-down    Play/Pause
# control-shift-left    Previous song
# control-shift-right   Next song
#

function song-info {
	[[ -o zle ]] && zle -R
	echo
	sleep 0.2 # Delay for songs to switch, probably there's a better option
	
	dbus-send --session --type=method_call --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | awk '
		/string  *"xesam:artist/{
			while (1) {
				getline line
				if (line ~ /string "/){
					sub(/.*string "/, "", line)
					sub(/".*$/, "", line)
					print line
					break
				}
			}
		}
		/string  *"xesam:title/{
			while (1) {
				getline line
				if (line ~ /string "/){
					sub(/.*string "/, "", line)
					sub(/".*$/, "", line)
					print line
					break
				}
			}
		}
	'
	zle redisplay
}

function song-prev {
    dbus-send --session --type=method_call --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous && song-info
}

function song-next {
    dbus-send --session --type=method_call --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next && song-info
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

# kitty (shift-left, ..)
bindkey '^[[1;2D' song-prev
bindkey '^[[1;2C' song-next
bindkey '^[[1;2B' song-play-pause

# Git
function run-tig () {
    tig <$TTY; zle redisplay;
}
zle -N run-tig
bindkey '^[\' run-tig

# kitty
bindkey '^_' run-tig

# Misc
function d2 {
    python -c "print('int: {0:d}\nhex: 0x{0:x}\nbin: 0b{0:b}'.format($1))"
}

function d2b {
    python -c "print('0b{0:b}'.format($1))"
}

function d2h {
    python -c "print('0x{0:x}'.format($1))"
}

function h2a {
    echo "$@" | xxd -r -p
}

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

if [ -r "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
elif [ -r "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Bright zsh syntax-highlighting overrides for dark kitty themes
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#9ece6a,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#e0af68,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#7dcfff,underline'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#bb9af7,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#7aa2f7'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#7aa2f7'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#6b7280'


#
# Language settings
#

LANG=lv_LV.UTF-8
export LC_ALL=lv_LV.utf8

#
# Environment variables and quirks
#

export EDITOR=vim
# Keep line numbers visible without letting the gutter dominate the content.
export LESS='-R -N --use-color -DN241 -DP-'
# Keep man pages at their formatted width; a line-number gutter makes them wrap.
export MANPAGER='less -R -n'
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

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

alias ls='ls --color=auto'
alias info='pinfo'
alias bc='bc -lq'
alias rdate='TZ="Europe/Riga" date'
alias reset++='echo -e "\e<"; reset; stty sane; tput rs1; clear; echo -e "\033c"'

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

[[ -r ${HOME}/.zshrc.local ]] && source ${HOME}/.zshrc.local

export PATH="$HOME/.bun/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi
