return {
  after = "telescope.nvim",
  module = "telescope._extensions.project",
  config = function()
    require("telescope").load_extension("project")
  end,
}
