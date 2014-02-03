# Fetch X related settings
xrdb -merge ~/.Xresources

# Awesome
export AWESOME_TERM=urxvt

# Keyboard
setxkbmap -model pc104 -layout lv
setxkbmap -option "compose:menu"
numlockx on &> /dev/null

# Misc.
start-pulseaudio-x11
xbindkeys

# Initialize awesomeness
exec awesome
