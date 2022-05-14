return function()
	local dap = require("dap")

	dap.adapters.python = {
		type = "executable",
		command = "/usr/bin/python",
		args = { "-m", "debugpy.adapter" },
	}
	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Launch file",

			program = "${file}",
			pythonPath = function()
				return "python"
			end,
		},
	}

	-- dap.adapters.lldb = {
	-- 	type = "executable",
	-- 	command = "/Users/reynn/.vscode-insiders/extensions/lanza.lldb-vscode-0.2.3/bin/darwin/bin/lldb-vscode",
	-- 	name = "lldb",
	-- }
	-- dap.configurations.cpp = {
	-- 	{
	-- 		name = "Launch",
	-- 		type = "lldb",
	-- 		request = "launch",
	-- 		program = function()
	-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	-- 		end,
	-- 		cwd = "${workspaceFolder}",
	-- 		stopOnEntry = false,
	-- 		args = function()
	-- 			return vim.fn.input("Program args: ", "")
	-- 		end,
	-- 		runInTerminal = false,
	-- 		postRunCommands = { "process handle -p true -s false -n false SIGWINCH" },
	-- 	},
	-- }
	-- dap.configurations.c = dap.configurations.cpp
	-- dap.configurations.rust = dap.configurations.cpp

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
end
