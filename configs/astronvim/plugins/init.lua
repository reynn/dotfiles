local plugin_configs = require("user.plugins.configs")

local plugins = {
	-- ## Change AstroNvim plugin defaults
	["famiu/bufdelete.nvim"] = { disable = true },
	["numToStr/Comment.nvim"] = { disable = true },
	["max397574/better-escape.nvim"] = { disable = true },
	["lukas-reineke/indent-blankline.nvim"] = { disable = true },
	["Darazaki/indent-o-matic"] = { disable = true },

	-- -- ## Colorschemes
	{ "rebelot/kanagawa.nvim" },
	{ "luisiacc/gruvbox-baby" },
	{ "catppuccin/nvim", as = "catppuccin" },

	-- -- ## NeoVim UI/UX improvements
	{
		"projekt0n/circles.nvim",
		config = function()
			require("circles").setup({})
		end,
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
	},
	{
		"lukas-reineke/headlines.nvim",
		config = function()
			require("headlines").setup({})
		end,
		ft = { "markdown", "rmd" },
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = plugin_configs.mason_tool_installer,
	},
	{
		"echasnovski/mini.nvim",
		config = plugin_configs.mini,
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
		config = plugin_configs.trouble,
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		config = plugin_configs.zen_mode,
		module = "zen-mode",
	},
	{ "junegunn/vim-easy-align" },
	{ "tpope/vim-repeat" },

	-- -- ## Telescope extensions
	{
		"nvim-telescope/telescope-packer.nvim",
		after = "telescope.nvim",
		config = function()
			require("telescope").load_extension("packer")
		end,
		module = "telescope._extensions.packer",
	},
	{
		"nvim-telescope/telescope-project.nvim",
		after = "telescope.nvim",
		config = function()
			require("telescope").load_extension("project")
		end,
		module = "telescope._extensions.project",
	},
	{
		"cljoly/telescope-repo.nvim",
		after = "telescope.nvim",
		config = function()
			require("telescope").load_extension("repo")
		end,
		module = "telescope._extensions.repo",
	},

	-- -- ## Text Objects/Motions
	{ "bkad/CamelCaseMotion" },
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	},

	-- -- ## Treesitter additions
	{
		"ziontee113/syntax-tree-surfer",
		config = plugin_configs.tree_surfer,
		module = "syntax-tree-surfer",
	},

	-- -- ## LSP Additions
	{
		"m-demare/hlargs.nvim",
		after = "nvim-treesitter",
		config = function()
			require("hlargs").setup({})
		end,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		config = function()
			require("lsp-inlayhints").setup({})
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		config = plugin_configs.lsp_signature,
		event = "BufRead",
	},

	-- -- ## Language Additions
	{
		"simrat39/rust-tools.nvim",
		config = plugin_configs.rust_tools,
		ft = { "rust" },
	},
	{
		"Saecki/crates.nvim",
		after = "nvim-cmp",
		config = plugin_configs.rust_crates,
		event = { "BufRead Cargo.toml" },
		requires = { "plenary.nvim" },
	},
	{
		"ray-x/go.nvim",
		config = plugin_configs.golang,
		ft = { "go" },
	},
	-- {
	-- 	"tzachar/cmp-tabnine",
	-- 	after = "nvim-cmp",
	-- 	config = plugin_configs.cmp_tabnine,
	-- 	run = "./install.sh",
	-- },
	{ "hashivim/vim-terraform" },
	{ "terrastruct/d2-vim" },
}

return plugins
