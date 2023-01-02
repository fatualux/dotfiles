enable_xauth=0

setxkbmap it &
numlockx &

hsetroot -solid "#000000"


xrdb -load ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

syndaemon -i 0.5 -d -K
xset b off

exec i3

#load this to have gtk2 apps look ok
GSDPID=pidof gnome-settings-daemon
if [  "x$GSDPID" == "x" ]; then
gnome-settings-daemon &
fi
