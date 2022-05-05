return {
	setup = function()
		local map = vim.keymap.set
		local create_au = vim.api.nvim_create_autocmd
		local augroup = vim.api.nvim_create_augroup
		local del_augroup = vim.api.nvim_del_augroup_by_name

		del_augroup("TermMappings")

		augroup("style", {})
		create_au("BufEnter", {
			desc = "apply settings for proper Go",
			group = "style",
			pattern = "*.go",
			command = "setlocal textwidth=4 tabstop=4 shiftwidth=4",
		})
		create_au("FileType", {
			desc = "Enable crates as a completion source",
			group = "style",
			pattern = "Cargo.toml",
			command = "lua require('cmp').setup.buffer { sources = { { 'crates' } } }",
		})

		augroup("packer_conf", {})
		create_au("BufWritePost", {
			desc = "Run packer sync if the plugins.lua is updated",
			group = "packer_conf",
			pattern = "plugins.lua",
			command = "source <afile> | PackerSync",
		})

		augroup("autocomp", {})
		create_au("VimLeave", {
			desc = "Stop running auto compiler",
			group = "autocomp",
			pattern = "*",
			command = "!autocomp %:p stop",
		})

		augroup("dapui", {})
		create_au("FileType", {
			desc = "Make q close dap floating windows",
			group = "dapui",
			pattern = "dap-float",
			callback = function()
				map("n", "q", "<cmd>close!<cr>")
			end,
		})
	end,
}
