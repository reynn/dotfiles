return function(default_plugins)
	local user_plugins = {
		-- Color Schemes
		{
			"eddyekofo94/gruvbox-flat.nvim",
			-- config = require("user.colors.gruvbox.flat"),
		},
		{
			"sainnhe/gruvbox-material",
			-- config = require("user.colors.gruvbox.material"),
		},
		{
			"luisiacc/gruvbox-baby",
			-- config = require("user.colors.gruvbox.baby"),
		},
		{
			"tiagovla/tokyodark.nvim",
			-- config = require("user.colors.tokyodark"),
		},
		{
			"catppuccin/nvim",
			as = "catppuccin",
			-- config = require("user.colors.catppuccin"),
		},
		{
			"marko-cerovac/material.nvim",
			-- config = require("user.colors.material"),
		},
		-- general vim improvements
		{ "folke/trouble.nvim", cmd = "TroubleToggle" },
		{ "junegunn/vim-easy-align" },
		{ "tpope/vim-repeat" },
		-- { "tpope/vim-surround", keys = { "cs", "ds", "ys" } },
		{ "gpanders/editorconfig.nvim" },
		{
			"dhruvasagar/vim-table-mode",
			cmd = "TableModeToggle",
			setup = require("user.plugins.vim-table"),
		},
		{
			"danymat/neogen",
			module = "neogen",
			cmd = "Neogen",
			config = require("user.plugins.neogen"),
			requires = "nvim-treesitter/nvim-treesitter",
		},
		-- Text objects/Motions
		{ "bkad/CamelCaseMotion" },
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			after = "nvim-treesitter",
		},
		{
			"echasnovski/mini.nvim",
			config = require("user.plugins.mini"),
		},
		-- LSP additions
		{
			"ray-x/lsp_signature.nvim",
			event = "BufRead",
			config = function()
				require("lsp_signature").on_attach()
			end,
		},
		{
			"m-demare/hlargs.nvim",
			config = function()
				require("hlargs").setup({})
			end,
		},
		{ "onsails/lspkind.nvim" },
		-- DAP:
		{
			"mfussenegger/nvim-dap",
			config = require("user.plugins.dap"),
		},
		{
			"rcarriga/nvim-dap-ui",
			after = "nvim-dap",
			config = require("user.plugins.dap_ui"),
		},
		{
			"mfussenegger/nvim-lint",
			config = require("user.plugins.nvim-lint"),
		},
		-- Language specific additions
		{
			"lukas-reineke/headlines.nvim",
			ft = { "markdown", "rmd" },
			config = require("user.plugins.headlines"),
		},
		{
			"ellisonleao/glow.nvim",
			ft = { "markdown", "rmd" },
		},
		{
			"simrat39/rust-tools.nvim",
			requires = {
				"nvim-lspconfig",
				"nvim-lsp-installer",
				"nvim-dap",
				"Comment.nvim",
			},
			ft = { "rust", "rs" },
			config = require("user.plugins.rust-tools"),
		},
		{
			"Saecki/crates.nvim",
			after = "nvim-cmp",
			event = { "BufRead Cargo.toml" },
			config = require("user.plugins.crates-nvim"),
			ft = { "toml" },
		},
		{
			"ray-x/go.nvim",
			config = function()
				require("go").setup({})
			end,
			ft = { "golang", "go" },
		},
		{
			"windwp/nvim-spectre",
			event = "BufRead",
			config = function()
				require("spectre").setup()
			end,
		},
	}

	-- default_plugins["Darazaki/indent-o-matic"] = nil
	-- default_plugins["JoosepAlviste/nvim-ts-context-commentstring"] = nil
	-- default_plugins["numToStr/Comment.nvim"] = nil
	default_plugins["lukas-reineke/indent-blankline.nvim"] = nil

	for _, plugin in pairs(default_plugins) do
		table.insert(user_plugins, plugin)
	end

	return user_plugins
end
