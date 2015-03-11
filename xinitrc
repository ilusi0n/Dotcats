#!/bin/sh
#
# ~/.xinitrc

#------EXPORTS---#
export GDK_USE_XFT=1
export QT_XFT=true
export GTK2_RC_FILES="/etc/gtk-2.0/gtkrc:$HOME/.gtkrc-2.0"
export QT_STYLE_OVERRIDE=gtk
export EDITOR=vim
export PULSE_LATENCY_MSEC=60
export DE="gnome"


if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# source Xresources
xrdb -merge $HOME/.Xresources &> /dev/null

#colors for terminal and stuff
eval $(dircolors ~/.dircolors)

# local bin
PATH=$PATH:~/bin
export PATH

#java
wmname LG3D &

#persistent cache
ln -s $HOME/.cacheme/spotify $HOME/.cache/spotify
ln -s $HOME/.cacheme/gmpc $HOME/.cache/gmpc
ln -s $HOME/.cacheme/wine $HOME/.cache/wine

#settings for gtk3
~/bin/gtk3settings &

#composition fix
compton --backend glx --paint-on-overlay --vsync opengl-swc &

WM="awesome"

case "$WM" in
    dwm)
        $HOME/.dotcats/dwm/dwm_start.sh &
        exec dbus-launch dwm
        ;;
    wmfs)
        $HOME/.config/wmfs/autostart &
        exec wmfs
        ;;
    awesome)
        exec awesome
        ;;
esac
