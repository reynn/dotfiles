return {
  setup = function(ops)
    local map = require("reynn.utils").map

    map("n", "<leader>lr", "<cmd>RustRunnables<CR>", {noremap = true})
    map("n", "<leader>lth", "<cmd>RustToggleInlayHints<CR>", {noremap = true})
    map("n", "<leader>lc", "<cmd>RustOpenCargo<CR>", {noremap = true})
    map("n", "<leader>lpm", "<cmd>RustParentModule<CR>", {noremap = true})

    require("rust-tools").setup({})
  end
}
