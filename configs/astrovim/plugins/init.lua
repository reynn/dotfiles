return function(plugins)
	return vim.tbl_deep_extend("force", plugins, {
		-- Color Schemes
		{ "eddyekofo94/gruvbox-flat.nvim" },
		{ "sainnhe/gruvbox-material" },
		{
			"luisiacc/gruvbox-baby",
			config = function()
				vim.g.gruvbox_baby_telescope_theme = 1
				-- vim.g.gruvbox_baby_function_style = "NONE"
				vim.g.gruvbox_baby_keyword_style = "italic"

				-- vim.cmd("colorscheme gruvbox-baby")
			end,
		},
		{
			"tiagovla/tokyodark.nvim",
			config = function()
				vim.cmd("colorscheme tokyodark")
			end,
		},
		{
			"catppuccin/nvim",
			as = "catppuccin",
			config = function()
				require("catppuccin").setup({
					integrations = {
						ts_rainbow = true,
						lsp_trouble = true,
					},
				})
				require("lualine").setup({
					options = {
						theme = "catppuccin",
					},
				})

				-- vim.cmd("colorscheme catppuccin")
			end,
		},
		{
			"marko-cerovac/material.nvim",
			config = function()
				require("material").setup({
					lualine_style = "stealth",
				})
				vim.g.material_style = "darker"
				-- vim.cmd("colorscheme material")
			end,
		},
		-- general vim improvements
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
		-- LSP additions
		{
			"ray-x/lsp_signature.nvim",
			event = "BufRead",
			config = function()
				require("lsp_signature").on_attach()
			end,
		},
		{
			"m-demare/hlargs.nvim",
			config = function()
				require("hlargs").setup({})
			end,
		},
		{
			"onsails/lspkind.nvim",
			config = function()
				-- local cmp = require("cmp")
				require("lspkind").init({
          mode = 'symbol_text',
        })

				-- cmp.setup({
				-- 	formatting = {
				-- 		format = lspkind.cmp_format({
				-- 			mode = "text_symbol",
				-- 			max_width = 50,
				-- 		}),
				-- 	},
				-- })
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
			"mfussenegger/nvim-lint",
			config = function()
				require("lint").linters_by_ft = {
					markdown = { "markdownlint", "vale" },
					python = { "pylint" },
					yaml = { "yamllint" },
					golang = { "revive", "golangcilint" },
					lua = { "luacheck" },
				}
				vim.cmd([[ au BufWritePost <buffer> lua require('lint').try_lint() ]])
			end,
		},
		-- Language specific additions
		{ "ellisonleao/glow.nvim" },
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
