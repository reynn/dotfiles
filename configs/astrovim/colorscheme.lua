local colorscheme_from_plugin = "gruvbox-flat"

local theme_avail, _ = pcall(require, colorscheme_from_plugin)

if theme_avail then
  return colorscheme_from_plugin
else
  return "default_theme"
end
