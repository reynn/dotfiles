local lvim = {}
-- ###### ####################################
-- ###### Plugins
-- ###### ####################################
-- ###### Additional Plugins ######
lvim.plugins = {
	{ "bkad/CamelCaseMotion" },
	{ "eddyekofo94/gruvbox-flat.nvim" },
	{ "folke/trouble.nvim", cmd = "TroubleToggle" },
	{ "junegunn/vim-easy-align" },
	{ "michaeljsmith/vim-indent-object" },
	{ "tpope/vim-repeat" },
	{ "tpope/vim-surround", keys = { "cs", "ds", "ys" } },
	{ "vim-scripts/argtextobj.vim" },
	{ "gpanders/editorconfig.nvim" },
	{ "p00f/nvim-ts-rainbow" },
	{
		"tzachar/compe-tabnine",
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
		event = "InsertEnter",
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").on_attach()
		end,
	},
	{
		"simrat39/rust-tools.nvim",
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
					cmd = { vim.fn.stdpath("data") .. "/lspinstall/rust/rust-analyzer" },
				},
			})
		end,
		ft = { "rust", "rs" },
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

-- ###### ####################################
-- ###### Vim Settings
-- ###### ####################################

-- General Vim settings
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.relativenumber = true
vim.opt.conceallevel = 2

-- ###### ####################################
-- ###### LunarVim Settings
-- ###### ####################################

-- General LunarVim settings
lvim.leader = "\\"
lvim.format_on_save = true
lvim.colorscheme = "gruvbox-flat"
lvim.log.level = "warn"

-- Ensure the builtin plugins we want are turned on
lvim.builtin.lualine.active = true
lvim.builtin.dap.active = true
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.bufferline.active = true

lvim.builtin.terminal.execs = { { "lg", "<leader>gg", "LazyGit" } }
-- Set overrides for LunarVims builtin plugin configuration
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.git.enable = true
lvim.builtin.nvimtree.setup.filters.dotfiles = false
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"fish",
	"go",
	"java",
	"json",
	"lua",
	"python",
	"rust",
	"toml",
	"yaml",
}
lvim.lsp.automatic_servers_installation = true

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
		["|"] = { ":EasyAlign *|<CR>", "EasyAlign: Align on all `|` character" },
		["l"] = { ":LiveEasyAlign<CR>", "EasyAlign: Live Mode" },
	},
}

lvim.builtin.which_key.mappings["r"] = {
	name = "Replace",
	["t"] = { ":lua require('spectre').open()<CR>", "(Spectre) Use spectre to find and replace text" },
	["w"] = {
		":lua require('spectre').open_visual({select_word=true})<CR>",
		"(Spectre) Use spectre to find and replace text",
	},
	["f"] = { "viw:lua require('spectre').open_file_search()<CR>", "(Spectre) Use spectre to find and replace text" },
}

-- Telescope selectors
lvim.builtin.which_key.mappings["T"] = {
	name = "Telescope",
	["p"] = { ":Telescope projects<CR>", "Projects" },
	["r"] = { ":Telescope runnables<CR>", "Runnables" },
	["c"] = { ":Telescope colorscheme<CR>", "Color Schemes" },
}

-- More easily view document diagnostics
lvim.builtin.which_key.mappings["t"] = {
	name = "Trouble",
	["t"] = { "<cmd>TroubleToggle<cr>", "Trouble" },
	["w"] = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Workspace diagnostics" },
	["d"] = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "Document diagnostics" },
	["r"] = { "<cmd>TroubleToggle lsp_references<cr>", "Symbol References" },
	["q"] = { "<cmd>TroubleToggle quickfix<cr>", "QuickFix list" },
	["l"] = { "<cmd>TroubleToggle loclist<cr>", "Location List" },
}

lvim.autocommands.custom_groups = {
	-- On entering a lua file, set the tab spacing and shift width to 8
	{ "BufWinEnter", "*.go", "setlocal ts=4 sw=4" },

	-- On entering insert mode in any file, scroll the window so the cursor line is centered
	{ "InsertEnter", "*", ":normal zz" },
}
