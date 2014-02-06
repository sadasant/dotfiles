xsetroot -cursor_name left_ptr

# setxkbmap -layout es

setxkbmap -option terminate:ctrl_alt_bksp

xbindkeys

# conky | while read -r; do xsetroot -name "$REPLY"; done &""

# dwm clock
while true; do
  xsetroot -name "$(cut -d " " -f 1-3 /proc/loadavg) $(sensors | grep temp1 | cut -d+ -f2 | cut -d. -f1)C$(tmux_battery) $(LANG=eng_US date '+%a %F %R')"
  sleep 1m
done &

exec dwm
