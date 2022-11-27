local dap_ok, dap = pcall(require, "dap")
local dapui_ok, dapui = pcall(require, "dapui")

if not dap_ok and not dapui_ok then
  return
end

dapui.setup({
  icons = {
    expanded = "▾",
    collapsed = "▸",
  },
  mappings = {
    expand = "<cr>",
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        "scopes",
        "breakpoints",
        "stacks",
      },
      size = 30,
      position = "right",
    },
    {
      elements = {
        "repl",
      },
      size = 10,
      position = "bottom",
    },
  },
  floating = {
    border = "rounded",
    mappings = {
      close = {
        "q",
        "<esc>",
      },
    },
  },
  windows = {
    indent = 1,
  },
})

-- add listeners to auto open DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end