return {
	-- ## Change AstroNvim plugin defaults
	["famiu/bufdelete.nvim"] = { disable = true },
	["numToStr/Comment.nvim"] = { disable = true },
	["max397574/better-escape.nvim"] = { disable = true },
	["lukas-reineke/indent-blankline.nvim"] = { disable = true },
	["Darazaki/indent-o-matic"] = { disable = true },
	-- ## Colorschemes
	{
		"rebelot/kanagawa.nvim",
		config = require("user.plugins.colorscheme"),
	},
	{
		"luisiacc/gruvbox-baby",
		config = require("user.plugins.colorscheme"),
	},
	{
		"tiagovla/tokyodark.nvim",
		config = require("user.plugins.colorscheme"),
	},
	{
		"catppuccin/nvim",
		config = require("user.plugins.colorscheme"),
	},
	-- ## NeoVim UI/UX improvements
	{
		"projekt0n/circles.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = require("user.plugins.circles"),
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
		config = require("user.plugins.trouble"),
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		module = "zen-mode",
		config = require("user.plugins.zen_mode"),
	},
	{
		"echasnovski/mini.nvim",
		config = require("user.plugins.mini"),
	},
	{ "tpope/vim-repeat" },
	{
		"klen/nvim-test",
		cmd = {
			"TestSuite",
			"TestFile",
			"TestNearest",
			"TestLast",
			"TestVisit",
			"TestEdit",
		},
		config = require("user.plugins.nvim_test"),
	},
	{
		"lukas-reineke/headlines.nvim",
		ft = { "markdown", "rmd" },
		config = function()
			require("headlines").setup({})
		end,
	},
	-- ## Telescope extensions
	{
		"nvim-telescope/telescope-project.nvim",
		after = "telescope.nvim",
		module = "telescope._extensions.project",
		config = function()
			require("telescope").load_extension("project")
		end,
	},
	{
		"nvim-telescope/telescope-packer.nvim",
		after = "telescope.nvim",
		module = "telescope._extensions.packer",
		config = function()
			require("telescope").load_extension("packer")
		end,
	},
	{
		"cljoly/telescope-repo.nvim",
		after = "telescope.nvim",
		module = "telescope._extensions.repo",
		config = function()
			require("telescope").load_extension("repo")
		end,
	},
	-- ## Text Objects/Motions
	{ "bkad/CamelCaseMotion" },
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	},
	{
		"phaazon/hop.nvim",
		cmd = { "HopChar1", "HopChar2", "HopLine", "HopPattern", "HopWord" },
		config = require("user.plugins.hop"),
	},
	-- ## Treesitter additions
	{
		"ziontee113/syntax-tree-surfer",
		module = "syntax-tree-surfer",
		config = require("user.plugins.syntax_tree_surfer"),
	},
	-- ## LSP Additions
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		config = require("user.plugins.lsp-signature"),
	},
	{
		"m-demare/hlargs.nvim",
		after = "nvim-treesitter",
		config = require("user.plugins.hlargs"),
	},
	{
		"onsails/lspkind.nvim",
	},
	{
		"tzachar/compe-tabnine",
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
		event = "InsertEnter",
	},
	-- ## DAP
	{
		"mfussenegger/nvim-dap",
		module = "dap",
		config = require("user.plugins.dap"),
		requires = {
			{
				"rcarriga/nvim-dap-ui",
				after = "nvim-dap",
				config = require("user.plugins.dap_ui"),
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				after = "nvim-dap",
				config = function()
					require("user.plugins.dap_virtual_text")
				end,
			},
			{
				"nvim-telescope/telescope-dap.nvim",
				after = "telescope.nvim",
				module = "telescope._extensions.dap",
				config = function()
					require("telescope").load_extension("dap")
				end,
			},
		},
	},
	-- ## Language Additions
	{
		"simrat39/rust-tools.nvim",
		ft = { "rust" },
		after = { "nvim-lsp-installer" },
		config = require("user.plugins.rust_tools"),
	},
	{
		"Saecki/crates.nvim",
		after = "nvim-cmp",
		event = { "BufRead Cargo.toml" },
		requires = { "plenary.nvim" },
		config = require("user.plugins.crates-nvim"),
	},
	{
		"ray-x/go.nvim",
		ft = { "go" },
		config = require("user.plugins.golang"),
	},
}
