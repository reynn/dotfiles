local wezterm = require("wezterm")

local font_name = "Hasklug Nerd Font"
local color_scheme_name = "Gruvbox Material (Gogh)"
local color_scheme = wezterm.color.get_builtin_schemes()[color_scheme_name]

require("config.notify").setup()
-- require("config.tab-title").setup(theme.tab_title)
require("config.right-status").setup({
	date_fg = color_scheme.foreground,
	date_bg = color_scheme.background,
	battery_fg = color_scheme.ansi[1],
	battery_bg = color_scheme.ansi[3],
	separator_fg = color_scheme.cursor_fg,
	separator_bg = color_scheme.background,
})

return {
	automatically_reload_config = true,
	color_scheme = color_scheme_name,
	exit_behavior = "CloseOnCleanExit",
	font = wezterm.font({
		family = font_name,
	}),
	font_size = 16.0,
	freetype_load_target = "HorizontalLcd",
	hide_tab_bar_if_only_one_tab = true,
	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = 1.0,
	},
	initial_cols = 170, -- 80
	initial_rows = 40, -- 24
	tab_max_width = 25,
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
	show_tab_index_in_tab_bar = true,
	switch_to_last_active_tab_when_closing_tab = true,
	use_fancy_tab_bar = true,
	window_background_opacity = 1.0,
	window_frame = {
		active_titlebar_bg = color_scheme.background,
		inactive_titlebar_fg = color_scheme.foreground,
		font = wezterm.font(font_name, { bold = true }),
		font_size = 12,
	},
	window_padding = {
		left = 5,
		right = 10,
		top = 12,
		bottom = 12,
	},
}
