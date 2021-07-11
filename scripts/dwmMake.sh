#!/bin/bash
DIRECTORY=/tmp/dwm-6.0
if [ -d "$DIRECTORY" ]; then
    rm -rf $DIRECTORY
fi
cp -r "$HOME/Dotcats/dwm-6.0" /tmp/
exit 0
