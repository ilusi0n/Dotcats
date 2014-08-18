
-- {{{ Main

theme = {}

theme.confdir = os.getenv("HOME") .. "/.config/awesome/themes/colored"

--theme.font      = "Terminus 9"
theme.font      = "Source Code Pro Medium 8"
--theme.font = "DejaVu Sans 8"

-- Colours

blue = "#1793d1"
light_blue = "#7DC1CF"
white  = "#cdcdcd"
black = "#000000"
red = "#ff0000"
gray = "#a6a6a6"
orange = "#ff8c00"

theme.bg_normal     = black
theme.bg_focus      = black
theme.bg_urgent     = black
theme.bg_minimize   = black

theme.fg_normal     = gray
theme.fg_focus      = blue
theme.fg_urgent     = red
theme.fg_minimize   = blue

theme.border_width  = "1"
theme.border_normal = black
theme.border_focus  = blue
theme.border_marked = "#91231c"


-- {{{ Menu

theme.menu_height       = "8"
theme.menu_width        = "105"
theme.menu_border_width = "0"
theme.menu_fg_normal    = "#aaaaaa"   --color txt pip
theme.menu_fg_focus     = "#7788af"
theme.menu_bg_normal    = "#080808"   --background menu
theme.menu_bg_focus     = "#080808"

-- }}}

-- {{{ Taglist

theme.taglist_squares_sel   = theme.confdir .. "/taglist/squaref_b.png"
theme.taglist_squares_unsel = theme.confdir .. "/taglist/square_b.png"

-- }}}

-- {{{ Misc

theme.tasklist_floating_icon = theme.confdir .. "/floating.png"

-- }}}



-- {{{ Layout

theme.layout_tile       = theme.confdir .. "/layouts/tile.png"
theme.layout_tileleft   = theme.confdir .. "/layouts/tileleft.png"
theme.layout_tilebottom = theme.confdir .. "/layouts/tilebottom.png"
theme.layout_tiletop    = theme.confdir .. "/layouts/tiletop.png"
theme.layout_fairv      = theme.confdir .. "/layouts/fairv.png"
theme.layout_fairh      = theme.confdir .. "/layouts/fairh.png"
theme.layout_spiral     = theme.confdir .. "/layouts/spiral.png"
theme.layout_dwindle    = theme.confdir .. "/layouts/dwindle.png"
theme.layout_max        = theme.confdir .. "/layouts/max.png"
theme.layout_fullscreen = theme.confdir .. "/layouts/fullscreen.png"
theme.layout_magnifier  = theme.confdir .. "/layouts/magnifier.png"
theme.layout_floating   = theme.confdir .. "/layouts/floating.png"

-- }}}

return theme
