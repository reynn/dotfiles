local finder = {}

function finder.setup(opts)
  local map = require("reynn.utils").map
  local no_remap = {noremap = true}

  local theme_dropdown = 'require("telescope.themes").get_dropdown({})'

  map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files(" .. theme_dropdown .. ")<cr>", no_remap)
  map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep(" .. theme_dropdown .. ")<cr>", no_remap)
  map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers(" .. theme_dropdown .. ")<cr>", no_remap)
  map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags(" .. theme_dropdown .. ")<cr>", no_remap)

  require("telescope").setup {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case"
      },
      prompt_prefix = "> ",
      selection_caret = "> ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          mirror = false
        },
        vertical = {
          mirror = false
        }
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = {},
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      winblend = 0,
      border = {},
      borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
      color_devicons = true,
      use_less = true,
      set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new
    }
  }
  require("telescope").load_extension("gh")
  require("cheatsheet").setup({})
end

return finder
