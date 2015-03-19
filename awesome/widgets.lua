-- {{{ Required libraries
local awful     = require("awful")
awful.rules     = require("awful.rules")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local lain      = require("lain")
local vicious   = require("vicious")
-- }}}


gray = "#858585"
white = "#DDDCFF"
ORANGE = "#ff8c00"
LIGHT_GREEN = "#76EE00"
PURPLE = "#BF5FFF"
LIGHT_BLUE = "#7DC1CF"
BLUE   = "#00BFFF"

-- {{{ Wibox
markup = lain.util.markup


separator = wibox.widget.textbox()
separator:set_markup (markup(gray, "aasasafs "))


-- Textclock
mytextclock = awful.widget.textclock(markup(LIGHT_GREEN, "%a %b %d, %R "))


-- Weather
yawn = lain.widgets.yawn(742676, {
    settings = function()
        widget:set_markup(markup(BLUE, forecast:lower() .. ": " .. units .. "°C "))
    end
})

-- Battery
batwidget = lain.widgets.bat({
    battery="BAT1",
   -- notify="off",
    settings = function()
        if bat_now.perc == "100" then
            bat_now.perc = ""
        else
            bat_now.perc = "Bat: " .. bat_now.perc .. "% "
        end
        widget:set_markup(markup(ORANGE,bat_now.perc))
    end
})



-- CPU
cpuwidget = lain.widgets.cpu({
    settings = function()
        widget:set_markup(markup(PURPLE, "CPU " .. cpu_now.usage .. "% "))
    end
})

-- Coretemp
tempwidget = lain.widgets.temp({
    settings = function()
        widget:set_markup(markup(ORANGE, "T: " .. coretemp_now .. "°C "))
    end
})

-- ALSA volume
volumewidget = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" then
            widget:set_markup(markup("#FF0000", "Vol: Off "))
        else
            widget:set_markup(markup("#7493d2", "Vol: " .. volume_now.level .. "% "))
        end
    end
})

volumewidget:buttons(awful.util.table.join(
    awful.button({ }, 4, function () 
        awful.util.spawn("ponymix -d 0 increase 5")
        volumewidget.update()
 end),
    awful.button({ }, 5, function ()
        awful.util.spawn("ponymix -d 0 decrease 5")
        volumewidget.update()
 end),
    awful.button({ }, 1, function ()
        awful.util.spawn("ponymix -d 0 toggle")
        volumewidget.update()
 end)
    ))


-- MPD
mpdwidget = wibox.widget.textbox()
vicious.register(mpdwidget, vicious.widgets.mpd,
    function (mpdwidget, args)
        if args["{state}"] == "Stop" then
            return ""
        else
            return markup("#e54c62", args["{Artist}"] .. ' - ') .. markup("#e33a6e", args["{Title}"])
        end
    end, 3)
