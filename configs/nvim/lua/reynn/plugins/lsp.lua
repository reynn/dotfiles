local lsp = {}

function lsp.setup(opts)
  local map = require("reynn.utils").map
  local lsp_config = require("lspconfig")
  local lsp_install = require("lspinstall")

  lsp_install.setup()
  -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
  lsp_install.post_install_hook = function()
    require("reynn.lsp").setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
  end

  local servers = lsp_install.installed_servers()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits"
    }
  }

  vim.loop.new_async(
    vim.schedule_wrap(
      function()
        for _, server in pairs(servers) do
          lsp_config[server].setup(
            {
              on_attach = lsp.lsp_config_on_attach,
              capabilities = capabilities
            }
          )
        end
      end
    )
  ):send()

  map({"i", "s"}, "<Tab>", "v:lua.tab_complete()", {expr = true})
  map({"i", "s"}, "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

  require("lsp_extensions").inlay_hints {
    highlight = "Comment",
    prefix = " > ",
    aligned = true,
    only_current_line = false,
    enabled = {"TypeHint", "ChainingHint"}
  }
end

lsp.desired_language_servers = {
  "bash",
  "dockerfile",
  "go",
  "graphql",
  "html",
  "json",
  "lua",
  "python",
  "rust",
  "vim",
  "yaml"
}

function lsp.install_servers()
  local lsp_install = require("lspinstall")
  lsp_install.setup()
  for _, server in ipairs(lsp.desired_language_servers) do
    print(string.format("Installing the %q language server", server))
    lsp_install.install_server(server)
  end
end

function lsp.lsp_config_on_attach(client, bufnr)
  local lsp_status = require("lsp-status")
  lsp_status.register_progress()
  local function map(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- intiialize LSP status
  lsp_status.on_attach(client)

  require("lspsaga").init_lsp_saga()

  -- Attach LSP Signature
  require("lsp_signature").on_attach(
    {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      -- If you want to hook lspsaga or other signature handler, pls set to false
      doc_lines = 3, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
      -- set to 0 if you DO NOT want any API comments be shown
      -- This setting only take effect in insert mode, it does not affect signature help in normal
      -- mode, 10 by default

      floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
      fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
      hint_enable = true, -- virtual hint enable
      hint_prefix = "🐼 ", -- Panda for parameter
      hint_scheme = "String",
      use_lspsaga = true, -- set to true if you want to use lspsaga popup
      hi_parameter = "Search", -- how your parameter will be highlight
      max_height = 10, -- max height of signature floating_window, if content is more than max_height, you can scroll down
      -- to view the hiding contents
      max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
      handler_opts = {
        border = "shadow" -- double, single, shadow, none
      },
      extra_trigger_chars = {} -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    }
  )

  -- Mappings.
  local opts = {noremap = true, silent = true}

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map("n", "K", '<Cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
  map("n", "<C-k>", '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
  map("n", "<leader>gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  map("n", "<leader>gd", '<Cmd>lua require("lspsaga.provider").preview_definition()<CR>', opts)
  map("n", "<leader>gr", '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
  map("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  map("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  map("n", "<leader>ca", '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
  map("v", "<leader>ca", ':<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>', opts)
  map("n", "<leader>e", '<cmd>lua require("lspsaga.diagnostic").show_line_diagnostics()<CR>', opts)
  map("n", "[d", '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<CR>', opts)
  map("n", "]d", '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<CR>', opts)
  map("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  map("n", "<leader>bf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- scroll down hover doc or scroll in definition preview
  map("n", "<C-f>", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', opts)
  -- scroll up hover doc
  map("n", "<C-b>", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', opts)
end

return lsp
