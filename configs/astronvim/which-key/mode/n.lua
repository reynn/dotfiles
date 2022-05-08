local function vim_opt_toggle(user_opt)
	if vim.o[user_opt] == true then
		vim.opt[user_opt] = false
	else
		vim.opt[user_opt] = true
	end
end

local mappings = {
	g = {
		name = "GoTo",
		R = { "Trouble LSP references" },
	},
	["<leader>"] = {
		p = {
			C = { ":PackerClean<cr>", "Clean" },
			p = {
				function()
					require("telescope").extensions.packer.packer()
				end,
				"Packer Search",
			},
		},
		["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
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
			M = { "<cmd>Telescope media_files<cr>", "Media" },
			n = { "<cmd>Telescope notify<cr>", "Notifications" },
			p = { "<cmd>Telescope project<cr>", "Projects" },
			r = { "<cmd>Telescope registers<cr>", "Registers" },
			t = { "<cmd>Telescope colorscheme<cr>", "Themes" },
			w = { "<cmd>Telescope live_grep<cr>", "Words" },
			o = { nil },
		},
		s = {
			name = "Swap",
			b = { nil },
			h = { nil },
			m = { nil },
			n = { nil },
			r = { nil },
			k = { nil },
			c = { nil },
			p = { "Next Parameter" },
			P = { "Previous Parameter" },
		},
		T = {
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
				"Continue",
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
	},
}

local ignores = {
	"z<CR>",
	"z+",
	"z-",
	"z^",
	"zl",
	"zh",
	"z.",
	"Y",
	"n",
	"N",
	"J",
	"<A-c>",
	"<SNR>",
	"y",
	"c",
	"d",
	"<PageUp>",
	"<PageDown>",
	"<Up>",
	"<Down>",
	"<Left>",
	"<Right>",
	"j",
	"k",
	"l",
	"h",
	"^",
	"*",
	"-",
	"^",
	"0",
	"%",
	"#",
	"$",
	"<LeftMouse>",
	"<2-LeftMouse>",
	"<C-i>",
	"<C-o>",
	"G",
	"gg",
}

for _, key in pairs(ignores) do
	mappings[key] = { "which_key_ignore" }
end

return mappings
