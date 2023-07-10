local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'gopls',
  'rust_analyzer',
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

-- lsp.skip_server_setup({'rust_analyzer'})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  require("which-key").register({
    ["<C>"] = {
      h = {
        vim.lsp.buf.signature_help,
        "Signature Help"
      }
    },
    g = {
      d = {
        vim.lsp.buf.definitions,
        "GoTo Definitions"
      }
    },
    K = {
      vim.lsp.buf.hover,
      "Show Hover"
    },
    ["<leader>"] = {
      l = {
        name = "LSP",
        a = {
          vim.lsp.buf.code_action,
          "Code Actions"
        },
        d = {
          vim.diagnostic.open_float,
          "Diagnostics Float"
        },
        f = {
          vim.lsp.buf.format,
          "Format"
        },
        r = {
          vim.lsp.buf.rename,
          "Rename Symbol"
        },
        R = {
          vim.lsp.buf.references,
          "References"
        },
        S = {
          vim.lsp.buf.workspace_symbol,
          "Workspace Symbols"
        }
      }
    },
    ["["] = {
      d = {
        vim.diagnostic.goto_next,
        'Next Diagnostics'
      }
    },
    ["]"] = {
      d = {
        vim.diagnostic.goto_prev,
        'Prev Diagnostics'
      }
    }
  })
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})

-- local rust_tools = require('rust-tools')
-- rust_tools.setup({
--   server = {
--     on_attach = function(_, bufnr)
--       vim.keymap.set('n', '<leader>ca', rust_tools.hover_actions.hover_actions, {buffer = bufnr})
--     end
--   }
-- })
