return {
	setup = function()
		vim.cmd([[
      augroup packer_conf
        autocmd!
        autocmd bufwritepost plugins.lua source <afile> | PackerSync
      augroup end

      augroup go_style
        autocmd!
        autocmd BufEnter *.go textwidth=4 tabstop=4 shiftwidth=4
      augroup end
    ]])
		-- local map = vim.keymap.set
		-- local cmd = vim.api.nvim_create_autocmd
		-- local augroup = vim.api.nvim_create_augroup
		-- local del_augroup = vim.api.nvim_del_augroup_by_name

		-- del_augroup "TermMappings"

		-- augroup("autocomp", {})
		-- cmd("VimLeave", {
		--   desc = "Stop running auto compiler",
		--   group = "autocomp",
		--   pattern = "*",
		--   command = "!autocomp %:p stop",
		-- })

		-- augroup("dapui", {})
		-- cmd("FileType", {
		--   desc = "Make q close dap floating windows",
		--   group = "dapui",
		--   pattern = "dap-float",
		--   callback = function()
		--     map("n", "q", "<cmd>close!<cr>")
		--   end,
		-- })
	end,
}
