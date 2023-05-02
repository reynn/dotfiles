local astro_utils = require("astronvim.utils")

return {
	i = {
		["<c-d>n"] = { "<c-r>=strftime('%Y-%m-%d')<cr>", desc = "Y-m-d" },
		["<c-d>x"] = { "<c-r>=strftime('%m/%d/%y')<cr>", desc = "m/d/y" },
		["<c-d>f"] = { "<c-r>=strftime('%B %d, %Y')<cr>", desc = "B d, Y" },
		["<c-d>X"] = { "<c-r>=strftime('%H:%M')<cr>", desc = "H:M" },
		["<c-d>F"] = { "<c-r>=strftime('%H:%M:%S')<cr>", desc = "H:M:S" },
		["<c-d>d"] = { "<c-r>=strftime('%Y/%m/%d %H:%M:%S -')<cr>", desc = "Y/m/d H:M:S -" },
	},
	n = {
		["<Tab>"] = {
			function()
				if #vim.t.bufs > 1 then
					require("telescope.builtin").buffers({
						sort_mru = true,
						ignore_current_buffer = true,
					})
				else
					astro_utils.notify("No other buffers open")
				end
			end,
			desc = "Switch Buffers",
		},
		-- smart splits
		["<Up>"] = {
			function()
				require("smart-splits").resize_up(2)
			end,
			desc = "Resize split up",
		},
		["<Down>"] = {
			function()
				require("smart-splits").resize_down(2)
			end,
			desc = "Resize split down",
		},
		["<Left>"] = {
			function()
				require("smart-splits").resize_left(2)
			end,
			desc = "Resize split left",
		},
		["<Right>"] = {
			function()
				require("smart-splits").resize_right(2)
			end,
			desc = "Resize split right",
		},
		-- -- keep search terms centered on screen
		["n"] = { "nzzzv" },
		["N"] = { "Nzzzv" },
		-- -- Join lines but leave cursor where it is
		["J"] = { "mzJ`z" },
		-- -- easy splits
		["\\"] = { "<cmd>split<cr>", desc = "Horizontal split" },
		["|"] = { "<cmd>vsplit<cr>", desc = "Vertical split" },
		["g"] = { name = "Go To" },
		-- -- Trouble
		["<leader>T"] = { name = "Trouble" },
		["<leader>Tx"] = { "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
		["<leader>Tw"] = {
			"<cmd>TroubleToggle workspace_diagnostics<cr>",
			desc = "Trouble Workspace Diagnostics",
		},
		["<leader>Td"] = {
			"<cmd>TroubleToggle document_diagnostics<cr>",
			desc = "Trouble Document Diagnostics",
		},
		["<leader>Tq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble Quickfix" },
		["<leader>Tl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Trouble LOC List" },
		["gt"] = { name = "TreeSitter" },
		["gtv"] = {
			function()
				require("syntax-tree-surfer").targeted_jump({ "variable_declaration" })
			end,
			desc = "Go to Variable",
		},
		["gtf"] = {
			function()
				require("syntax-tree-surfer").targeted_jump({ "function" })
			end,
			desc = "Go to Function",
		},
		["gti"] = {
			function()
				require("syntax-tree-surfer").targeted_jump({
					"if_declaration",
					"else_clause",
					"else_statement",
					"elseif_statement",
				})
			end,
			desc = "Go to `if` Statement",
		},
		["gtr"] = {
			function()
				require("syntax-tree-surfer").targeted_jump({ "for_statement" })
			end,
			desc = "Go to `for` Statement",
		},
		["gtw"] = {
			function()
				require("syntax-tree-surfer").targeted_jump({ "while_statement" })
			end,
			desc = "Go to `while` Statement",
		},
		["gts"] = {
			function()
				require("syntax-tree-surfer").targeted_jump({ "switch_statement" })
			end,
			desc = "Go to `switch` Statement",
		},
		["gtt"] = {
			function()
				require("syntax-tree-surfer").targeted_jump({
					"function",
					"if_declaration",
					"else_clause",
					"else_statement",
					"elseif_statement",
					"for_statement",
					"while_statement",
					"switch_statment",
				})
			end,
			desc = "Go to Statement",
		},
		-- LSP
		-- Telescope
		["<leader>f?"] = { "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
		["<leader>fa"] = { "<cmd>Telescope aerial<cr>", desc = "Aerial" },
		["<leader>fh"] = { "<cmd>Telescope oldfiles<cr>", desc = "History" },
		["<leader>fp"] = { "<cmd>Telescope project<cr>", desc = "Projects" },
		["<leader>fR"] = { "<cmd>Telescope repo list<cr>", desc = "Repos" },
		["<leader>ft"] = { "<cmd>Telescope colorscheme<cr>", desc = "Themes" },
		-- UX improvements
		["<leader>H"] = { "<cmd>set hlsearch!<cr>", desc = "Toggle Highlight" },
		["<leader>c"] = {
			function()
				MiniBufremove.delete(0)
			end,
			desc = "Close Buffer",
		},
		-- UI changes
		["<leader>uh"] = {
			function()
				require("hlargs").toggle()
			end,
			desc = "Taggle hlargs",
		},
		["<leader>z"] = {
			function()
				require("zen-mode").toggle()
			end,
			desc = "Toggle Zen Mode",
		},
		-- Rust mappings
		["<leader>r"] = { name = "Rust" },
		["<leader>rc"] = {
			name = "Crates.io",
		},
		["<leader>rct"] = {
			function()
				require("crates").toggle()
			end,
			desc = "Toggle extra crates.io information",
		},
		["<leader>rcr"] = {
			function()
				require("crates").reload()
			end,
			desc = "Reload information from crates.io",
		},
		["<leader>rcU"] = {
			function()
				require("crates").upgrade_crate()
			end,
			desc = "Upgrade a crate",
		},
		["<leader>rcA"] = {
			function()
				require("crates").upgrade_all_crates()
			end,
			desc = "Upgrade all crates",
		},
	},
	v = {
		-- -- move highlighted lines up or down
		["J"] = { ":m '>+1<CR>gv=gv" },
		["K"] = { ":m '<-2<CR>gv=gv" },
		-- Rust language
		["<leader>rc"] = { name = "Crates.io" },
		["<leader>rcU"] = {
			function()
				require("crates").upgrade_crates()
			end,
			desc = "Upgrade selected crates",
		},
		-- Syntax Tree surfer
		["<C-h>"] = {
			function()
				require("syntax-tree-surfer").surf("parent", "visual")
			end,
			desc = "Parent",
		},
		["<C-l>"] = {
			function()
				require("syntax-tree-surfer").surf("child", "visual")
			end,
			desc = "Child",
		},
		["<C-j>"] = {
			function()
				require("syntax-tree-surfer").surf("next", "visual", true)
			end,
			desc = "Swap Next",
		},
		["<C-k>"] = {
			function()
				require("syntax-tree-surfer").surf("prev", "visual", true)
			end,
			desc = "Swap Prev",
		},
	},
	x = {
		-- -- deletes the highlighted text without overwriting current paste buffer
		["<leader>p"] = { "_dP" },
	},
}
