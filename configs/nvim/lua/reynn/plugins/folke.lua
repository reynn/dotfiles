return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "BufEnter"
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.timeout = true
      vim.opt.timeoutlen = 300
    end,
    config = function()
      require("which-key").setup({})

      require('which-key').register({
        o = {
          name = "Options",
        },
        p = {
          name = "Packages"
        },
        U = {
          name = "Utils"
        }
      }, {
        prefix = "<leader>"
      })
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    cond = not vim.g.neovide,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true,            -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
    },
    init = function()
      vim.g.lsp_handlers_enabled = false
    end,
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      if not opts.bottom then
        opts.bottom = {}
      end
      table.insert(opts.bottom, {
        ft = "noice",
        size = { height = 0.4 },
        filter = function(_, win)
          return vim.api.nvim_win_get_config(win).relative == ""
        end,
      })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  }
}
