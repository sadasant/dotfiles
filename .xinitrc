xsetroot -cursor_name left_ptr

setxkbmap -layout es

setxkbmap -option terminate:ctrl_alt_bksp

# status bar
while true; do
    xsetroot -name "$( date +"%F %R" )"
    sleep 1m
done &

exec dwm
