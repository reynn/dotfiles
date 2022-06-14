return {
	-- ## Colorschemes
	{ "rebelot/kanagawa.nvim" },
	{ "luisiacc/gruvbox-baby" },
	{ "tiagovla/tokyodark.nvim" },
	{ "catppuccin/nvim" },
	-- ## NeoVim UI/UX improvements
	{
		"projekt0n/circles.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("circles").setup()
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		module = "zen-mode",
	},
	{ "echasnovski/mini.nvim" },
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
	},
	-- ## Telescope extensions
	{
		"nvim-telescope/telescope-project.nvim",
		after = "telescope.nvim",
		config = function()
			require("telescope").load_extension("project")
		end,
	},
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
	-- ## Text Objects/Motions
	{ "bkad/CamelCaseMotion" },
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	},
	{
		"ziontee113/syntax-tree-surfer",
		module = "syntax-tree-surfer",
	},
	-- ## LSP Additions
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
	},
	{
		"m-demare/hlargs.nvim",
		after = "nvim-treesitter",
	},
	{ "onsails/lspkind.nvim" },
	{
		"tzachar/compe-tabnine",
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
		event = "InsertEnter",
	},
	-- ## DAP
	{ "mfussenegger/nvim-dap" },
	{
		"rcarriga/nvim-dap-ui",
		after = { "nvim-dap" },
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		after = "nvim-dap",
	},
	-- ## Language Additions
	{
		"simrat39/rust-tools.nvim",
		after = { "nvim-lspconfig" },
	},
	{
		"Saecki/crates.nvim",
		after = "nvim-cmp",
		event = { "BufRead Cargo.toml" },
	},
	{ "ray-x/go.nvim" },
}
