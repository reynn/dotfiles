local map = require('reynn.utils').map
local M = {}

M.desired_language_servers = function()
  return {
    'bash',
    'dockerfile',
    'go',
    'graphql',
    'html',
    'json',
    'lua',
    'python',
    'rust',
    'vim',
    'yaml',
  }
end

M.install_servers = function()
  local desired_servers = M.desired_language_servers()
  local lsp_install = require('lspinstall')
  lsp_install.setup()
  for _, server in ipairs(desired_servers) do
    print(string.format("Installing the %q language server", server))
    lsp_install.install_server(server)
  end
end

local function lsp_config_on_attach(client, bufnr)
  local lsp_status = require('lsp-status')
  lsp_status.register_progress()
  local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- intiialize LSP status
  lsp_status.on_attach(client)

  -- Attach LSP Signature
  require("lsp_signature").on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
                -- If you want to hook lspsaga or other signature handler, pls set to false
    doc_lines = 3, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                  -- set to 0 if you DO NOT want any API comments be shown
                  -- This setting only take effect in insert mode, it does not affect signature help in normal
                  -- mode, 10 by default

    floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
    fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
    hint_enable = true, -- virtual hint enable
    hint_prefix = "🐼 ",  -- Panda for parameter
    hint_scheme = "String",
    use_lspsaga = false,  -- set to true if you want to use lspsaga popup
    hi_parameter = "Search", -- how your parameter will be highlight
    max_height = 10, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                    -- to view the hiding contents
    max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    handler_opts = {
      border = "shadow"   -- double, single, shadow, none
    },
    extra_trigger_chars = {} -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  })

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  map('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  map("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

M.setup_servers = function()
  local lsp_config = require('lspconfig')

  local lsp_install = require('lspinstall')
  lsp_install.setup()
  local servers = lsp_install.installed_servers()

  vim.loop.new_async(vim.schedule_wrap(function()
    for _, server in pairs(servers) do
      lsp_config[server].setup({ on_attach = lsp_config_on_attach })
    end
  end)):send()

end

return M
