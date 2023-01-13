return {
	{ "tpope/vim-repeat", lazy = false },
	{
		"junegunn/vim-easy-align",
		lazy = false,
		config = function(_, _)
			return {
				mappings = {
					n = {
						["ga"] = { "<Plug>(EasyAlign)", silent = true },
					},
					x = {
						["ga"] = { "<Plug>(EasyAlign)", silent = true },
					},
				},
			}
		end,
	},
	{
		"bkad/CamelCaseMotion",
		lazy = false,
		config = function(_, _)
			return {
				mappings = {
					n = {
						["w"] = { "<Plug>CamelCaseMotion_w", silent = true },
						["b"] = { "<Plug>CamelCaseMotion_b", silent = true },
						["e"] = { "<Plug>CamelCaseMotion_e", silent = true },
						["ge"] = { "<Plug>CamelCaseMotion_ge", silent = true },
					},
					o = {
						["iw"] = { "<Plug>CamelCaseMotion_iw", silent = true },
						["ib"] = { "<Plug>CamelCaseMotion_ib", silent = true },
						["ie"] = { "<Plug>CamelCaseMotion_ie", silent = true },
					},
					x = {
						["iw"] = { "<Plug>CamelCaseMotion_iw", silent = true },
						["ib"] = { "<Plug>CamelCaseMotion_ib", silent = true },
						["ie"] = { "<Plug>CamelCaseMotion_ie", silent = true },
					},
					i = {
						["<S-Left>"] = { "<C-o><Plug>CamelCaseMotion_w", silent = true },
						["<S-Right>"] = { "<C-o><Plug>CamelCaseMotion_b", silent = true },
					},
				},
			}
		end,
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
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
		module = "zen-mode",
	},
}
