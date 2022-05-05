return function()
	require("catppuccin").setup({
		integrations = {
			ts_rainbow = true,
			lsp_trouble = true,
		},
	})

	require("lualine").setup({
		options = {
			theme = "catppuccin",
		},
	})
end
