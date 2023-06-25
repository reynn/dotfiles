return {
  "AstroNvim/astrocommunity",

  { import = "astrocommunity.colorscheme.gruvbox-baby" },
  { import = "astrocommunity.comment.mini-comment" },
  { import = "astrocommunity.completion.tabnine-nvim" },
  { import = "astrocommunity.editing-support.mini-splitjoin" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity.editing-support.zen-mode-nvim" },
  { import = "astrocommunity.indent.mini-indentscope" },
  { import = "astrocommunity.lsp.lsp-inlayhints-nvim" },
  { import = "astrocommunity.markdown-and-latex.glow-nvim" },
  { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.nvim-spider" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.syntax.hlargs-nvim" },
  { import = "astrocommunity.syntax.vim-easy-align" },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },

  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        delay = 0,
      },
      options = {
        indent_at_cursor = false,
      },
      symbol = "▏",
    },
  },
}
