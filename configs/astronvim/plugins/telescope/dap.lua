return {
  after = "telescope.nvim",
  module = "telescope._extensions.dap",
  config = function()
    local dap_ok, _ = pcall(require, "dap")
    local telescope_ok, telescope = pcall(require, "telescope")
    if not dap_ok and not telescope_ok then
      return
    end

    telescope.load_extension("dap")
  end,
}
