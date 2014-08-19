Installation steps
==================
Grab `dotfiles` from pypi (via pip)
`dotfiles -C /path/to/.dotfilesrc --sync`

Awesome:
* grab git submodules
* install [base16-shell](https://github.com/chriskempson/base16-shell)
* add `xrdb -merge ~/.Xresources` to .xinitrc
* symlink desired wallpaper to ~/.config/awesome/current-wallpaper
* set AWESOME_TERM environment variable to desired terminal emulator (defaults
to xterm) in .xinitrc
* relog / restart awesome.

Changes from environment defaults
=================================
Awesome:
* Modifier key - left Alt

Other personalization tweaks
============================
.xinitrc:
    setxkbmap -model pc104 -layout lv
    setxkbmap -option "compose:menu"


## Current theme:
![Current theme](https://github.com/skakri/dotfiles/raw/master/screenshot.png "")
