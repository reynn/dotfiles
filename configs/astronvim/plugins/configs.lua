local cmp_ok, _ = pcall(require, "cmp")
local tabnine_ok, tabnine = pcall(require, "cmp_tabnine.config")

local M = {}

M.cmp_tabnine = function()
	if not tabnine_ok or not cmp_ok then
		return
	end

	tabnine:setup({
		max_num_results = 20,
		sort = true,
		run_on_every_keystroke = true,
		show_prediction_strenth = true,
	})

	astronvim.add_cmp_source({
		name = "cmp_tabnine",
		priority = 1000,
	})
end

M.colorscheme = function(name)
	local opts = {
		kanagawa = {
			dimInactive = true,
			globalStatus = true,
		},
		catppuccin = {
			term_colors = true,
			integrations = {
				indent_blankline = {
					enabled = false,
				},
				lsp_trouble = false,
				neotree = {
					enabled = true,
				},
				nvimtree = {
					enabled = false,
				},
				telescope = true,
				ts_rainbow = true,
				which_key = true,
			},
		},
	}

	require(name).setup(opts[name])
end

M.golang = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if cmp_nvim_lsp_ok then
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
	end

	require("go").setup({
		dap_debug = true,
		dap_debug_gui = true,
		fillstruct = "gopls",
		gofmt = "gofumpt", --gofmt cmd,
		goimport = "gopls",
		icons = false,
		lsp_cfg = {
			capabilities = capabilities,
			settings = {
				gopls = {
					codelenses = {
						gc_details = false,
						generate = true,
						test = true,
						tidy = true,
					},
					analyses = {
						unusedparams = true,
					},
				},
			},
		},
		lsp_inlay_hints = { enabled = false },
		lsp_diag_virtual_text = true,
		lsp_document_formatting = true,
		lsp_gofumpt = true,
		lsp_keymaps = false,
		lsp_on_attach = astronvim.lsp and astronvim.lsp.on_attach or nil,
		max_line_len = 120,
		textobjects = false,
		verbose = false,
	})
end

M.lsp_signature = function()
	require("lsp_signature").setup({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		floating_window = true,
		handler_opts = {
			border = "double",
		},
		max_height = 15,
		max_width = 120,
	})
end

M.mason_tool_installer = function()
	require("mason-tool-installer").setup({
		auto_update = true,
		ensure_installed = {
			-- LSPs
			"lua-language-server",
			"rust-analyzer",
			"gopls", -- golang
			"dockerfile-language-server",
			"ansible-language-server",
			"jdtls", -- java
			"json-lsp", -- jsono
			"taplo", -- yaml

			-- formatters
			"black", -- pythno
			"isort",
			"shfmt", -- bash
			"stylua", -- lua

			-- DAP
			"delve", -- go
			"codelldb", -- rust

			-- Linters
			"revive", -- go
		},
		run_on_start = true,
	})
end

M.mini = function()
	local indent_scope = require("mini.indentscope")
	local surround = require("mini.surround")
	local bufremove = require("mini.bufremove")
	local comment = require("mini.comment")
	local cursor_word = require("mini.cursorword")

	bufremove.setup({})
	comment.setup({})
	cursor_word.setup({})
	indent_scope.setup({
		draw = {
			delay = 0,
			animation = indent_scope.gen_animation.cubic({
				easing = "in-out",
				duration = 100,
				unit = "total",
			}),
		},
		options = {
			indent_at_cursor = false,
		},
		symbol = "▏",
	})
	surround.setup({
		highlight_duration = 2000,
	})

	local disable = {
		"base16",
		"completion",
		"cursorword",
		"doc",
		"fuzzy",
		"misc",
		"pairs",
		"sessions",
		"starter",
		"statusline",
		"tabline",
		"trailspace",
	}
	for _, plugin in ipairs(disable) do
		vim.g["mini" .. plugin .. "_disable"] = true
	end
end

M.rust_crates = function()
	require("crates").setup({})
	astronvim.add_user_cmp_source("crates")
end

M.rust_tools = function()
	local lldb_version = "1.8.1"
	local extension_path = vim.env.HOME .. "/.vscode-insiders/extensions/vadimcn.vscode-lldb-" .. lldb_version
	local codelldb_path = extension_path .. "/adapter/codelldb"
	local liblldb_path = extension_path .. "/lldb/lib/liblldb.so"

	require("rust-tools").setup({
		tools = {
			-- These apply to the default RustSetInlayHints command
			inlay_hints = {
				auto = false,
				parameter_hints_prefix = " ",
				other_hints_prefix = " ",
			},
		},
		server = astronvim.lsp.server_settings("rust_analyzer"),
		dap = {
			adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
		},
	})
end

M.tree_surfer = function()
	require("syntax-tree-surfer").setup({
		highlight_group = "HopNextkey",
	})
end

M.trouble = function()
	require("trouble").setup({
		position = "bottom", -- position of the list can be: bottom, top, left, right
		height = 15, -- height of the trouble list when position is top or bottom
		width = 60, -- width of the list when position is left or right
		icons = true, -- use devicons for filenames
		mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
		fold_open = "", -- icon used for open folds
		fold_closed = "", -- icon used for closed folds
		group = true, -- group results by file
		padding = true, -- add an extra new line on top of the list
		action_keys = { -- key mappings for actions in the trouble list
			-- map to {} to remove a mapping, for example: close = {},
			close = "q", -- close the list
			cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
			refresh = "r", -- manually refresh
			jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
			open_split = { "<c-x>" }, -- open buffer in new split
			open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
			open_tab = { "<c-t>" }, -- open buffer in new tab
			jump_close = { "o" }, -- jump to the diagnostic and close the list
			toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
			toggle_preview = "P", -- toggle auto_preview
			hover = "K", -- opens a small popup with the full multiline message
			preview = "p", -- preview the diagnostic location
			close_folds = { "zM", "zm" }, -- close all folds
			open_folds = { "zR", "zr" }, -- open all folds
			toggle_fold = { "zA", "za" }, -- toggle fold of current file
			previous = "k", -- preview item
			next = "j", -- next item
		},
		indent_lines = true, -- add an indent guide below the fold icons
		auto_open = false, -- automatically open the list when you have diagnostics
		auto_close = false, -- automatically close the list when you have no diagnostics
		auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
		auto_fold = false, -- automatically fold a file trouble list at creation
		auto_jump = {
			"lsp_definitions",
		}, -- for the given modes, automatically jump if there is only a single result
		-- signs = {
		--   -- icons / text used for a diagnostic
		--   error = "",
		--   warning = "",
		--   hint = "",
		--   information = "",
		--   other = "﫠"
		-- },
		use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
	})
end

M.zen_mode = function()
	require("zen-mode").setup({
		window = {
			backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
			width = 100, -- width of the Zen window
			height = 1, -- height of the Zen window
			options = {
				-- signcolumn = "no", -- disable signcolumn
				number = false, -- disable number column
				relativenumber = false, -- disable relative numbers
				-- cursorline = false, -- disable cursorline
				-- cursorcolumn = false, -- disable cursor column
				foldcolumn = "0", -- disable fold column
				-- list = false, -- disable whitespace characters
			},
		},
		plugins = {
			options = {
				enabled = true,
				ruler = false, -- disables the ruler text in the cmd line area
				showcmd = false, -- disables the command in the last line of the screen
			},
			twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
			gitsigns = { enabled = false }, -- disables git signs
			tmux = { enabled = false }, -- disables the tmux statusline
			kitty = { enabled = false },
		},
		on_open = function(_) end,
		on_close = function() end,
	})
end

return M
