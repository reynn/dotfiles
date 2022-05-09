return function()
	local map = vim.keymap.set
	local create_au = vim.api.nvim_create_autocmd
	local augroup = vim.api.nvim_create_augroup

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

  augroup("mini", {clear = true})
  create_au("FileType", {
    desc = "Disable indent scope for conent types",
    group = "mini",
    callback = function()
      if vim.tbl_contains({
          "NvimTree",
          "TelescopePrompt",
          "Trouble",
          "alpha",
          "help",
          "lsp-installer",
          "lspinfo",
          "neo-tree",
          "neogitstatus",
          "packer",
          "startify",
        }, vim.bo.filetype) or vim.tbl_contains({ "nofile", "terminal" }, vim.bo.buftype)
      then
        vim.b.miniindentscope_disable = true
      end
    end,
  })
end
