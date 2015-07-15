-- {{{ Required libraries
local awful     = require("awful")
awful.rules     = require("awful.rules")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local vicious   = require("vicious")
-- }}}


-- colours
coldef  = "</span>"
orange = "<span color='#ffa500'>"
lightblue = "<span color='#7DC1CF'>"
blue = "<span foreground='#1793d1'>"
white  = "<span color='#cdcdcd'>"
red  = "<span color='#ff0000'>"
brown = "<span color='#db842f'>"
fuchsia = "<span color='#800080'>"
gold = "<span color='#e7b400'>"
yellow = "<span color='#e0da37'>"
purple = "<span color='#e33a6e'>"
lightpurple = "<span color='#eca4c4'>"
azure = "<span color='#80d9d8'>"
green = "<span color='#87af5f'>"
lightgreen = "<span color='#62b786'>"

sep = wibox.widget.textbox(" ")

-- Textclock
datewidget = wibox.widget.textbox()
    vicious.register(datewidget, vicious.widgets.date, lightgreen ..  "%a %b %d, %R " ..
    coldef, 60)



-- Battery

local function dispinfo()
    local f, infos
    local capi = {
        mouse = mouse,
        screen = screen
    }

    f = io.popen("acpi -b")
    infos = f:read("*all")
    f:close()

    showbatinfo = naughty.notify( {
        --  title   = "Battery infos (acpi -V)",
        text    = infos,
        timeout = 0,
        screen  = capi.mouse.screen })
    end

    batwidget = wibox.widget.textbox()
    vicious.register(batwidget, vicious.widgets.bat,
    function(widget, args)
        if args[1]=="-" and args[2]<=15 then
            return red .. args[2] .."%" .. coldef .. purple .. " : " .. coldef
        end
        if (args[1]=="-") or (args[1]=="+" and args[2]<94) then
            return white .. args[2] .. "%" .. coldef .. purple .. " : " .. coldef
        else
            return ""
        end
    end, 61, "BAT0")

    batwidget:connect_signal("mouse::enter", function() dispinfo() end)
    batwidget:connect_signal("mouse::leave", function() naughty.destroy(showbatinfo) end)



-- weather

weatherwidget = wibox.widget.textbox()
vicious.register(weatherwidget, vicious.widgets.weather,
function (widget, args)
    return azure .. args["{sky}"] ..", " .. args["{tempc}"] .. "°C" .. coldef .. purple .. " : " .. coldef
end, 1800, "LPPT")


-- HDD temperature widget

hddtemp = wibox.widget.textbox()
vicious.register(hddtemp, vicious.widgets.thermal,
function (widget, args)
    if args[1] > 0 then
        return orange .. args[1] .. "C°" ..  coldef .. purple .. " :" .. coldef
    else return "" 
    end
end
, 19, "thermal_zone0")



-- MPD
mpdwidget = wibox.widget.textbox()
-- Register widget
vicious.register(mpdwidget, vicious.widgets.mpd,
    function (mpdwidget, args)
        if args["{state}"] == "Stop" then 
            return ""
        else 
            return lightgreen .. " mpd: " .. args["{Artist}"]..' - '.. args["{Title}"] .. coldef
        end
    end, 3)


-- Create a battery widget
batwidget = wibox.widget.textbox()
function getBatteryStatus()
   local fd= io.popen("~/.scripts/bat.sh")
   local status = fd:read()
   fd:close()
   return status
end