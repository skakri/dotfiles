theme = {}

theme.font          = "xos4 Terminus 9"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#666666"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#111111"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#efefef"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#666666"

theme.border_width  = "1"
theme.border_normal = "#373832"
theme.border_focus  = "#75715e"
theme.border_marked = "#91231c"
theme.textbox_widget_margin_top = 1
theme.awful_widget_height = 14
theme.awful_widget_margin_top = 2
theme.useless_gap_width = "0"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "~/.config/awesome/squarefw.png"
theme.taglist_squares_unsel = "~/.config/awesome/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_height = 20
theme.menu_width  = 120

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

theme.wallpaper = "~/.config/awesome/current-wallpaper"

icon_dir = os.getenv("HOME") .. "/.config/awesome/icons/"

theme.layout_tile = icon_dir .. "tile.png"
theme.layout_tilegaps = icon_dir .. "tilegaps.png"
theme.layout_tileleft = icon_dir .. "tileleft.png"
theme.layout_tilebottom = icon_dir .. "tilebottom.png"
theme.layout_tiletop = icon_dir .. "tiletop.png"
theme.layout_fairv = icon_dir .. "fairv.png"
theme.layout_fairh = icon_dir .. "fairh.png"
theme.layout_spiral = icon_dir .. "spiral.png"
theme.layout_dwindle = icon_dir .. "dwindle.png"
theme.layout_max = icon_dir .. "max.png"
theme.layout_fullscreen = icon_dir .. "fullscreen.png"
theme.layout_magnifier = icon_dir .. "magnifier.png"
theme.layout_floating = icon_dir .. "floating.png"

theme.layout_uselesstile = icon_dir .. "tile.png"
theme.layout_uselesstileleft = icon_dir .. "tileleft.png"
theme.layout_uselesstilebottom = icon_dir .. "tilebottom.png"

theme.awesome_icon = icon_dir .. "awesome19.png"
theme.widget_mem = icon_dir .. "mem.png"
theme.arrl = icon_dir .. "arrl.png"
theme.arrl_dl = icon_dir .. "arrl_dl.png"
theme.arrl_ld = icon_dir .. "arrl_ld.png"

theme.widget_ac = icon_dir .. "ac.png"
theme.widget_battery = icon_dir .. "battery.png"
theme.widget_battery_low = icon_dir .. "battery_low.png"
theme.widget_battery_empty = icon_dir .. "battery_empty.png"
theme.widget_mem = icon_dir .. "mem.png"
theme.widget_cpu = icon_dir .. "cpu.png"
theme.widget_temp = icon_dir .. "temp.png"
theme.widget_net = icon_dir .. "net.png"
theme.widget_hdd = icon_dir .. "hdd.png"
theme.widget_music = icon_dir .. "note.png"
theme.widget_music_on = icon_dir .. "note_on.png"
theme.widget_vol = icon_dir .. "vol.png"
theme.widget_vol_low = icon_dir .. "vol_low.png"
theme.widget_vol_no = icon_dir .. "vol_no.png"
theme.widget_vol_mute = icon_dir .. "vol_mute.png"
theme.widget_mail = icon_dir .. "mail.png"
theme.widget_mail_on = icon_dir .. "mail_on.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
