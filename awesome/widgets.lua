wibox           = require("wibox")
beautiful       = require("beautiful")
vicious         = require("vicious")
awful           = require("awful")
naughty         = require("naughty")

confdir = home .. "/.config/awesome"

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

-- Initialize widget
mpdwidget = wibox.widget.textbox()
-- Register widget
vicious.register(mpdwidget, vicious.widgets.mpd,
    function (mpdwidget, args)
        if args["{state}"] == "Stop" then 
            return ""
        else 
            return lightgreen .. args["{Artist}"]..' - '.. args["{Title}"] .. coldef .. purple .. " : " .. coldef
        end
    end, 3)

-- battery widget

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
        --	title	= "Battery infos (acpi -V)",
        text	= infos,
        timeout	= 0,
        screen	= capi.mouse.screen })
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

    -- date widget

    datewidget = wibox.widget.textbox()
    vicious.register(datewidget, vicious.widgets.date, lightgreen ..  "%a %b %d, %R " ..
    coldef, 60)

    -- weather widget

    weatherwidget = wibox.widget.textbox()
    vicious.register(weatherwidget, vicious.widgets.weather,
    function (widget, args)
        return azure .. args["{sky}"] ..", " .. args["{tempc}"] .. "°C" .. coldef .. purple .. " : " .. coldef
    end, 1800, "LPPT")
    --'1800': check every 30 minutes.
    --'LPPT': the Lisbon ICAO code.

    -- separator

    separator = wibox.widget.textbox()
    separator:set_markup (purple .. " : " .. coldef)


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



    -- Gmail widget

    mygmail = wibox.widget.textbox()
    vicious.register(mygmail, vicious.widgets.gmail,
    function (widget, args)
        return blue .. args["{count}"] .. " mail(s)" ..  coldef .. purple .. " : " .. coldef 
    end, 120) 
    --the '120' here means check every 2 minutes.


    -- Volume widget
    volumecfg = {}
    volumecfg.cardid  = 0
    volumecfg.channel = "Master"
    volumecfg.widget = wibox.widget.textbox()

    -- command must start with a space!
    volumecfg.mixercommand = function (command)
        local fd = io.popen("amixer -c " .. volumecfg.cardid .. command)
        local status = fd:read("*all")
        fd:close()
        local volume = string.match(status, "(%d?%d?%d)%%")
        volume = string.format("% 3d", volume)
        status = string.match(status, "%[(o[^%]]*)%]")
        if string.find(status, "on", 1, true) then
            volume = lightblue .. " Vol" .. volume .. "%" .. coldef .. purple .. " : " .. coldef
        else
            volume = lightblue .. " Vol" .. coldef .. red .. " off" .. coldef .. purple .. " : " .. coldef
        end

        volumecfg.widget:set_markup(volume)
    end
    volumecfg.update = function ()
        volumecfg.mixercommand(" sget " .. volumecfg.channel)
    end
    volumecfg.up = function ()
        volumecfg.mixercommand(" sset " .. volumecfg.channel .. " 2%+")
    end
    volumecfg.down = function ()
        volumecfg.mixercommand(" sset " .. volumecfg.channel .. " 2%-")
    end
    volumecfg.toggle = function ()
        volumecfg.mixercommand(" sset " .. volumecfg.channel .. " toggle")
    end
    volumecfg.mute = function ()

        volumecfg.mixercommand(" sset " .. volumecfg.channel .. " unmute")
    end
    volumecfg.widget:buttons(awful.util.table.join(
    awful.button({ }, 4, function () volumecfg.up() end),
    awful.button({ }, 5, function () volumecfg.down() end),
    awful.button({ }, 1, function () volumecfg.toggle() end)

    ))
    volumecfg.update()


    -- Calendar attached to the datewidget
    local os = os
    local string = string
    local table = table
    local util = awful.util

    char_width = nil
    text_color = theme.fg_normal or "#FFFFFF"
    today_color = theme.tasklist_fg_focus or "#FF7100"
    calendar_width = 21

    local calendar = nil
    local offset = 0

    local data = nil

    local function pop_spaces(s1, s2, maxsize)
        local sps = ""
        for i = 1, maxsize - string.len(s1) - string.len(s2) do
            sps = sps .. " "
        end
        return s1 .. sps .. s2
    end
    
    local function create_calendar()
        offset = offset or 0

        local now = os.date("*t")
        local cal_month = now.month + offset
        local cal_year = now.year
        if cal_month > 12 then
            cal_month = (cal_month % 12)
            cal_year = cal_year + 1
        elseif cal_month < 1 then
            cal_month = (cal_month + 12)
            cal_year = cal_year - 1
        end

        local last_day = os.date("%d", os.time({ day = 1, year = cal_year,
        month = cal_month + 1}) - 86400)
        local first_day = os.time({ day = 1, month = cal_month, year = cal_year})
        local first_day_in_week =
        os.date("%w", first_day)
        local result = "Su Mo Tu We Th Fr Sa\n"
        for i = 1, first_day_in_week do
            result = result .. "   "
        end

        local this_month = false
        for day = 1, last_day do
            local last_in_week = (day + first_day_in_week) % 7 == 0
            local day_str = pop_spaces("", day, 2) .. (last_in_week and "" or " ")
            if cal_month == now.month and cal_year == now.year and day == now.day then
                this_month = true
                result = result ..
                string.format('<span weight="bold" foreground = "%s">%s</span>',
                today_color, day_str)
            else
                result = result .. day_str
            end
            if last_in_week and day ~= last_day then
                result = result .. "\n"
            end
        end

        local header
        if this_month then
            header = os.date("%a, %d %b %Y")
        else
            header = os.date("%B %Y", first_day)
        end
        return header, string.format('<span font="%s" foreground="%s">%s</span>',
        theme.font, text_color, result)
    end

    local function calculate_char_width()
        return beautiful.get_font_height(theme.font) * 0.555
    end

    function hide()
        if calendar ~= nil then
            naughty.destroy(calendar)
            calendar = nil
            offset = 0
        end
    end

    function show(inc_offset)
        inc_offset = inc_offset or 0

        local save_offset = offset
        hide()
        offset = save_offset + inc_offset

        local char_width = char_width or calculate_char_width()
        local header, cal_text = create_calendar()
        calendar = naughty.notify({ title = header,
        text = cal_text,
        timeout = 0, hover_timeout = 0.5,
    })
end

function add_calendar(t_out)
    hide()
    local char_width = char_width or calculate_char_width()
    local header, cal_text = create_calendar()
    calendar = naughty.notify({ title = header,
    text = cal_text,
    timeout = t_out,
})
end

datewidget:connect_signal("mouse::enter", function() show(0) end)
datewidget:connect_signal("mouse::leave", hide)
datewidget:buttons(util.table.join( awful.button({ }, 1, function() show(-1) end),
awful.button({ }, 3, function() show(1) end)))
