return {
	run = "./install.sh",
	after = "nvim-cmp",
	config = function()
		local tabnine_ok, tabnine = pcall(require, "cmp_tabnine.config")
		local cmp_ok, _ = pcall(require, "cmp")
		if not tabnine_ok or not cmp_ok then
			return
		end

		tabnine:setup({
			max_num_results = 20,
			sort = true,
			run_on_every_keystroke = true,
			show_prediction_strenth = true,
			snippet_placeholder = "--",
		})

		astronvim.add_cmp_source({
			name = "cmp_tabnine",
			priority = 1000,
		})
	end,
}
