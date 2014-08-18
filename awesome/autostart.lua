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

run_once("xscreensaver -no-splash")
run_once("wicd-client --tray")
run_once("thunar --daemon")
run_once("ibus-daemon -s -x -d")

awful.util.spawn_with_shell("feh --bg-scale /mnt/Data/Wallpapers/v3/wallpaper-114539.jpg")
awful.util.spawn_with_shell("sudo /home/ilusi0n/.scripts/powersaving AC")
run_once("/home/ilusi0n/.scripts/touchpad_toggle")
run_once("/home/ilusi0n/.scripts/drop_start")
