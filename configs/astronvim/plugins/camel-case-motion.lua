return function()
	local map = vim.keymap.set

	map("n", "w", "<Plug>CamelCaseMotion_w", { noremap = true, silent = true })
	map("n", "b", "<Plug>CamelCaseMotion_b", { noremap = true, silent = true })
	map("n", "e", "<Plug>CamelCaseMotion_e", { noremap = true, silent = true })
	map("n", "ge", "<Plug>CamelCaseMotion_ge", { noremap = true, silent = true })
end
