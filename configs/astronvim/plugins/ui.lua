return {
	astronvim.plugin({ "luisiacc/gruvbox-baby" }),
	astronvim.plugin({
		"rebelot/kanagawa.nvim",
		config = function(_, _)
			require("kanagawa").setup({
				dimInactive = true,
				globalStatus = true,
			})
		end,
	}),
	astronvim.plugin({
		"projekt0n/circles.nvim",
		lazy = false,
		config = function(_, _)
			require("circles").setup({})
		end,
	}),
	astronvim.plugin({
		"m-demare/hlargs.nvim",
		after = "nvim-treesitter",
		event = "BufEnter",
		config = function()
			require("hlargs").setup({})
		end,
	}),
	astronvim.plugin({
		"lvimuser/lsp-inlayhints.nvim",
		event = "BufEnter",
		config = function()
			require("lsp-inlayhints").setup({})
		end,
	}),
}
