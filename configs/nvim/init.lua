local utils = require("reynn.utils")

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return utils.replace_termcodes("<C-n>")
  elseif vim.fn["vsnip#available"](1) == 1 then
    return utils.replace_termcodes("<Plug>(vsnip-expand-or-jump)")
  elseif utils.check_back_space() then
    return utils.replace_termcodes("<Tab>")
  else
    return vim.fn["compe#complete"]()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return utils.replace_termcodes("<C-p>")
  elseif vim.fn["vsnip#jumpable"](-1) == 1 then
    return utils.replace_termcodes("<Plug>(vsnip-jump-prev)")
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return utils.replace_termcodes("<S-Tab>")
  end
end

local packer_install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
  vim.fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", packer_install_path})
  vim.api.nvim_command("packadd packer.nvim")
end

vim.cmd([[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]])
vim.cmd([[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]])
vim.cmd([[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]])
vim.cmd([[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]])
vim.cmd([[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]])
vim.cmd([[command! LspInstallServers lua require('reynn.plugins.lsp').install_servers()]])

require("reynn.sets").setup({})
-- require("reynn.maps").setup({})
require("reynn.autocmds").setup({})
require("reynn.plugins").setup({})
require("reynn.languages").setup({})
