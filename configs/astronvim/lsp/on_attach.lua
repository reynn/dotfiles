return function(client)
	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_create_augroup("LspFormatting", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePre", {
			desc = "Format the buffer before writing",
			group = "LspFormatting",
			pattern = "*",
			callback = function()
				vim.lsp.buf.formatting_sync()
			end,
		})
	end
end
