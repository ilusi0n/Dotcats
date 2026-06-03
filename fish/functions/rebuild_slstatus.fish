function rebuild_slstatus
    if test -d /tmp/slstatus
        rm -rf /tmp/slstatus
    end

    cp -r "$HOME/Dotcats/suckless/slstatus" /scratch/build
end