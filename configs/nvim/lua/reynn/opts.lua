vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
vim.opt.colorcolumn = "120"
vim.opt.conceallevel = 2
vim.opt.foldenable = false
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.laststatus = 3
vim.opt.list = false
vim.opt.listchars = { space = '␣', tab = '>~', extends = '⟩', precedes = '⟨', eol = '↲', trail = '·' }
vim.opt.numberwidth = 2
vim.opt.showbreak = "↪ "
vim.opt.sidescrolloff = 15
vim.opt.timeoutlen = 100
vim.opt.updatetime = 100
vim.opt.wrap = false

if vim.g.neovide then
  vim.opt.guifont = { "Hasklug Nerd Font", "h9" }
  vim.g.neovide_scale_factor = 0.3
end
