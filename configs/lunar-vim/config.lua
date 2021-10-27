-- ###### ####################################
-- ###### Vim Settings
-- ###### ####################################

-- General Vim settings
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

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

lvim.builtin.terminal.execs = { { "lg", "gg", "LazyGit" } }
-- Set overrides for LunarVims builtin plugin configuration
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.hide_dotfiles = 0
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
		["|"] = { ":EasyAlign *|<CR>", "EasyAlign: Align on all `|` character" },
		["l"] = { ":LiveEasyAlign<CR>", "EasyAlign: Live Mode" },
	},
}

lvim.builtin.which_key.mappings["T"] = {
  name = "Telescope",
  ["p"] = { ":Telescqope projects<CR>", "Projects" },
  ["r"] = { ":Telescqope runnables<CR>", "Runnables" },
}

-- More easily view document diagnostics
lvim.builtin.which_key.mappings["t"] = {
	name = "Trouble",
	["d"] = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
	["f"] = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	["l"] = { "<cmd>Trouble loclist<cr>", "LocationList" },
	["q"] = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	["r"] = { "<cmd>Trouble lsp_references<cr>", "References" },
	["w"] = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}
-- Session management with Persistence
lvim.builtin.which_key.mappings["S"]= {
  name = "Session",
  c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

-- ###### ####################################
-- ###### Plugins
-- ###### ####################################
-- ###### Additional Plugins ######
lvim.plugins = {
	{ "https://github.com/bkad/CamelCaseMotion" },
	{ "https://github.com/eddyekofo94/gruvbox-flat.nvim" },
	{ "https://github.com/folke/trouble.nvim", cmd = "TroubleToggle" },
	{ "https://github.com/junegunn/vim-easy-align" },
	{ "https://github.com/michaeljsmith/vim-indent-object" },
	{ "https://github.com/tpope/vim-commentary" },
	{ "https://github.com/tpope/vim-repeat" },
	{ "https://github.com/tpope/vim-surround", keys = {"c", "d", "y"} },
	{ "https://github.com/vim-scripts/argtextobj.vim" },
  { "https://github.com/p00f/nvim-ts-rainbow" },
  {
    "https://github.com/tzachar/compe-tabnine",
    run = "./install.sh",
    event = "InsertEnter",
  },
	{
		"https://github.com/ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").on_attach()
		end,
	},
  {
    "https://github.com/folke/persistence.nvim",
    event = "VimEnter",
    module = "persistence",
    config = function()
      require("persistence").setup {
        dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      }
    end,
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
          cmd = { vim.fn.stdpath "data" .. "/lspinstall/rust/rust-analyzer" },
        },
      })
    end,
    ft = { "rust", "rs" },
  },
  {
    "https://github.com/ray-x/go.nvim",
    config = function()
      require('go').setup({})
    end,
    ft = { "golang", "go" },
  }
}
