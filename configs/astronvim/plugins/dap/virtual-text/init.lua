return {
	after = "nvim-dap",
	config = function()
		local dap_ok, _ = pcall(require, "dap")
		if not dap_ok then
			return
		end

		require("nvim-dap-virtual-text").setup({})
	end,
}
