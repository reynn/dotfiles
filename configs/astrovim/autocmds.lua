return {
	setup = function()
		local map = vim.keymap.set
		local cmd = vim.api.nvim_create_autocmd
		local augroup = vim.api.nvim_create_augroup
		local del_augroup = vim.api.nvim_del_augroup_by_name

		del_augroup("TermMappings")

		augroup("style", {})
		cmd("BufEnter", {
			desc = "apply settings for proper Go",
			group = "style",
			pattern = "*.go",
			command = "setlocal textwidth=4 tabstop=4 shiftwidth=4",
		})

    augroup("packer_conf", {})
    cmd("BufWritePost", {
			desc = "Run packer sync if the plugins.lua is updated",
			group = "packer_conf",
			pattern = "plugins.lua",
			command = "source <afile> | PackerSync",
    })

		augroup("autocomp", {})
		cmd("VimLeave", {
			desc = "Stop running auto compiler",
			group = "autocomp",
			pattern = "*",
			command = "!autocomp %:p stop",
		})

		augroup("dapui", {})
		cmd("FileType", {
			desc = "Make q close dap floating windows",
			group = "dapui",
			pattern = "dap-float",
			callback = function()
				map("n", "q", "<cmd>close!<cr>")
			end,
		})
	end,
}
