return {
	ft = { "rust" },
	config = function()
		local lldb_version = "1.8.1"
		local extension_path = vim.env.HOME .. "/.vscode-insiders/extensions/vadimcn.vscode-lldb-" .. lldb_version
		local codelldb_path = extension_path .. "/adapter/codelldb"
		local liblldb_path = extension_path .. "/lldb/lib/liblldb.so"

		require("rust-tools").setup({
			tools = {
				-- These apply to the default RustSetInlayHints command
				inlay_hints = {
					parameter_hints_prefix = " ",
					other_hints_prefix = " ",
				},
			},
			server = astronvim.lsp.server_settings("rust_analyzer"),
			dap = {
				adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
			},
		})
	end,
}
