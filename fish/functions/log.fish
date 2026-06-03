function log
    dmesg | sed '/UFW/d' | grep "$argv"
end