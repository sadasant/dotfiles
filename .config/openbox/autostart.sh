# This shell script is run before Openbox launches.
# Environment variables set here are passed to the Openbox session.

setxkbmap es &

python ~/code/arch/alsa.py &

xfce4-power-manager &

nitrogen --restore &

#tint2 &

# (sleep 4s && nm-applet) &

if egrep -iq 'touchpad' /proc/bus/input/devices; then
  synclient VertEdgeScroll=1 &
  synclient TapButton1=1 &
fi

xscreensaver -no-splash &

(sleep 3s && conky -q) &

#(sleep 3s && volwheel) &

python2 ~/.config/openbox/xdg-menu-xml &

# xpad &
