xsetroot -cursor_name left_ptr

# setxkbmap -layout es

setxkbmap -option terminate:ctrl_alt_bksp

xbindkeys

# conky | while read -r; do xsetroot -name "$REPLY"; done &""

# dwm clock
while true; do
   xsetroot -name "$(LANG=eng_US date '+%a %F %R')"
   sleep 1m
done &

exec dwm
