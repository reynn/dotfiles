return {
	colorscheme = "kanagawa",
	diagnostics = {
		virtual_text = true,
		underline = true,
	},
	polish = function()
		require("user.custom.autocmds")
		require("user.custom.mappings")
	end,
	ui = {
		nui_input = true,
		telescope_select = true,
	},
}
