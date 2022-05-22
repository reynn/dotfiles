return function()
	local curr_theme = require("user").colorscheme

	if curr_theme == "kanagawa" then
		require("kanagawa").setup({
			dimInactive = true,
			globalStatus = true,
		})
	elseif curr_theme == "gruvbox-baby" then
		vim.g.gruvbox_baby_telescope_theme = 1
		vim.g.gruvbox_baby_background_color = "medium"

		vim.g.gruvbox_baby_comment_style = "italic"
		vim.g.gruvbox_baby_function_style = "bold,italic"
		vim.g.gruvbox_baby_keyword_style = "bold"
		vim.g.gruvbox_baby_variable_style = "standout"
	elseif curr_theme == "tokyodark" then
		vim.g.tokyodark_enable_italic_comment = true
		vim.g.tokyodark_enable_italic = true
	elseif curr_theme == "catppuccin" then
		require("catppuccin").setup({
			term_colors = true,
			integrations = {
				indent_blankline = {
					enabled = false,
				},
				lsp_trouble = false,
				neotree = {
					enabled = true,
				},
				nvimtree = {
					enabled = false,
				},
				telescope = true,
				ts_rainbow = true,
				which_key = true,
			},
		})
	else
		print("UNEXPECTED COLORSCHEME")
	end
end
