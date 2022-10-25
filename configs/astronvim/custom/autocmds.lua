local map = vim.keymap.set
local create_au = vim.api.nvim_create_autocmd

create_au("BufEnter", {
  desc = "apply settings for proper Go",
  pattern = "*.go",
  command = "setlocal tabstop=4 shiftwidth=4",
})

create_au("VimLeave", {
  desc = "Stop running auto compiler",
  pattern = "*",
  command = "!autocomp %:p stop",
})

create_au("FileType", {
  desc = "Make q close dap floating windows",
  pattern = "dap-float",
  callback = function()
    map("n", "q", "<cmd>close!<cr>")
  end,
})

create_au({ "BufNewFile", "BufRead" }, {
  pattern = "*.dockerfile",
  callback = function()
    vim.bo.filetype = "dockerfile"
  end,
})

create_au("FileType", {
  desc = "Disable indent scope for certain buffer types",
  callback = function()
    if vim.tbl_contains({
      "NvimTree",
      "TelescopePrompt",
      "Trouble",
      "alpha",
      "help",
      "lsp-installer",
      "lspinfo",
      "neo-tree",
      "neogitstatus",
      "packer",
      "startify",
    }, vim.bo.filetype) or vim.tbl_contains({
      "nofile",
      "terminal",
    }, vim.bo.buftype)
    then
      vim.b.miniindentscope_disable = true
    end
  end,
})
