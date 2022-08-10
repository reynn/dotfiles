local function vim_opt_toggle(opt, on, off, name)
	local message = name
	if vim.opt[opt]._value == off then
		vim.opt[opt] = on
		message = message .. " Enabled"
	else
		vim.opt[opt] = off
		message = message .. " Disabled"
	end
	vim.notify(message, "info", {})
end

return {
	i = {
		["<c-d>"] = {
			n = { "<c-r>=strftime('%Y-%m-%d')<cr>", "Y-m-d" },
			x = { "<c-r>=strftime('%m/%d/%y')<cr>", "m/d/y" },
			f = { "<c-r>=strftime('%B %d, %Y')<cr>", "B d, Y" },
			X = { "<c-r>=strftime('%H:%M')<cr>", "H:M" },
			F = { "<c-r>=strftime('%H:%M:%S')<cr>", "H:M:S" },
			d = { "<c-r>=strftime('%Y/%m/%d %H:%M:%S -')<cr>", "Y/m/d H:M:S -" },
		},
	},
	n = {
		g = {
			name = "GoTo",
			d = { "Definition" },
			D = { "Declaration" },
			I = { "Implementation" },
			r = { "References" },
			R = { "References (Trouble)" },
			o = { "Open Diagnostics" },
			t = {
				name = "Treesitter",
				v = {
					function()
						require("syntax-tree-surfer").targeted_jump({ "variable_declaration" })
					end,
					"Go to Variable",
				},
				f = {
					function()
						require("syntax-tree-surfer").targeted_jump({ "function" })
					end,
					"Go to Function",
				},
				i = {
					function()
						require("syntax-tree-surfer").targeted_jump({
							"if_declaration",
							"else_clause",
							"else_statement",
							"elseif_statement",
						})
					end,
					"Go to `if` Statement",
				},
				r = {
					function()
						require("syntax-tree-surfer").targeted_jump({ "for_statement" })
					end,
					"Go to `for` Statement",
				},
				w = {
					function()
						require("syntax-tree-surfer").targeted_jump({ "while_statement" })
					end,
					"Go to `while` Statement",
				},
				s = {
					function()
						require("syntax-tree-surfer").targeted_jump({ "switch_statement" })
					end,
					"Go to `switch` Statement",
				},
				t = {
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
					"Go to Statement",
				},
			},
		},
		["K"] = {
			function()
				vim.lsp.buf.hover()
			end,
			"Show Hover",
		},
		["<leader>"] = {
			c = {
				function()
					MiniBufremove.delete()
				end,
				"Close Buffer",
			},
			["C"] = {
				name = "Crates.io",
				t = {
					function()
						require("crates").toggle()
					end,
					"Toggle extra crates.io information",
				},
				r = {
					function()
						require("crates").reload()
					end,
					"Reload information from crates.io",
				},
				U = {
					function()
						require("crates").upgrade_crate()
					end,
					"Upgrade a crate",
				},
				A = {
					function()
						require("crates").upgrade_all_crates()
					end,
					"Upgrade all crates",
				},
			},
			f = {
				name = "Telescope",
				["?"] = { "<cmd>Telescope help_tags<cr>", "Find Help" },
				["'"] = { "<cmd>Telescope marks<cr>", "Marks" },
				a = { "<cmd>Telescope aerial<cr>", "Aerial" },
				b = { "<cmd>Telescope buffers<cr>", "Buffers" },
				c = { "<cmd>Telescope commands<cr>", "Commands" },
				f = { "<cmd>Telescope find_files<cr>", "Files" },
				F = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "All Files" },
				h = { "<cmd>Telescope oldfiles<cr>", "History" },
				k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
				m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
				n = { "<cmd>Telescope notify<cr>", "Notifications" },
				p = { "<cmd>Telescope project<cr>", "Projects" },
				P = { "<cmd>Telescope packer<cr>", "Packer" },
				r = { "<cmd>Telescope repo list<cr>", "Repos" },
				R = { "<cmd>Telescope registers<cr>", "Registers" },
				t = { "<cmd>Telescope colorscheme<cr>", "Themes" },
				w = { "<cmd>Telescope live_grep<cr>", "Words" },
			},
			["H"] = { "<cmd>set hlsearch!<cr>", "Toggle Highlight" },
			o = {
				name = "Options",
				c = {
					function()
						vim_opt_toggle("conceallevel", 2, 0, "Conceal")
					end,
					"Toggle Conceal",
				},
				l = {
					function()
						vim_opt_toggle("list", true, false, "List")
					end,
					"Toggle list chars",
				},
				h = {
					function()
						require("hlargs").toggle()
					end,
					"Taggle hlargs",
				},
			},
			p = {
				C = { ":PackerClean<cr>", "Packer Clean" },
			},
			s = {
				name = "Swap",
				p = { "Next Parameter" },
				P = { "Previous Parameter" },
			},
			["T"] = {
				name = "Trouble",
				x = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
				w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble Workspace Diagnostics" },
				d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble Document Diagnostics" },
				q = { "<cmd>TroubleToggle quickfix<cr>", "Trouble Quickfix" },
				l = { "<cmd>TroubleToggle loclist<cr>", "Trouble LOC List" },
			},
			x = {
				name = "Debugger",
				b = {
					function()
						require("dap").toggle_breakpoint()
					end,
					"Toggle Breakpoint",
				},
				B = {
					function()
						require("dap").clear_breakpoints()
					end,
					"Clear Breakpoints",
				},
				c = {
					function()
						require("dap").continue()
					end,
					"Start/Continue",
				},
				i = {
					function()
						require("dap").step_into()
					end,
					"Step Into",
				},
				l = {
					function()
						require("dapui").float_element("breakpoints")
					end,
					"List Breakpoints",
				},
				o = {
					function()
						require("dap").step_over()
					end,
					"Step Over",
				},
				q = {
					function()
						require("dap").close()
					end,
					"Close Session",
				},
				Q = {
					function()
						require("dap").terminate()
					end,
					"Terminate",
				},
				r = {
					function()
						require("dap").repl.toggle()
					end,
					"REPL",
				},
				s = {
					function()
						require("dapui").float_element("scopes")
					end,
					"Scopes",
				},
				t = {
					function()
						require("dapui").float_element("stacks")
					end,
					"Threads",
				},
				u = {
					function()
						require("dapui").toggle()
					end,
					"Toggle Debugger UI",
				},
				w = {
					function()
						require("dapui").float_element("watches")
					end,
					"Watches",
				},
				x = {
					function()
						require("dap.ui.widgets").hover()
					end,
					"Inspect",
				},
			},
			z = {
				function()
					require("zen-mode").toggle()
				end,
				"Toggle Zen Mode",
			},
		},
	},
	v = {
		["<leader>"] = {
			["C"] = {
				name = "Crates.io",
				U = {
					function()
						require("crates").upgrade_crates()
					end,
					"Upgrade selected crates",
				},
			},
			x = {
				name = "Debugger",
				e = {
					function()
						require("dapui").eval()
					end,
					"Evaluate Line",
				},
			},
		},
		["<C-h>"] = {
			function()
				require("syntax-tree-surfer").surf("parent", "visual")
			end,
			"Parent",
		},
		["<C-l>"] = {
			function()
				require("syntax-tree-surfer").surf("child", "visual")
			end,
			"Child",
		},
		["<C-j>"] = {
			function()
				require("syntax-tree-surfer").surf("next", "visual", true)
			end,
			"Swap Next",
		},
		["<C-k>"] = {
			function()
				require("syntax-tree-surfer").surf("prev", "visual", true)
			end,
			"Swap Prev",
		},
	},
}
