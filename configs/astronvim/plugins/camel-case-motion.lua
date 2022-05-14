return function()
	local map = vim.keymap.set

	map("n", "w", "<Plug>CamelCaseMotion_w", { silent = true })
	map("n", "b", "<Plug>CamelCaseMotion_b", { silent = true })
	map("n", "e", "<Plug>CamelCaseMotion_e", { silent = true })
	map("n", "ge", "<Plug>CamelCaseMotion_ge", { silent = true })
end
