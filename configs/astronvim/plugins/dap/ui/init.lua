return {
  after = "nvim-dap",
  config = function()
    require("user.plugins.dap.ui.config")
  end,
}
