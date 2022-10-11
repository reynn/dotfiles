return{
  after = "telescope.nvim",
  module = "telescope._extensions.dap",
  config = function()
    require("telescope").load_extension("dap")
  end,
}
