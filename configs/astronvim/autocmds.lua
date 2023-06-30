local utils = require("user.utils")
local map = vim.keymap.set

utils.augroup("gosettings", {
	{
		event = { "BufEnter" },
		description = "Apply proper settings for Go",
		pattern = "*.go",
		command = "setlocal tabstop=4 shiftwidth=4",
	},
	-- {
	-- 	event = { "BufWritePre" },
	-- 	pattern = { "*.go" },
	-- 	command = 'silent! lua require("go.format").goimport()',
	-- },
})

utils.augroup("autocomp", {
	{
		event = { "VimLeave" },
		description = "Stop running auto compiler",
		pattern = "*",
		command = function()
			vim.fn.jobstart({ "autocomp", vim.fn.expand("%:p"), "stop" })
		end,
	},
})

utils.augroup("docker", {
	{
		event = { "BufNewFile", "BufRead" },
		description = "Set filetype for *.dockerfile",
		pattern = "*.dockerfile",
		command = "vim.bo.filetype = 'dockerfile'",
	},
})

utils.augroup("dap", {
	{
		event = "FileType",
		description = "Make q close dap floating windows",
		pattern = "dap-float",
		command = function()
			map("n", "q", "<cmd>close!<cr>")
		end,
	},
})

utils.augroup("LspAttach_inlayhints", {
	{
		event = "BufEnter",
		command = function(args)
			if not (args.data and args.data.client_id) then
				return
			end
			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			require("lsp-inlayhints").on_attach(client, bufnr)
		end,
	},
})
