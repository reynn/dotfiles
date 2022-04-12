return function(plugins)
	return vim.tbl_deep_extend("force", plugins, {
		-- Extended file type support
		{ "sheerun/vim-polyglot" },
		-- Color Schemes
		{
			"eddyekofo94/gruvbox-flat.nvim",
			config = function()
				require("lualine").setup({
					options = {
						theme = "gruvbox-flat",
					},
				})
				vim.g.gruvbox_flat_style = "hard"
				vim.g.gruvbox_sidebars = { "qf", "terminal", "vista_kind", "packer" }
				vim.cmd "colorscheme gruvbox-flat"
			end,
		},
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
		-- {
		-- 	"tzachar/cmp-tabnine",
		-- 	after = { "hrsh7th/nvim-cmp" },
		-- 	requires = { "hrsh7th/nvim-cmp" },
		-- 	run = "./install.sh",
		-- 	config = function()
		-- 		local tabnine = require("cmp_tabnine.config")
		-- 		tabnine:setup({
		-- 			sort = true,
		-- 			max_num_results = 10,
		-- 			run_on_every_keystroke = true,
		-- 		})
		-- 	end
		-- },
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
		{
			"Pocco81/DAPInstall.nvim",
			config = function()
				require("dap-install").setup({})
			end,
		},
		-- Language specific additions
		{
			"simrat39/rust-tools.nvim",
			-- requires = {
			-- 	"nvim-lspconfig",
			-- 	"nvim-lsp-installer",
			-- 	"nvim-dap",
			-- 	"Comment.nvim",
			-- },
			ft = { "rust", "rs" },
		},
		{
			"Saecki/crates.nvim",
			after = "nvim-cmp",
			requires = {
				"nvim-lua/plenary.nvim",
			},
			event = { "BufRead Cargo.toml" },
			config = function()
				require("crates").setup({})

				local cmp = require("cmp")
				local config = cmp.get_config()
				table.insert(config.sources, { name = "crates" })
				cmp.setup(config)
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
