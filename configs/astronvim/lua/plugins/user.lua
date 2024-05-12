---@type LazySpec
return {

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "██████╗ ███████╗██╗   ██╗███╗   ██╗███╗   ██╗",
        "██╔══██╗██╔════╝╚██╗ ██╔╝████╗  ██║████╗  ██║",
        "██████╔╝█████╗   ╚████╔╝ ██╔██╗ ██║██╔██╗ ██║",
        "██╔══██╗██╔══╝    ╚██╔╝  ██║╚██╗██║██║╚██╗██║",
        "██║  ██║███████╗   ██║   ██║ ╚████║██║ ╚████║",
        "╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═══╝╚═╝  ╚═══╝",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },
  { "Darazaki/indent-o-matic",             enabled = false },
  { "NMAC427/guess-indent.nvim",           enabled = false },
  { "famiu/bufdelete.nvim",                enabled = false },
  { "goolord/alpha-nvim",                  enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "machakann/vim-sandwich",              enabled = false },
  { "max397574/better-escape.nvim",        enabled = false },
  { "numToStr/Comment.nvim",               enabled = false },

  { "tpope/vim-repeat", lazy = false },
    {
      "nvim-telescope/telescope-project.nvim",
      lazy = false,
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("project")
      end,
      module = "telescope._extensions.project",
    },
    {
      "cljoly/telescope-repo.nvim",
      lazy = false,
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("repo")
      end,
      module = "telescope._extensions.repo",
    },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
