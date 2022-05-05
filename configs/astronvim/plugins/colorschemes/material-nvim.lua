return function()
	require("material").setup({
		lualine_style = "stealth",
	})
	vim.g.material_style = "darker"

	require("lualine").setup({
		options = {
			theme = "material",
		},
	})
end
