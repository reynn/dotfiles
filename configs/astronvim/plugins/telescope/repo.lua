return {
  after = "telescope.nvim",
  module = "telescope._extensions.repo",
  config = function()
    require("telescope").load_extension("repo")
  end,
}
