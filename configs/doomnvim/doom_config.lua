-- doom_config - Doom Nvim user configurations file
--
-- This file contains the user-defined configurations for Doom nvim and consists
-- in two Lua tables:
--   1. Doom, this one defines all the Doom nvim configurations that you can
--      tweak to fit your needs or tastes.
--
--   2. Nvim, this one defines all the custom configurations that you want to
--      use in Neovim, e.g. a colorscheme italic_comments global variable

local M = {}

M.source = debug.getinfo(1, "S").source:sub(2)

M.config = {
	doom = {
		freeze_dependencies = true,
		autosave = true,
		fmt_on_save = true,
		disable_macros = false,
		use_netrw = false,
		foldenable = true,
		autosave_sessions = false,
		autoload_last_session = false,
		swap_files = false,
		backup = false,
		line_wrap = false,
		show_mode = true,
		scrolloff = true,
		scrolloff_amount = 15,
		mouse = true,
		preserve_edit_pos = false,
		allow_default_keymaps_overriding = true,
		new_file_split = true,
		line_highlight = true,
		split_right = true,
		split_below = true,
		clipboard = true,
		auto_comment = false,
		show_indent = true,
		expand_tabs = true,
		disable_numbering = false,
		relative_num = true,
		win_width = false,
		win_width_nr = 85,
		highlight_yank = true,
		enable_guicolors = true,
		explorer_right = false,
		show_hidden = true,
		check_updates = false,
		auto_install_plugins = true,
		dashboard_statline = true,
		statusline_show_file_path = true,
		keybinds_modules = {
			core = true,
			movement = true,
			leader = true,
			completion = true,
		},
		escape_sequences = { "jk", "kj" },
		disable_autocommands = false,
		enable_lsp_virtual_text = true,
		use_floating_win_packer = true,
		indent = 2,
		max_columns = 120,
		complete_size = 10,
		complete_transparency = 25,
		sidebar_width = 25,
		terminal_width = 70,
		terminal_height = 20,
		conceallevel = 1,
		logging = "info",
		terminal_direction = "float",
		undo_dir = "/undodir",
		colorscheme = "doom-one",
		colorscheme_bg = "dark",
		doom_one = {
			cursor_coloring = false,
			enable_treesitter = true,
			italic_comments = false,
			telescope_highlights = true,
			terminal_colors = true,
			transparent_background = false,
		},
		guifont = "FiraCode Nerd Font",
		guifont_size = "15",
		whichkey_bg = "#202328",
		lsp_error = "",
		lsp_warn = "",
		lsp_hint = "",
		lsp_info = "",
		lsp_virtual_text = " ",
		linters = {
			c = {},
			cpp = {},
			css = {},
			html = {},
			javascript = {},
			lua = {},
			markdown = {},
			nix = {},
			python = {},
			ruby = {},
			rust = {},
			sh = {},
			typescript = {},
		},
		dashboard_custom_colors = {
			header_color = "#586268",
			center_color = "#51afef",
			shortcut_color = "#a9a1e1",
			footer_color = "#586268",
		},
		dashboard_custom_header = {},
	},
	nvim = {
		-- Set custom Neovim global variables
		-- @default = {}
		-- example:
		--   {
		--     ['sonokai_style'] = 'andromeda',
		--     ['modelineexpr'] = true,
		--   }
		--
		--   modeline feature was turned off to reduce security exploit surfaces.
		--   Since modeline now uses whitelist approach since nvim 0.4 /vim 8.1,
		--   enabling this is as safe as external packages such as securemodelines.
		--   See https://github.com/neovim/neovim/issues/2865
		--
		global_variables = {},

		-- Set custom autocommands
		-- @default = {}
		-- example:
		--   augroup_name = {
		--      { 'BufNewFile,BufRead', 'doom_modules.lua', 'set ft=lua'}
		--   }
		autocmds = {},

		-- Set custom key bindings
		-- @default = {}
		-- example:
		--   {
		--      {'n', 'ca', ':Lspsaga code_action<CR>', options}
		--   }
		--
		--   where
		--     'n' is the map scope
		--     'ca' is the map activator
		--     ':Lspsaga ...' is the command to be executed
		--     options is a Lua table containing the mapping options, e.g.
		--     { silent = true }, see ':h map-arguments'.
		mappings = {},

		-- Set custom commands
		-- @default = {}
		-- example:
		--   {
		--      'echo "Hello, custom commands!"'
		--   }
		commands = {},

		-- Set custom functions
		-- @default = {}
		-- example:
		--   {
		--      {
		--         hello_custom_func = function()
		--           print("Hello, custom functions!")
		--         end,
		--         -- If the function should be ran on neovim launch or if it should
		--         -- be a global function accesible from anywhere
		--         run_on_start = false,
		--      },
		--   }
		functions = {},

		-- Set custom options
		-- @default = {}
		-- example:
		--   {
		--      ['shiftwidth'] = 4
		--   }
		options = {
			numberwidth = 2,
			relativenumber = true,
		},
	},
}

return M
