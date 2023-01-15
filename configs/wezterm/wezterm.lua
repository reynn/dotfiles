local wezterm = require("wezterm")
-- local kanagawa = require("colors.kanagawa")
local gruvbox_baby = require("colors.gruvbox-baby")
require("config.notify").setup()
require("config.tab-title").setup()
require("config.right-status").setup()

local font_name = "Hasklug Nerd Font"

local function font(name, params)
  return wezterm.font(name, params)
end

return {
  automatically_reload_config = true,
  -- colors = kanagawa,
  colors = gruvbox_baby,
  exit_behavior = "CloseOnCleanExit",
  font = wezterm.font({
    family = font_name,
  }),
  font_size = 16.0,
  freetype_load_target = "HorizontalLcd",
  hide_tab_bar_if_only_one_tab = false,
  inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
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
    active_titlebar_bg = "#090909",
    font = font(font_name, { bold = true }),
    font_size = 10,
  },
  window_padding = {
    left = 5,
    right = 10,
    top = 12,
    bottom = 12,
  },
}
