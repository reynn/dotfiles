return function(config)
	-- Formatting and linting
	-- https://github.com/jose-elias-alvarez/null-ls.nvim
	local null_ls = require("null-ls")
	-- Check supported formatters
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
	local formatting = null_ls.builtins.formatting
	-- Check supported linters
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
	local diagnostics = null_ls.builtins.diagnostics
	local code_actions = null_ls.builtins.code_actions
	local hover = null_ls.builtins.hover

	config.sources = {
		code_actions.refactoring,
		diagnostics.fish,
		diagnostics.shellcheck,
		diagnostics.trail_space,
		formatting.stylua,
		formatting.autopep8,

		hover.dictionary,
	}
	-- NOTE: You can remove this on attach function to disable format on save
	config.on_attach = function(client)
		-- NOTE: You can remove this on attach function to disable format on save
		if client.resolved_capabilities.document_formatting then
			vim.api.nvim_create_autocmd("BufWritePre", {
				desc = "Auto format before save",
				pattern = "<buffer>",
				callback = vim.lsp.buf.formatting_sync,
			})
		end
	end

	return config
end
