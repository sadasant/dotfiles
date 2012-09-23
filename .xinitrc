xsetroot -cursor_name left_ptr

setxkbmap -layout es

setxkbmap -option terminate:ctrl_alt_bksp

# status bar
while true; do
    xsetroot -name " $( date +"%F")  $(uptime | awk '{print $1"  "$4"u  "$8$9$10}')"
    sleep 1s
done &

exec dwm
