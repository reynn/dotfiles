return function()
	local lint_ok, lint = pcall(require, "lint")
	if not lint_ok then
		return
	end
	lint.linters_by_ft = {
		markdown = { "markdownlint", "vale" },
		python = { "pylint" },
		yaml = { "yamllint" },
		golang = { "revive", "golangcilint" },
		lua = { "luacheck" },
	}

	local augroup = vim.api.nvim_create_augroup
	local create_au = vim.api.nvim_create_autocmd

	augroup("lint", {})
	create_au("BufWritePost", {
		desc = "run linters",
		group = "lint",
		pattern = "<buffer>",
		command = "lua require('lint').try_lint()",
	})
end
