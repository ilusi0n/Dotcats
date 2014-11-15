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


if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

# temporary folders
#mkdir -p /tmp/skype_files
#mkdir -p /tmp/cower
mkdir -p /tmp/chrome_cache

# source Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources


eval $(dircolors ~/.dircolors)

PATH=$PATH:~/bin
export PATH

#fonts
#xset +fp /usr/share/fonts/TTF
#xset +fp /usr/share/fonts/misc
#xset +fp /usr/share/fonts/*
#xset fp rehash

#java
wmname LG3D &

ln -s $HOME/.cacheme/spotify $HOME/.cache/spotify
ln -s $HOME/.cacheme/gmpc $HOME/.cache/gmpc
ln -s $HOME/.cacheme/wine $HOME/.cache/wine

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
