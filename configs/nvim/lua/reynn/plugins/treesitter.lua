return {
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      mode = "cursor",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
          ensure_installed = {
            "bash",
            "fish",
            "go",
            "json",
            "lua",
            "markdown_inline",
            "markdown",
            "regex",
            "rust",
            "toml",
            "yaml",
          },
          sync_install = false,
          highlight = {
            enable = true,
          },
          indent = {
            enable = true,
          },
        })
    end
  },
}
