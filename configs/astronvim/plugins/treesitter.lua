return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"lua",
				"go",
				"java",
				"rust",
				"python",
				"fish",
				"bash",
				"json",
				"yaml",
				"toml",
			},
		},
	},
	{
		"ziontee113/syntax-tree-surfer",
		config = function()
			require("syntax-tree-surfer").setup({
				highlight_group = "HopNextkey",
			})
		end,
		module = "syntax-tree-surfer",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "BufEnter",
		after = "nvim-treesitter",
	},
}
