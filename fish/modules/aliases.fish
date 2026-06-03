#---------#
# Aliases #
#---------#

function pcinfo
    inxi -Fxz
end

function brokenLinks
    find . -type l -not -exec test -e {} \; -print
end

function assoc
    code ~/.local/share/applications/mimeapps.list
end

function highErrors
    journalctl -p 0..3 -xn
end

function updateFontconfig
    fc-cache -vf
end

function rollback
    git reset --hard HEAD
end

function logX
    journalctl -k -b -1
end

function getsub
    subberthehut -s -a -l por,pob
end

function rm
    trash-put $argv
end

function grep
    command grep --color=auto $argv
end

function ls
    exa -l --icons $argv
end

function sudo
    command sudo $argv
end

function cacheclean
    paccache -rk2
end

function check
    chkrootkit
end

function checkme
    rkhunter --update -c
end

function fail
    systemctl --failed
end

function services
    systemctl list-unit-files | grep enabled
end

function size
    du -sh $argv[1]
end

function updateXresources
    xrdb ~/.Xresources
end

function checkMemoryLeak
    valgrind --tool=memcheck
end

function zombies
    ps -el | grep "Z"
end

function top
    htop
end

function wasteSpace
    ncdu -x --color off --exclude-kernfs -r
end

function myBirth
    stat / | grep Birth
end

function myip
    curl curlmyip.com
end

function pk
    killall -9 $argv[1]
end

function cpuspeed
    watch grep "cpu MHz" /proc/cpuinfo
end

function tmpfs
    sudo mount -t tmpfs -o defaults,noatime,mode=1777 tmpfs $argv[1]
end

function fan
    sudo isw -s 0x72 80
end

function dmesg
    journalctl --dmesg -o short-monotonic --no-hostname --no-pager
end

function vim
    nvim $argv
end

function cat
    bat $argv
end

function auracle
    command auracle -C /scratch/build $argv
end

function ccm
    sudo ccm
end

function removeUnusedVolumes
    docker volume prune --filter all=1
end

function dup
    docker-compose up -d --remove-orphans
end

function wl-poweroff
    sudo /usr/bin/iw dev wlo1 set power_save off
end

function startx
    command startx -- -keeptty > /tmp/xorg.log 2>&1
end

function mount_windows_data
    sudo mount /dev/sdb2 /home/lanikai/Data_Windows
end

function cp
    rsync -HAXhaxvPS --numeric-ids --stats $argv
end

function audio-config
    pavucontrol
end

function mount-external-disk
    sudo mount -t xfs /dev/sdc $HOME/externaldisk
end

function latex-compile
    $HOME/.scripts/docker-latex $argv[1]
end