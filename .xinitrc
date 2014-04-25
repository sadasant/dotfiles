xsetroot -cursor_name left_ptr

# setxkbmap -layout es

setxkbmap -option terminate:ctrl_alt_bksp

xbindkeys

conky # conky | while read -r; do xsetroot -name "$REPLY"; done &""


# /tmp/dwm_system_info = sensors + tmux_battery + clock
while true; do
  echo "$(sensors | grep temp1 | cut -d+ -f2 | cut -d. -f1)C$(tmux_battery alarm) $(LANG=eng_US date '+%a %F %R')" > /tmp/dwm_system_info
  sleep 30s
done &

# dwm message at the top-right
while true; do
  song="", artist="", mocp_out=""
  if [ "$(pidof mocp)" ]; then
    song=$(mocp -Q "%song")
    song=${song::20}
    artist=$(mocp -Q "%artist")
    artist=${artist::20}
    mocp_out="[$song by $artist] "
  fi
  xsetroot -name "$mocp_out$(cut -d " " -f 1,4 /proc/loadavg) $(cat /tmp/dwm_system_info)"
  sleep 1s
done &

exec dwm
