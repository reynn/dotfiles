return function()
	require("lsp_signature").setup({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "double",
		},
		max_height = 15,
		max_width = 120,
	})
end
