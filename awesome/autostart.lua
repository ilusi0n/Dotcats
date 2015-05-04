local awful = require("awful")

-- {{{ Autostart programs (runs only once)

function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

run_once("xautolock -time 5 -locker 'i3lock -c 111111' -corners 0-+0  -cornerdelay 4 -cornerredelay 4")
--run_once("thunar --daemon")
run_once("ibus-daemon -s -x -d")
run_once("/usr/bin/start-pulseaudio-x11")
run_once("pcmanfm -d")
run_once("/usr/lib/lxpolkit/lxpolkit")
run_once("thunderbird")
--run_once("xpad")

awful.util.spawn_with_shell("feh --bg-scale /mnt/Data/Wallpapers/v3/fmd3Lk1.jpg")
--awful.util.spawn_with_shell("sudo /home/ilusi0n/.scripts/powersaving AC")
run_once("/home/ilusi0n/.scripts/touchpad_toggle")
run_once("/home/ilusi0n/.scripts/drop_start")
