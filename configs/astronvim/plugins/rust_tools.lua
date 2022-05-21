return function()
	-- local extension_path = vim.fn.stdpath("data") .. "/dapinstall/codelldb/extension"
	-- local codelldb_path = extension_path .. "/adapter/codelldb"
	-- local liblldb_path = extension_path .. "/lldb/lib/liblldb.so"

	require("rust-tools").setup({
		dap = {
			-- adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
		},
		tools = {
			autoSetHints = true,
			hover_with_actions = true,
			runnables = {
				use_telescope = true,
			},
			inlay_hints = {
				parameter_hints_prefix = "  ",
				other_hints_prefix = "  ",
			},
		},
	})
end
