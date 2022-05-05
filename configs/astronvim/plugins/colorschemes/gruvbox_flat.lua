return function()
	vim.g.gruvbox_flat_style = "dark"
	vim.g.gruvbox_sidebars = { "qf", "vista_kind", "terminal", "packer" }
	vim.g.gruvbox_italic_functions = true

	require("lualine").setup({
		options = {
			theme = "gruvbox-flat",
		},
	})
end
