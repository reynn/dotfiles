return {
  after = "nvim-dap",
  config = function()
    require("user.plugins.dap.virtual-text.config")
  end,
}
