local lsp_install = require('lspinstall')

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
lsp_install.post_install_hook = function ()
  require('reynn.lsp').setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
