local wezterm = require("wezterm")
local lume = require("utils.lume")
local M = {}
M.default_colors = {
	date_fg = "#d65d0e",
	date_bg = "#1d2021",
	battery_fg = "#e7d7ad",
	battery_bg = "#1d2021",
	separator_fg = "#7fa2ac",
	separator_bg = "#1d2021",
}

M.separator_char = "┃ "

M.cells = {} -- wezterm FormatItems (ref: https://wezfurlong.org/wezterm/config/lua/wezterm/format.html)

---@param text string
---@param icon string
---@param fg string
---@param bg string
---@param separate boolean
M.push = function(text, icon, fg, bg, separate)
	table.insert(M.cells, { Foreground = { Color = fg } })
	table.insert(M.cells, { Background = { Color = bg } })
	table.insert(M.cells, { Attribute = { Intensity = "Bold" } })
	table.insert(M.cells, { Text = icon .. " " .. text .. " " })

	if separate then
		table.insert(M.cells, { Foreground = { Color = M.colors.separator_fg } })
		table.insert(M.cells, { Background = { Color = M.colors.separator_bg } })
		table.insert(M.cells, { Text = M.separator_char })
	end

	table.insert(M.cells, "ResetAttributes")
end

M.set_date = function()
	local date = wezterm.strftime(" %a %H:%M")
	M.push(date, "", M.colors.date_fg, M.colors.date_bg, true)
end

M.set_battery = function()
	-- ref: https://wezfurlong.org/wezterm/config/lua/wezterm/battery_info.html
	local discharging_icons = { "", "", "", "", "", "", "", "", "", "" }
	local charging_icons = { "", "", "", "", "", "", "", "", "", "" }

	local charge = ""
	local icon = ""

	for _, b in ipairs(wezterm.battery_info()) do
		local idx = lume.clamp(lume.round(b.state_of_charge * 10), 1, 10)
		charge = string.format("%.0f%%", b.state_of_charge * 100)

		if b.state == "Charging" then
			icon = charging_icons[idx]
		else
			icon = discharging_icons[idx]
		end
	end

	M.push(charge, icon, M.colors.battery_fg, M.colors.battery_bg, false)
end

M.setup = function(colors)
	wezterm.on("update-right-status", function(window, _)
		M.colors = colors or M.default_colors
		M.cells = {}
		M.set_date()
		M.set_battery()

		window:set_right_status(wezterm.format(M.cells))
	end)
end

return M
