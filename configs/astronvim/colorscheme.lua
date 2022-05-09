local colors_available, user_colors = pcall(require, "user.colors")
if not colors_available then
	return "default_theme"
end

local theme_name = user_colors.theme
local theme_available, _ = pcall(require, theme_name)

if theme_available then
	print("Using the '" .. theme_name .. "' theme")
	return theme_name
else
	print("Loading default theme '" .. theme_name .. "' is not available")
	return "default_theme"
end
