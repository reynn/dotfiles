local utils = require("user.utils")
local map = vim.keymap.set

utils.augroup("gosettings", {
  {
    event = { "BufEnter" },
    description = "Apply proper settings for Go",
    pattern = "*.go",
    command = "setlocal tabstop=4 shiftwidth=4",
  },
  {
    event = { "BufWritePre" },
    pattern = { "*.go" },
    command = 'silent! lua require("go.format").goimport()',
  },
})

utils.augroup("autocomp", {
  {
    event = { "VimLeave" },
    description = "Stop running auto compiler",
    pattern = "*",
    command = function()
      vim.fn.jobstart({ "autocomp", vim.fn.expand("%:p"), "stop" })
    end,
  },
})

utils.augroup("docker", {
  {
    event = { "BufNewFile", "BufRead" },
    description = "Set filetype for *.dockerfile",
    pattern = "*.dockerfile",
    command = "vim.bo.filetype = 'dockerfile'",
  },
})

utils.augroup("mini", {
  {
    event = { "FileType", "BufEnter" },
    description = "Disable indent scope for content types",
    command = function()
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
      }, vim.bo.filetype) or vim.tbl_contains({ "nofile", "terminal" }, vim.bo.buftype)
      then
        vim.b.miniindentscope_disable = true
      end
    end,
  },
})

utils.augroup("dap", {
  {
    event = "FileType",
    description = "Make q close dap floating windows",
    pattern = "dap-float",
    command = function()
      map("n", "q", "<cmd>close!<cr>")
    end,
  },
})
