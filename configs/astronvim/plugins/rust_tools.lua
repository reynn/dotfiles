return function()
	local extension_path = vim.env.HOME .. "/.vscode-insiders/extensions/vadimcn.vscode-lldb-1.7.0/"
	local codelldb_path = extension_path .. "adapter/codelldb"
	local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

	require("rust-tools").setup({
		tools = {
			-- These apply to the default RustSetInlayHints command
			inlay_hints = {
				parameter_hints_prefix = " ",
				other_hints_prefix = " ",
			},
		},
		server = {
			on_attach = require("configs.lsp.handlers").on_attach,
		},
		dap = {
			adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
		},
	})
end
