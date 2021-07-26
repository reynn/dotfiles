local term = {}

function term.setup(opts)
  local map = require("reynn.utils").map

  map("n", "<leader>gu", "<cmd>lua require('reynn.plugins.term').toggle_git_tui()<CR>", {noremap = true, silent = true})

  require("toggleterm").setup {
    hide_numbers = true,
    direction = "float",
    close_on_exit = true,
    float_opts = {
      border = "curved"
    },
    -- size can be a number or function which is passed the current terminal
    size = 20,
    open_mapping = [[<c-\>]],
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = "2", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true
  }
end

function term.toggle_git_tui()
  local bufmap = require("reynn.utils").bufmap
  return require("toggleterm.terminal").Terminal:new(
    {
      cmd = "lazygit 2>/dev/null; or gitui 2>/dev/null; or echo 'No Git UI available'",
      dir = "git_dir",
      direction = "float",
      float_opts = {border = "double"},
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!")
        bufmap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
      end,
      -- function to run on closing the terminal
      on_close = function(term)
        vim.cmd("Closing terminal")
      end
    }
  ):toggle()
end

return term
