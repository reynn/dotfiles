-- ###### ####################################
-- ###### Vim Settings
-- ###### ####################################

-- General Vim settings
vim.opt.foldmethod = "syntax"

-- ###### ####################################
-- ###### LunarVim Settings
-- ###### ####################################

-- General LunarVim settings
lvim.format_on_save = true
lvim.log.level = "warn"
lvim.colorscheme = "gruvbox-flat"
lvim.leader = "\\"

-- Ensure the builtin plugins we want are turned on
lvim.builtin.lualine.active = true
lvim.builtin.dap.active = true
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.bufferline.active = true

-- Set overrides for LunarVims builtin plugin configuration
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"css",
	"fish",
	"go",
	"graphql",
	"java",
	"javascript",
	"json",
	"json5",
	"lua",
	"python",
	"rust",
	"toml",
	"yaml",
}

-- ###### ####################################
-- ###### Keymappings
-- ###### ####################################

-- #### WhichKey mappings (invoked initially with <leader>)
lvim.builtin.which_key.vmappings["t"] = {
	name = "Text",
	["a"] = {
		name = "Align",
		[" "] = { ":EasyAlign *\\ <CR>", "EasyAlign: Align on all ` ` character" },
		[","] = { ":EasyAlign *,<CR>", "EasyAlign: Align on all `,` character" },
		["-"] = { ":EasyAlign *-<CR>", "EasyAlign: Align on all `-` character" },
		["="] = { ":EasyAlign *=<CR>", "EasyAlign: Align on all `=` character" },
		["l"] = { ":EasyAlign<CR>", "EasyAlign: Live Mode" },
	},
}
-- lvim.builtin.which_key.vmappings["/"] = {  }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
	name = "Trouble",
	["d"] = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
	["f"] = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	["l"] = { "<cmd>Trouble loclist<cr>", "LocationList" },
	["q"] = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	["r"] = { "<cmd>Trouble lsp_references<cr>", "References" },
	["w"] = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

-- ###### ####################################
-- ###### Language Settings
-- ###### ####################################

-- ###### Python settings ######
lvim.lang.python.formatters = { { exe = "black" } }
lvim.lang.python.linters = { { exe = "flake8" } }

-- ###### Golang additions ######
lvim.lang.go.formatters = { { exe = "gofmt" } }

-- ###### JSON settings ######
lvim.lang.json.formatters = { { exe = "prettier" } }

-- ###### Lua settings ######
lvim.lang.lua.formatters = { { exe = "stylua" } }

-- ###### Rust additions ######
lvim.lang.rust.formatters = { { exe = "rustfmt" } }

-- ###### YAML additions ######
lvim.lang.yaml.formatters = { { exe = "prettier" } }

-- ###### ####################################
-- ###### Plugins
-- ###### ####################################

-- ###### Additional Plugins ######
lvim.plugins = {
	{ "https://github.com/andymass/vim-matchup" },
	{ "https://github.com/bkad/CamelCaseMotion" },
	{ "https://github.com/eddyekofo94/gruvbox-flat.nvim" },
	{ "https://github.com/folke/trouble.nvim" },
	{ "https://github.com/junegunn/vim-easy-align" },
	{ "https://github.com/michaeljsmith/vim-indent-object" },
	{ "https://github.com/tpope/vim-commentary" },
	{ "https://github.com/tpope/vim-repeat" },
	{ "https://github.com/tpope/vim-surround" },
	{ "https://github.com/vim-scripts/argtextobj.vim" },
	{
		"https://github.com/ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").on_attach()
		end,
		event = "BufRead",
	},
	{
		"https://github.com/simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({
				tools = {
					autoSetHints = true,
					hover_with_actions = true,
					runnables = {
						use_telescope = true,
					},
				},
				server = {
					cmd = { os.getenv("HOME") .. "/.bins/envs/rust-analyzer" },
					on_attach = require("lsp").common_on_attach,
					on_init = require("lsp").common_on_init,
				},
			})
		end,
		ft = { "rust", "rs" },
	},
}
