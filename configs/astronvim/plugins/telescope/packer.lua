return {
  after = "telescope.nvim",
  module = "telescope._extensions.packer",
  config = function()
    require("telescope").load_extension("packer")
  end,
}
