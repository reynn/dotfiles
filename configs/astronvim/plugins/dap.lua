return function()
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
end
