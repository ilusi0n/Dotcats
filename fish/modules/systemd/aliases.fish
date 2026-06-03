function sys_start
    sudo systemctl start "$argv[1].service"
    sudo systemctl status "$argv[1].service"
end

function sys_restart
    sudo systemctl restart "$argv[1].service"
    sudo systemctl status "$argv[1].service"
end

function sys_stop
    sudo systemctl stop "$argv[1].service"
    sudo systemctl status "$argv[1].service"
end

function sys_status
    sudo systemctl status "$argv[1].service"
end

function sys_enable
    sudo systemctl enable "$argv[1].service"
end

function sys_disable
    sudo systemctl disable "$argv[1].service"
end

function fail
    systemctl --failed
end

function services
    systemctl list-unit-files | grep enabled
end

function high_errors
    journalctl -p 0..3 -xn
end