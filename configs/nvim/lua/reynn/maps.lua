vim.g.mapleader = " "

vim.keymap.set("n", "<leader>q", "<cmd>wqa<cr>", {silent=true,desc="Quit (save all)"})
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<cr>", {silent=true,desc="Quit (discard changes)"})
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", {silent=true,desc="Save file"})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc="Move current line up"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc="Move current line down"})
vim.keymap.set("n", "J", "mzJ`z", {desc="Combine lines (cursor remains@pos)"})

vim.keymap.set("n", "<C-d>", "<C-d>zz", {desc="Half-page down (Center)"})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {desc="Half-page up (Center)"})

vim.keymap.set("n", "n", "nzzzv", {desc="Next search result (Center)"})
vim.keymap.set("n", "N", "Nzzzv", {desc="Prev search result (Center)"})

vim.keymap.set("x", "<leader>p", [["_dP]], {desc="Paste (Keep register)"})
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], {desc="Yank selection (System Clipboard)"})
vim.keymap.set("n", "<leader>Y", [["+Y]], {desc="Yank to EOL (System Clipboard)"})

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", {desc="Next quickfix (Center)"})
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", {desc="Prev quickfix (Center)"})
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", {desc="Next location list (Center)"})
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", {desc="Prev location list (Center)"})

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace current word"})
vim.keymap.set("n", "<leader>Ux", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Mark file executable" })

-- Package managers
vim.keymap.set("n", "<leader>pm", "<cmd>Mason<cr>", { desc="Mason.nvim Info" })
vim.keymap.set("n", "<leader>pl", "<cmd>Lazy sync<cr>", { desc="Lazy.nvim Sync" })
vim.keymap.set("n", "<leader>pL", "<cmd>Lazy show<cr>", { desc="Lazy.nvim Info" })
vim.keymap.set("n", "<leader>pt", "<cmd>TSUpdate<cr>", { desc="TreeSitter Update" })
vim.keymap.set("n", "<leader>pT", "<cmd>TSInstallInfo<cr>", { desc="TreeSitter Info" })

-- Toggles
vim.keymap.set("n", "<leader>oH", "<cmd>TSBufToggle highlight<cr>", { desc="Toggle: TreeSitter Highlight" })
-- vim.keymap.set("n", "<leader>ol", function()
--   if vim.opt.list then
--     print('disabling listchars')
--     vim.opt.list = false
--   else
--     print('enabling listchars')
--     vim.opt.list = true
--   end
-- end, {desc="Toggle: list"})
