local lvim = {}
-- ###### ####################################
-- ###### Plugins
-- ###### ####################################
-- ###### Additional Plugins ######
lvim.plugins = {
	-- ## Colorschemes
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				dimInactive = true,
				globalStatus = true,
			})
		end,
	},
	-- {
	--   "luisiacc/gruvbox-baby",
	--   config = function()
	--     vim.g.gruvbox_baby_telescope_theme = 1
	--     vim.g.gruvbox_baby_background_color = "medium"

	--     vim.g.gruvbox_baby_comment_style = "italic"
	--     vim.g.gruvbox_baby_function_style = "bold,italic"
	--     vim.g.gruvbox_baby_keyword_style = "bold"
	--     vim.g.gruvbox_baby_variable_style = "standout"
	--   end,
	-- },
	-- {
	--   "tiagovla/tokyodark.nvim",
	--   config = function()
	--     vim.g.tokyodark_enable_italic_comment = true
	--     vim.g.tokyodark_enable_italic = true
	--   end,
	-- },
	-- {
	--   "catppuccin/nvim",
	--   config = function()
	--     require("catppuccin").setup({
	--       term_colors = true,
	--       integrations = {
	--         indent_blankline = {
	--           enabled = false,
	--         },
	--         lsp_trouble = false,
	--         neotree = {
	--           enabled = true,
	--         },
	--         nvimtree = {
	--           enabled = false,
	--         },
	--         telescope = true,
	--         ts_rainbow = true,
	--         which_key = true,
	--       },
	--     })
	--   end,
	-- },
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
		config = function()
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
		end,
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		module = "zen-mode",
		config = function()
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
		end,
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.bufremove").setup()
			require("mini.comment").setup()
			require("mini.cursorword").setup()
			require("mini.indentscope").setup({
				draw = {
					delay = 0,
					animation = require("mini.indentscope").gen_animation("cubicInOut", {
						duration = 100,
						unit = "total",
					}),
				},
				options = {
					indent_at_cursor = false,
				},
				symbol = "▏",
			})
			require("mini.surround").setup({
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
		end,
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
		config = function()
			require("nvim-test").setup({
				run = true, -- run tests (using for debug)
				commands_create = true, -- create commands (TestFile, TestLast, ...)
				filename_modifier = ":.", -- modify filenames before tests run(:h filename-modifiers)
				silent = false, -- less notifications
				term = "toggleterm", -- a terminal to run ("terminal"|"toggleterm")
				termOpts = {
					direction = "float", -- terminal's direction ("horizontal"|"vertical"|"float")
					width = 96, -- terminal's width (for vertical|float)
					height = 24, -- terminal's height (for horizontal|float)
					go_back = false, -- return focus to original window after executing
					stopinsert = "auto", -- exit from insert mode (true|false|"auto")
					keep_one = true, -- keep only one terminal for testing
				},
				runners = { -- setup tests runners
					go = "nvim-test.runners.go-test",
					lua = "nvim-test.runners.busted",
					python = "nvim-test.runners.pytest",
					rust = "nvim-test.runners.cargo-test",
				},
			})
		end,
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
		config = function()
			require("hop").setup()
		end,
	},
	-- ## Treesitter additions
	{
		"ziontee113/syntax-tree-surfer",
		module = "syntax-tree-surfer",
		config = function()
			require("syntax-tree-surfer").setup({
				highlight_group = "HopNextkey",
			})
		end,
	},
	-- ## LSP Additions
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		config = function()
			require("lsp_signature").setup({
				bind = true, -- This is mandatory, otherwise border config won't get registered.
				handler_opts = {
					border = "double",
				},
				max_height = 15,
				max_width = 120,
			})
		end,
	},
	{
		"m-demare/hlargs.nvim",
		after = "nvim-treesitter",
		config = function()
			require("hlargs").setup()
		end,
	},
	{ "onsails/lspkind.nvim" },
	{
		"tzachar/cmp-tabnine",
		requires = { "hrsh7th/nvim-cmp" },
		run = "./install.sh",
	},
	-- ## DAP
	{
		"mfussenegger/nvim-dap",
		module = "dap",
		config = function()
			local dap = require("dap")

			local function start_session(_, _)
				local info_string = string.format("%s", dap.session().config.program)
				vim.notify(info_string, "debug", { title = "Debugger Started", timeout = 500 })
			end

			local function terminate_session(_, _)
				local info_string = string.format("%s", dap.session().config.program)
				vim.notify(info_string, "debug", { title = "Debugger Terminated", timeout = 500 })
			end

			dap.listeners.after.event_initialized["dapui"] = start_session
			dap.listeners.before.event_terminated["dapui"] = terminate_session

			vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticWarn" })
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticInfo" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticInfo" })
			vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo" })
		end,
		requires = {
			{
				"rcarriga/nvim-dap-ui",
				after = "nvim-dap",
				config = function()
					local dap, dapui = require("dap"), require("dapui")

					dapui.setup({
						icons = { expanded = "▾", collapsed = "▸" },
						mappings = {
							expand = "<cr>",
							open = "o",
							remove = "d",
							edit = "e",
							repl = "r",
							toggle = "t",
						},
						sidebar = {
							elements = {
								{ id = "scopes", size = 0.5 },
								{ id = "breakpoints", size = 0.25 },
								{ id = "stacks", size = 0.25 },
							},
							size = 40,
							position = "right",
						},
						tray = {
							elements = { "repl" },
							size = 10,
							position = "bottom",
						},
						floating = {
							border = "rounded",
							mappings = {
								close = { "q", "<esc>" },
							},
						},
						windows = { indent = 1 },
					})

					-- add listeners to auto open DAP UI
					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open()
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close()
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close()
					end
				end,
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				after = "nvim-dap",
				config = function()
					require("nvim-dap-virtual-text").setup()
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
		ft = { "rust", "rs" },
		after = { "nvim-lsp-installer" },
		config = function()
			local lsp_installer_servers = require("nvim-lsp-installer.servers")
			local _, requested_server = lsp_installer_servers.get_server("rust_analyzer")
			require("rust-tools").setup({
				tools = {
					autoSetHints = true,
					hover_with_actions = true,
					runnables = {
						use_telescope = true,
					},
					-- These apply to the default RustSetInlayHints command
					inlay_hints = {
						parameter_hints_prefix = " ",
						other_hints_prefix = " ",
					},
				},
				server = {
					cmd_env = requested_server._default_options.cmd_env,
					on_attach = require("lvim.lsp").common_on_attach,
					on_init = require("lvim.lsp").common_on_init,
				},
			})
		end,
	},
	{
		"Saecki/crates.nvim",
		after = "nvim-cmp",
		event = { "BufRead Cargo.toml" },
		requires = { "plenary.nvim" },
		config = function()
			require("crates").setup({})
		end,
	},
	{
		"ray-x/go.nvim",
		ft = { "go" },
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if cmp_nvim_lsp_ok then
				capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
			end
			local path = require("nvim-lsp-installer.core.path")
			local install_root_dir = path.concat({ vim.fn.stdpath("data"), "lsp_servers" })

			require("go").setup({
				goimport = "gopls",
				fillstruct = "gopls",
				gofmt = "gofumpt", --gofmt cmd,
				max_line_len = 120,
				icons = false,
				verbose = false,
				lsp_cfg = {
					capabilities = capabilities,
					settings = {
						gopls = {
							codelenses = {
								generate = true,
								gc_details = false,
								test = true,
								tidy = true,
							},
							analyses = {
								unusedparams = true,
							},
						},
					},
				},
				lsp_gofumpt = true,
				lsp_keymaps = false,
				lsp_diag_virtual_text = false,
				lsp_document_formatting = true,
				gopls_cmd = { install_root_dir .. "/gopls/gopls" },
				dap_debug = true,
				dap_debug_gui = true,
				textobjects = false,
			})
		end,
	},
	{
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup()
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
