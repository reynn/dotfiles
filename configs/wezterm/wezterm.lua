local wezterm = require("wezterm")

return {
  exit_behavior = "CloseOnCleanExit",
  font = wezterm.font({
    family = "Hasklug Nerd Font",
  }),
  font_size = 16.0,
  freetype_load_target = "HorizontalLcd",
  color_scheme = "kanagawabones",
  initial_cols = 170, -- 80
  initial_rows = 40, -- 24
  -- window_decorations = "NONE",
}
