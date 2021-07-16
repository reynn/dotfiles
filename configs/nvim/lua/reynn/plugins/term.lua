local Terminal = require('toggleterm.terminal').Terminal
local bufmap = require('reynn.utils').bufmap

local M = {}

M.toggle_git_tui = function()
  return Terminal:new({
    cmd = "lazygit; or gitui; or echo 'No Git UI available'",
    dir = "git_dir",
    direction = "float",
    float_opts = { border = "double" },
    -- function to run on opening the terminal
    on_open = function(term)
      vim.cmd("startinsert!")
      bufmap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    end,
    -- function to run on closing the terminal
    on_close = function(term)
      vim.cmd("Closing terminal")
    end,
  }):toggle()
end

return M
