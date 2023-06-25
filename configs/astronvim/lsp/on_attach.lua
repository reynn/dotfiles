return function(_, bufnr)
  local diagnostics_active = true
  vim.keymap.set("n", "<leader>lt", function()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
      vim.diagnostic.show()
    else
      vim.diagnostic.hide()
    end
  end, { buffer = bufnr, desc = "Toggle diagnostics" })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go To Definition" })
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Go To Implementations" })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go To References" })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename Symbol" })
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions" })
end
