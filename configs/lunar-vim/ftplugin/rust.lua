local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({{ exe = "rustfmt", filetypes = {"rust"} }})

local dap_install = require "dap-install"
dap_install.config("rust", {})

lvim.plugins["simrat39/rust-tools.nvim"] = {
  config = function()
    require("rust-tools").setup({
      tools = {
        autoSetHints = true,
        hover_with_actions = true,
        runnables = {
          use_telescope = true,
        },
      },
      server = {
        cmd = { vim.fn.stdpath("data") .. "/lspinstall/rust/rust-analyzer" },
        on_attach = require("lsp").common_on_attach,
        on_init = require("lsp").common_on_init,
      },
    })
  end,
  ft = { "rust", "rs" },
}
