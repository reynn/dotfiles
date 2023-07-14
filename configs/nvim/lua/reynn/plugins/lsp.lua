return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      {
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      local lsp = require("lsp-zero")
      lsp.preset("recommended")
      lsp.ensure_installed({
        -- Golang
        'gopls',
        -- 'revive',
        -- Rust
        'rust_analyzer',
        -- Lua
        'lua_ls',
        -- 'luacheck',
        -- 'luaformatter',
        -- Docker
        'dockerls',
        -- Markdown
        -- 'markdownlint',
        -- JSON
        'jsonls',
        -- TOML
        'taplo',
        -- YAML
        'yamlls',
        -- SQL
        'sqlls',
      })

      -- Fix Undefined global 'vim'
      lsp.nvim_workspace()

      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local cmp_mappings = lsp.defaults.cmp_mappings({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        -- Allow both ctrl+y and enter to accept the current autocomplete selection
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<enter>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      })

      lsp.setup_nvim_cmp({
        mapping = cmp_mappings
      })

      lsp.set_preferences({
        suggest_lsp_servers = true,
      })

      lsp.on_attach(function(_, _)
        vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature help" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {desc="Go to definition"})

        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, {desc="Next diagnostics"})
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, {desc="Prev diagnostics"})

        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code actions" })
        vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Diagnostics float" })
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format file" })
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })
        vim.keymap.set("n", "<leader>lR", vim.lsp.buf.references, { desc = "References" })
        vim.keymap.set("n", "<leader>ls", vim.lsp.buf.document_symbol, { desc = "Document symbols" })
        vim.keymap.set("n", "<leader>lS", vim.lsp.buf.workspace_symbol, { desc = "Workspace symbols" })

        require("which-key").register({
          ["<leader>"] = {
            l = {
              name = "LSP",
            }
          },
        })
      end)

      lsp.setup()

      vim.diagnostic.config({
        virtual_text = true
      })
    end
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    lazy = true,
    event = "BufEnter",
  },
}
