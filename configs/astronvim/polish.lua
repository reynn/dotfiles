return function()
  require("user.custom.autocmds")
  require("user.custom.mappings")

  if require("core.utils").is_available("bufdelete.nvim") then
    vim.keymap.set("n", "<leader>c", function()
      require("user.utils").alpha_on_bye("Bdelete!")
    end, {
      desc = "Close buffer",
    })
  else
    vim.keymap.set("n", "<leader>c", function()
      require("user.utils").alpha_on_bye("bdelete!")
    end, {
      desc = "Close buffer",
    })
  end
end
