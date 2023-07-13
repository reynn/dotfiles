local lazy_nvim_branch = "stable"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=" .. lazy_nvim_branch, -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("reynn")
