return function(client, bufnr)
  vim.notify(client.name, "info", { title = "Language Server", timeout = 250 })
end
