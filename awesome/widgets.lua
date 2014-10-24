-- {{{ Required libraries
local gears     = require("gears")
local awful     = require("awful")
awful.rules     = require("awful.rules")
--require("awful.autofocus")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
--local drop      = require("scratchdrop")
local lain      = require("lain")
local vicious   = require("vicious")
-- }}}


-- {{{ Wibox
markup      = lain.util.markup

-- Textclock
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
mytextclock = wibox.widget.textbox()
vicious.register(mytextclock, vicious.widgets.date, markup("#7788af", "%a %b %d, %R "), 60)

-- Weather
weathericon = wibox.widget.imagebox(beautiful.widget_weather)
yawn = lain.widgets.yawn(742676, {
    settings = function()
        widget:set_markup(markup("#eca4c4", forecast:lower() .. ": " .. units .. "°C "))
    end
})

-- Battery
baticon = wibox.widget.imagebox(beautiful.widget_batt)
batwidget = lain.widgets.bat({
    battery="BAT1",
   -- notify="off",
    settings = function()
        if bat_now.perc == "N/A" then
            bat_now.perc = "AC "
        else
            bat_now.perc = bat_now.perc .. "% "
        end
        widget:set_text(bat_now.perc)
    end
})



-- CPU
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)
cpuwidget = lain.widgets.cpu({
    settings = function()
        widget:set_markup(markup("#e33a6e", cpu_now.usage .. "% "))
    end
})
cpuwidget.battery = "BAT1"

-- Coretemp
tempicon = wibox.widget.imagebox(beautiful.widget_temp)
tempwidget = lain.widgets.temp({
    settings = function()
        widget:set_markup(markup("#f1af5f", coretemp_now .. "°C "))
    end
})

-- ALSA volume
volicon = wibox.widget.imagebox(beautiful.widget_vol)
volumewidget = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" then
            widget:set_markup(markup("#FF0000", "Off "))
        else
            widget:set_markup(markup("#7493d2", volume_now.level .. "% "))
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
mpdicon = wibox.widget.imagebox()
mpdwidget = wibox.widget.textbox()
vicious.register(mpdwidget, vicious.widgets.mpd,
    function (mpdwidget, args)
        if args["{state}"] == "Stop" then
            mpdicon:set_image(nil)
            return ""
        else
            mpdicon:set_image(beautiful.widget_note_on)
            return markup("#e54c62", args["{Artist}"] .. ' - ') .. markup("#e33a6e", args["{Title}"])
        end
    end, 3)
