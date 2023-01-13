return {
	{ "luisiacc/gruvbox-baby" },
	{
		"rebelot/kanagawa.nvim",
		config = function(_, _)
			require("kanagawa").setup({
				dimInactive = true,
				globalStatus = true,
			})
		end,
	},
	{
		"projekt0n/circles.nvim",
		lazy = false,
		config = function(_, _)
			require("circles").setup({})
		end,
	},
	{
		"m-demare/hlargs.nvim",
		after = "nvim-treesitter",
		event = "BufEnter",
		config = function()
			require("hlargs").setup({})
		end,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		event = "BufEnter",
		config = function()
			require("lsp-inlayhints").setup({})
		end,
	},
}
