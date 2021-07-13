#!/bin/bash
DIRECTORY=/tmp/dwm-6.2
if [ -d "$DIRECTORY" ]; then
    rm -rf $DIRECTORY
fi
cp -r "$HOME/Dotcats/suckless/dwm-6.2" /tmp/
exit 0
