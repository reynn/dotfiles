return {
  setup = function(cfg)
    local map = require("reynn.utils").map

    map("n", "<leader>sq", "<cmd>Sayonara<CR>", {noremap = true, silent = true})
  end
}
