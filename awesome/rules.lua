local awful = require("awful")
awful.rules = require("awful.rules")
local beautiful = require("beautiful")


-- {{{ Rules
	awful.rules.rules = {
		-- All clients will match this rule.
		{ rule = { },
			properties = {
                border_width = beautiful.border_width,
				border_color = beautiful.border_normal,
                --focus = awful.client.focus.filter,
				keys = clientkeys,
				size_hints_honor = false,
				buttons = clientbuttons 
        } },
		{ rule = { instance = "Google-chrome-stable" },
			properties = { tag = tags[1][2], border=0} },
        { rule = { instance = "crx_nckgahadagoaajjgafhacjanaoiihapd" },
			properties = { tag = tags[1][3], border=0 } },
		{ rule = { class = "Firefox" },
			properties = { tag = tags[1][2], border=0 } },
        { rule = { class = "Aurora" },
			properties = { tag = tags[1][2], border=0 } },
		{ rule = { class = "Skype" },
			properties = { tag = tags[1][3] } },
        { rule = { class = "Viber" },
			properties = { tag = tags[1][3] } },
		{ rule = { class = "Pidgin" },
			properties = { tag = tags[1][3] } },
		{ rule = { class = "Thunderbird" },
			properties = { tag = tags[1][4] } },
		{ rule = { class = "Gmpc" },
			properties = { tag = tags[1][6] } },
		{ rule = { class = "VirtualBox" },
			properties = { tag = tags[1][7] } },
		{ rule = { class = "Thunar" },
			properties = { tag = tags[1][6] } },
        { rule = { class = "Pcmanfm" },
			properties = { tag = tags[1][6] } },
		{ rule = { class = "Mplayer" },
			properties = { tag = tags[1][6], floating = true } },
		{ rule = { class = "File-roller" },
			properties = { tag = tags[1][6] } },
		{ rule = { class = "Qbittorrent" },
			properties = { tag = tags[1][6] } },
		{ rule = { class = "Eclipse" },
			properties = { tag = tags[1][5] } },
		{ rule = { class = "Gummi" },
			properties = { tag = tags[1][6] } },
		{ rule = { class = "Evince" },
			properties = { tag = tags[1][8] } },
		{ rule = { class = "Steam" },
			properties = { tag = tags[1][7] } },
		{ rule = { instance = "plugin-container" },
        		properties = { floating = true } },
	}

