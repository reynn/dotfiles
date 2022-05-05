return function()
	vim.g.gruvbox_baby_telescope_theme = 1
	-- vim.g.gruvbox_baby_transparent_mode = 1
	vim.g.gruvbox_baby_background_color = "dark"

	vim.g.gruvbox_baby_comment_style = "NONE"
	vim.g.gruvbox_baby_function_style = "NONE"
	vim.g.gruvbox_baby_keyword_style = "standout"
	vim.g.gruvbox_baby_variable_style = "NONE"

	require("lualine").setup({
		options = {
			theme = "gruvbox-baby",
		},
	})
end
