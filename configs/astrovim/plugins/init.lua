return function(plugins)
	return vim.tbl_deep_extend("force", plugins, {
		-- Color Schemes
		{ "eddyekofo94/gruvbox-flat.nvim" },
		{
			"luisiacc/gruvbox-baby",
			config = function()
				vim.g.gruvbox_baby_telescope_theme = 1
				vim.g.gruvbox_baby_function_style = "NONE"
				vim.g.gruvbox_baby_keyword_style = "italic"

				vim.cmd("colorscheme gruvbox-baby")
			end,
		},
		{ "sainnhe/gruvbox-material" },
		{ "folke/trouble.nvim", cmd = "TroubleToggle" },
		{ "junegunn/vim-easy-align" },
		{ "tpope/vim-repeat" },
		{ "tpope/vim-surround", keys = { "cs", "ds", "ys" } },
		{ "gpanders/editorconfig.nvim" },
		{
			"dhruvasagar/vim-table-mode",
			cmd = "TableModeToggle",
			setup = function()
				vim.g.table_mode_corner = "|"
			end,
		},
		-- Text objects/Motions
		{ "bkad/CamelCaseMotion" },
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			after = "nvim-treesitter",
		},
		{
			"ray-x/lsp_signature.nvim",
			event = "BufRead",
			config = function()
				require("lsp_signature").on_attach()
			end,
		},
		-- DAP:
		{
			"mfussenegger/nvim-dap",
			config = require("user.plugins.dap"),
		},
		{
			"rcarriga/nvim-dap-ui",
			after = "nvim-dap",
			config = function()
				local dap, dapui = require("dap"), require("dapui")
				dapui.setup(require("user.plugins.dapui"))
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
		-- Language specific additions
		{
			"simrat39/rust-tools.nvim",
			requires = {
				"nvim-lspconfig",
				"nvim-lsp-installer",
				"nvim-dap",
				"Comment.nvim",
			},
			ft = { "rust", "rs" },
			config = function()
				require("rust-tools").setup({})
			end,
		},
		{
			"Saecki/crates.nvim",
			after = "nvim-cmp",
			requires = { "nvim-lua/plenary.nvim" },
			event = { "BufRead Cargo.toml" },
			config = function()
				require("crates").setup({})
			end,
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
	})
end
