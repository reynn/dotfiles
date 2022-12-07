return {
  after = "telescope.nvim",
  module = "telescope._extensions.repo",
  config = function()
    local telescope_ok, telescope = pcall(require, "telescope")
    if not telescope_ok then
      return
    end

    telescope.load_extension("repo")
  end,
}
