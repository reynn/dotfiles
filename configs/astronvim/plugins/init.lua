return {
	-- Disable AstroNvim default plugins
	["Darazaki/indent-o-matic"] = { disable = true },
	["numToStr/Comment.nvim"] = { disable = true },
	["lukas-reineke/indent-blankline.nvim"] = { disable = true },
	["neovim/nvim-lspconfig"] = {
		setup = function()
			require("core.utils").defer_plugin("nvim-lspconfig")
		end,
	},
	["williamboman/nvim-lsp-installer"] = {
		opt = true,
		setup = function()
			require("core.utils").defer_plugin("nvim-lsp-installer")
			-- reload the current file so lsp actually starts for it
			vim.defer_fn(function()
				vim.cmd('if &ft == "packer" | echo "" | else | silent! e %')
			end, 0)
		end,
		config = function()
			require("configs.nvim-lsp-installer").config()
			require("configs.lsp")
		end,
	},
	-- Color Schemes
	{ "rebelot/kanagawa.nvim" },
	{ "luisiacc/gruvbox-baby" },
	{ "tiagovla/tokyodark.nvim" },
	{
		"catppuccin/nvim",
		as = "catppuccin",
	},
	-- general vim improvements
	{ "folke/trouble.nvim", cmd = "TroubleToggle" },
	{
		"echasnovski/mini.nvim",
		config = require("user.plugins.mini"),
	},
	{ "junegunn/vim-easy-align" },
	{ "tpope/vim-repeat" },
	{ "gpanders/editorconfig.nvim" },
	{
		"dhruvasagar/vim-table-mode",
		cmd = "TableModeToggle",
		setup = require("user.plugins.vim-table"),
	},
	{
		"nvim-telescope/telescope-project.nvim",
		after = "telescope.nvim",
		config = function()
			require("telescope").load_extension("project")
		end,
		{
			"nvim-telescope/telescope-dap.nvim",
			after = "telescope.nvim",
			config = function()
				require("telescope").load_extension("dap")
			end,
		},
		{
			"nvim-telescope/telescope-packer.nvim",
			after = "telescope.nvim",
			config = function()
				require("telescope").load_extension("packer")
			end,
		},
		{
			"cljoly/telescope-repo.nvim",
			after = "telescope.nvim",
			config = function()
				require("telescope").load_extension("repo")
			end,
		},
	},
	-- Text objects/Motions and TreeSitter enhancements
	{ "bkad/CamelCaseMotion" },
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	},
	{
		"ziontee113/syntax-tree-surfer",
		module = "syntax-tree-surfer",
	},
	-- LSP additions
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
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
		"theHamsta/nvim-dap-virtual-text",
		after = "nvim-dap",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
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
		config = require("user.plugins.glow"),
	},
	{
		"simrat39/rust-tools.nvim",
		ft = { "rust", "rs" },
		config = require("user.plugins.rust-tools"),
	},
	{
		"Saecki/crates.nvim",
		after = "nvim-cmp",
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
}
