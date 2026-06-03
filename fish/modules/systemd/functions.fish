function start_user
    systemctl --user daemon-reload
    systemctl --user start "$argv[1].service"
    systemctl --user status "$argv[1].service"
end

function restart_user
    systemctl --user daemon-reload
    systemctl --user restart "$argv[1].service"
    systemctl --user status "$argv[1].service"
end

function stop_user
    systemctl --user daemon-reload
    systemctl --user stop "$argv[1].service"
    systemctl --user status "$argv[1].service"
end

function status_user
    systemctl --user status "$argv[1].service"
end

function enable_user
    systemctl --user enable "$argv[1].service"
end

function disable_user
    systemctl --user disable "$argv[1].service"
end

function reload_user
    systemctl --user daemon-reload
end

function listd
    ls -l /etc/systemd/system/multi-user.target.wants
end

#aliases