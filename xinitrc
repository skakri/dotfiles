# Fetch X related settings
xrdb -merge ~/.Xresources

# Awesome
export AWESOME_TERM=urxvt

# Keyboard
setxkbmap -model pc104 -layout lv
setxkbmap -option "compose:menu"
numlockx on &> /dev/null

# CapsLock to backspace
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keycode 66 = BackSpace"

# Misc.
start-pulseaudio-x11
xbindkeys
eval $(ssh-agent)

# Initialize awesomeness
exec awesome
