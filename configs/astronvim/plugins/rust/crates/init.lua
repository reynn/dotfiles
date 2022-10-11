return {
  after = "nvim-cmp",
  event = { "BufRead Cargo.toml" },
  requires = { "plenary.nvim" },
  config = function()
    require("user.plugins.rust.crates.config")
  end,
}
