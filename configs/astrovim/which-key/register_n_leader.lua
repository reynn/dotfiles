local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local function opts(mode, prefix)
	return {
		mode = mode,
		prefix = prefix,
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = true,
	}
end

local Dmappings = {
	n = { "<c-r>=strftime('%Y-%m-%d')<cr>", "Y-m-d" },
	x = { "<c-r>=strftime('%m/%d/%y')<cr>", "m/d/y" },
	f = { "<c-r>=strftime('%B %d, %Y')<cr>", "B d, Y" },
	X = { "<c-r>=strftime('%H:%M')<cr>", "H:M" },
	F = { "<c-r>=strftime('%H:%M:%S')<cr>", "H:M:S" },
	d = { "<c-r>=strftime('%Y/%m/%d %H:%M:%S -')<cr>", "Y/m/d H:M:S -" },
}

local Vmappings = {
	["/"] = { "Comment" },
	x = {
		name = "Debugger",
		e = {
			function()
				require("dapui").eval()
			end,
			"Evaluate Line",
		},
	},
}
local Gmappings = {
	d = { "Go to definition" },
	D = { "Go to declaration" },
	I = { "Go to implementation" },
	r = { "Go to references" },
	o = { "Open diagnostic" },
}
local NextBracketmappings = {
	d = { "Next diagnostic" },
	f = "Next function start",
	x = "Next class start",
	F = "Next function end",
	X = "Next class end",
}
local PrevBracketmappings = {
	d = { "Previous diagnostic" },
	f = { "Previous function start" },
	x = { "Previous class start" },
	F = { "Previous function end" },
	X = { "Previous class end" },
}

which_key.register(Gmappings, opts("n", "g"))
which_key.register(Vmappings, opts("v", "<leader>"))
which_key.register(Dmappings, opts("i", "<c-d>"))
which_key.register(NextBracketmappings, opts("n", "]"))
which_key.register(PrevBracketmappings, opts("n", "["))

return {
	["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
	f = {
		name = "Telescope",
		["?"] = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		["'"] = { "<cmd>Telescope marks<cr>", "Marks" },
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
}
