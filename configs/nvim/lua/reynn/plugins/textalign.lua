return {
  setup = function(ops)
    local map = require("reynn.utils").map
    local autocmd = require("reynn.utils").autocmd

    -- EasyAlign keymaps
    map({"n", "x"}, "ta", "<Plug>(EasyAlign)") -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
    map({"n", "x"}, "<leader>tal", ":LiveEasyAlign<CR>") -- Start interactive EasyAlign in live mode
    map({"n", "x"}, "<leader>ta=", ":EasyAlign *=<CR>") -- Align to a `=` character
    map({"n", "x"}, "<leader>ta-", ":EasyAlign *-<CR>") -- Align to a `-` character
    map({"n", "x"}, "<leader>ta,", ":EasyAlign *,<CR>") -- Align to a `,` character
    map({"n", "x"}, "<leader>ta ", ":EasyAlign *\\ <CR>") -- Align to a ` ` character

    -- autocmd("formatter", {"BufWritePost *.lua,*.rs,*.go FormatWrite"}, true)
  end
}
