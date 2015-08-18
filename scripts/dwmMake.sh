#!/bin/bash
DIRECTORY=/tmp/dwm
if [ -d "$DIRECTORY" ]; then
    rm -rf $DIRECTORY
fi
cp -r "$HOME/.dotcats/dwm" /tmp/
exit 0
