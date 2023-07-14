return {
  {
    "echasnovski/mini.bufremove",
    event = "BufEnter",
    config = function()
      require('mini.bufremove').setup({})

      vim.keymap.set("n", "<leader>c", function() MiniBufremove.delete(0) end, { desc = "Close current buffer" })
    end
  },
  {
    "echasnovski/mini.indentscope",
    event = "BufEnter",
    opts = {
      draw = {
        delay = 0,
      },
      options = {
        indent_at_cursor = false,
      },
      symbol = "▏",
    }
  },
  {
    "echasnovski/mini.surround",
    event = "BufEnter",
    keys = {
      "sr",
      "sd",
      "sa",
      "sf",
      "sF",
      "sh",
      "sn",
    },
    opts = {}
  },
  {
    "echasnovski/mini.statusline",
    event = "BufEnter",
    config = function()
      require('mini.statusline').setup({
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git           = MiniStatusline.section_git({ trunc_width = 75 })
            local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location      = MiniStatusline.section_location({ trunc_width = 35 })

            return MiniStatusline.combine_groups({
              { hl = mode_hl,                  strings = { mode } },
              { hl = 'MiniStatuslineDevinfo',  strings = { git, diagnostics } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineFileinfo', strings = { require("lazy.status").updates } },
              { hl = mode_hl,                  strings = { '%l│%2v' } },
            })
          end
        }
      })
    end
  },
  {
    "echasnovski/mini.comment",
    event = "BufEnter",
    opts = {}
  },
}
