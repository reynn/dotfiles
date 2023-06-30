return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = {
        "python",
        "delve",
        "codelldb",
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = {
        "gofumpt",
        "jsonlint",
        "markdownlint",
        "prettier",
        "revive",
        "stylua",
        "yamllint",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "bashls",
        "dockerls",
        "gopls",
        "jdtls",
        "jedi_language_server",
        "jsonls",
        "rust_analyzer",
        "lua_ls",
        "taplo",
        "yamlls",
      },
    },
  },
}
