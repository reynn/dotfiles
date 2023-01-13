return {
	{
		"ray-x/lsp_signature.nvim",
		config = function(_, _)
			require("lsp_signature").setup({
				bind = true, -- This is mandatory, otherwise border config won't get registered.
				floating_window = true,
				handler_opts = {
					border = "double",
				},
				max_height = 15,
				max_width = 120,
			})
		end,
		event = "BufRead",
	},
}
