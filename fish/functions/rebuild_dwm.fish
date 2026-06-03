function rebuild_dwm
    if test -d /tmp/dwm-6.2
        rm -rf /tmp/dwm-6.2
    end

    cp -r "$HOME/Dotcats/suckless/dwm-6.2" /scratch/build
end