-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers

-- Useful Paths
home = os.getenv("HOME")
confdir = home .. "/.config/awesome"
themes = confdir .. "/themes"

-- Choose Your Theme
active_theme = themes .. "/colored"

beautiful.init(active_theme .. "/theme.lua")

terminal = "termite"
editor = os.getenv("EDITOR") or "gvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.

modkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.max,
    awful.layout.suit.fair.horizontal
}-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.

tags = {

    names = { 
		"cmd",
		"www",
		"im",
		"mail",
		"dev",
		"media",
		"vm",
		"doc"
	},

    layout = { layouts[1], layouts[1], layouts[6], layouts[1], 
               layouts[1], layouts[1], layouts[5], layouts[1]


}}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}


-- require files

require("autostart")
require("widgets")

-- Wibox

-- Create a wibox for each screen and add it
mywibox = {}
mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({
        position = "top",
        height=17,
        screen = s
    })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(mpdwidget)
	right_layout:add(weatherwidget)
 	right_layout:add(mygmail)
	right_layout:add(batwidget)
	right_layout:add(hddtemp)
	right_layout:add(volumecfg.widget)
	right_layout:add(datewidget)
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
  	--layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)


--	  Create the bottom wibox
    mybottomwibox[s] = awful.wibox({ 
		position = "bottom",
		screen = s, 
		border_width = 0, 
		height = 20 })
    mybottomwibox[s].visible = false

	bottom_layout = wibox.layout.align.horizontal()
	bottom_layout:set_middle(mytasklist[s])
	mybottomwibox[s]:set_widget(bottom_layout)

end


-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
           -- awful.client.focus.history.previous()
		   awful.client.focus.byidx(-1)
            if client.focus then
                client.focus:raise()
            end
        end),

 -- volume control with amixer with the volumewidget

    awful.key({ }, "XF86AudioRaiseVolume", function () volumecfg.up() end),
    awful.key({ }, "XF86AudioLowerVolume", function () volumecfg.down() end),
    awful.key({ }, "XF86AudioMute", function () volumecfg.toggle() end),


	
 -- my custom keys

    awful.key({ altkey, }, "c", function() awful.util.spawn("google-chrome-beta") end),
    awful.key({ altkey, }, "f", function() awful.util.spawn("firefox") end),
    awful.key({ altkey, }, "2", function() awful.util.spawn("thunar") end),
    awful.key({ altkey, }, "p", function() awful.util.spawn("nice /usr/bin/pidgin") end),
    awful.key({ altkey, }, "g", function() awful.util.spawn("gvim") end),
    awful.key({ altkey, }, "s", function() awful.util.spawn("nice /usr/bin/skype") end),
    awful.key({ altkey, }, "t", function() awful.util.spawn("thunderbird") end),
    awful.key({ altkey, }, "m", function() awful.util.spawn("nice /usr/bin/gmpc") end),
    awful.key({ altkey, "Control" }, "l", function() awful.util.spawn("xscreensaver-command -lock") end),
    awful.key({ }, "Print", function () awful.util.spawn("/home/ilusi0n/.scripts/print") end),
	awful.key({ modkey }, "b", function ()
     mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible
 end),


    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ altkey },"z",function ()awful.util.spawn("/home/ilusi0n/.scripts/touchpad_toggle") end),

	awful.key({ modkey },"r",function ()awful.util.spawn("/home/ilusi0n/.scripts/dmenu_run") end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ "Control",        }, "x",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),

		-- move the focus window to the specific tag

    awful.key({ modkey, "Shift" }, "1",
	function (c)	
		c:tags({screen[mouse.screen]:tags()[1]})
	end),

    awful.key({ modkey, "Shift" }, "2",
	function (c)	
		c:tags({screen[mouse.screen]:tags()[2]})
	end),

    awful.key({ modkey, "Shift" }, "3",
	function (c)	
		c:tags({screen[mouse.screen]:tags()[3]})
	end),

    awful.key({ modkey, "Shift" }, "4",
	function (c)	
		c:tags({screen[mouse.screen]:tags()[4]})
	end),

    awful.key({ modkey, "Shift" }, "5",
	function (c)	
		c:tags({screen[mouse.screen]:tags()[5]})
	end),

    awful.key({ modkey, "Shift" }, "6",
	function (c)	
		c:tags({screen[mouse.screen]:tags()[6]})
	end),

   awful.key({ modkey, "Shift" }, "7",
	function (c)	
		c:tags({screen[mouse.screen]:tags()[7]})
	end),

   awful.key({ modkey, "Shift" }, "8",
	function (c)	
		c:tags({screen[mouse.screen]:tags()[8]})
	end)
	

)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)

require("rules")


-- Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
--[[
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))
--]]
        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) 
				c.border_color = beautiful.border_focus,
				client.focus:raise() 
			 end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

tag.connect_signal("property::layout", function()
        			if (awful.layout.get(mouse.screen) == awful.layout.suit.max) then
            			mybottomwibox[mouse.screen].visible = true
					else
						mybottomwibox[mouse.screen].visible = false
					end
end)

tag.connect_signal("property::selected", function()
        			if (awful.layout.get(mouse.screen) == awful.layout.suit.max) then
            			mybottomwibox[mouse.screen].visible = true
					else
						mybottomwibox[mouse.screen].visible = false
					end
end)


-- }}}
