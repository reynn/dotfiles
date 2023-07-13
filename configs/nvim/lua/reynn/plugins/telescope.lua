return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    config = function()
      require("which-key").register({f = { name = "Telescope" }}, {prefix = "<leader>"})
      vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { silent = true, desc = "Find Files" })
      vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { silent = true, desc = "Find Buffers" })
      vim.keymap.set("n", "<leader>ft", "<cmd>Telescope colorscheme<cr>", { silent = true, desc = "Themes" })
      vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { silent = true, desc = "Words" })
      vim.keymap.set("n", "<leader>fR", "<cmd>Telescope resume<cr>", { silent = true, desc = "Resume last" })
    end
  },
  {
    "nvim-telescope/telescope-project.nvim",
    cmd = "Telescope",
    config = function()
      require("telescope").load_extension("project")
      vim.keymap.set(
        "n",
        "<leader>fp",
        "<cmd>Telescope project<cr>",
        { silent = true, desc = "Find Projects" }
      )
    end,
  },
  {
    "cljoly/telescope-repo.nvim",
    cmd = "Telescope",
    config = function()
      require("telescope").load_extension("repo")
      vim.keymap.set("n", "<leader>fR", "<cmd>Telescope repo<cr>", { silent = true, desc = "Find Repos" })
    end,
  },
  {
    "nvim-telescope/telescope-symbols.nvim",
    cmd = "Telescope",
  }
}
