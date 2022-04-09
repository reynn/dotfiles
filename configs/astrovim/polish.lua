return function()
  local set = vim.opt

  set.scrolloff = 15
  set.sidescrolloff = 15
  set.numberwidth = 4
  set.timeoutlen = 1000 -- I am slow at typing:-/

  -- Set options
  set.relativenumber = true
  set.foldmethod = "expr"
  set.foldexpr = "nvim_treesitter#foldexpr()"
  set.conceallevel = 3

end
