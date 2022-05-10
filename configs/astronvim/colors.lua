return {
	theme = "gruvbox-baby",
  -- theme = 'tokyodark',
  -- theme = 'catppuccin',
	setup = function(theme_name)
		if theme_name == "catppuccin" then
			require("catppuccin").setup({
				term_colors = true,
				integrations = {
					indent_blankline = {
						enabled = false,
					},
					lsp_trouble = true,
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

			require("lualine").setup({
				options = {
					theme = "catppuccin",
				},
			})
		elseif theme_name == "gruvbox-baby" then
			vim.g.gruvbox_baby_telescope_theme = 1
			vim.g.gruvbox_baby_background_color = "dark"

			vim.g.gruvbox_baby_comment_style = "italic"
			vim.g.gruvbox_baby_function_style = "NONE"
			vim.g.gruvbox_baby_keyword_style = "bold"
			vim.g.gruvbox_baby_variable_style = "NONE"

			require("lualine").setup({
				options = {
					theme = "gruvbox-baby",
				},
			})
		elseif theme_name == "tokyodark" then
			vim.g.tokyodark_enable_italic_comment = true
			vim.g.tokyodark_enable_italic = true
		end
	end,
}
