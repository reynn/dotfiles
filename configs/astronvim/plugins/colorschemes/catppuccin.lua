require("catppuccin").setup({
  term_colors = true,
  integrations = {
    indent_blankline = {
      enabled = false,
    },
    lsp_trouble = false,
    neotree = {
      enabled = true,
    },
    nvimtree = {
      enabled = false,
    },
    telescope = true,
    ts_rainbow = true,
    which_key = true,
  },
})
