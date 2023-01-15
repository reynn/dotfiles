local wezterm = require("wezterm")

return {
  setup = function()
    wezterm.on("window-config-reloaded", function(window, pane)
      window:toast_notification("wezterm", "configuration reloaded!", nil, 4000)
    end)
  end,
}
