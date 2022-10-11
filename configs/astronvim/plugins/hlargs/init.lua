return {
  after = "nvim-treesitter",
  config = function()
    require("user.plugins.hlargs.config")
  end,
}
