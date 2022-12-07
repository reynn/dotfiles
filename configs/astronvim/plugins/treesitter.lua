local m = {
  ensure_installed = {
    "bash",
    "dockerfile",
    "fish",
    "go",
    "html",
    "java",
    "json",
    "lua",
    "python",
    "rust",
    "toml",
    "yaml",
  },
  sync_install = true,
  highlight = {
    additional_vim_regex_highlighting = { "markdown" },
  },
  rainbow = {
    enable = true,
  },
  matchup = {
    enable = true,
  }
}

local text_objects_ok, _ = pcall(require, "nvim-treesitter-textobjects")
if not text_objects_ok then
  m.textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ax"] = "@class.outer",
        ["ix"] = "@class.inner",
        ["ia"] = "@parameter.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]x"] = "@class.outer",
        ["]p"] = "@parameter.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]X"] = "@class.outer",
        ["]P"] = "@parameter.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[x"] = "@class.outer",
        ["[p"] = "@parameter.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[X"] = "@class.outer",
        ["[P"] = "@parameter.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sp"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>sP"] = "@parameter.inner",
      },
    },
  }
end

return m
