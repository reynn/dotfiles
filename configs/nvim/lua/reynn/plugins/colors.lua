local colors = {}

function colors.setup(opts)
  local vim = vim
  local map = require("reynn.utils").map

  vim.g.gruvbox_flat_style = "dark"
  vim.cmd("colorscheme gruvbox-flat")

  map("n", "<leader>Sc", "<cmd>Telescope colorscheme<CR>", {noremap = true, silent = true})
end

return colors
