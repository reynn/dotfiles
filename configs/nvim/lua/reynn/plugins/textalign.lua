local text = {}

function text.setup(opts)
  local map = require("reynn.utils").map
  local autocmd = require("reynn.utils").autocmd

  require("formatter").setup(
    {
      filetype = {
        rust = {
          function()
            return {
              exe = "rustfmt",
              args = {"--emit=stdout"},
              stdin = true
            }
          end
        },
        lua = {
          function()
            return {
              exe = "luafmt",
              args = {"--indent-count", 2, "--stdin"},
              stdin = true
            }
          end
        }
      }
    }
  )

  -- EasyAlign keymaps
  map({"n", "x"}, "ta", "<Plug>(EasyAlign)") -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
  map({"n", "x"}, "<leader>tal", ":LiveEasyAlign<CR>") -- Start interactive EasyAlign in live mode
  map({"n", "x"}, "<leader>ta=", ":EasyAlign *=<CR>") -- Align to a `=` character
  map({"n", "x"}, "<leader>ta-", ":EasyAlign *-<CR>") -- Align to a `-` character
  map({"n", "x"}, "<leader>ta,", ":EasyAlign *,<CR>") -- Align to a `,` character
  map({"n", "x"}, "<leader>ta ", ":EasyAlign *\\ <CR>") -- Align to a ` ` character

  -- Formatter keymaps
  map({"n", "x"}, "<leader>bf", ":Format<CR>") -- ,bf to format the current buffer

  autocmd("formatter", {"BufWritePost *.lua,*.rs,*.go FormatWrite"}, true)
end

return text
