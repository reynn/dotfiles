return {
  ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
  f = {
    name = "Telescope",
    ["?"] = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    ["'"] = { "<cmd>Telescope marks<cr>", "Marks" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    B = { "<cmd>Telescope bibtex<cr>", "BibTeX" },
    c = { "<cmd>Telescope commands<cr>", "Commands" },
    f = { "<cmd>Telescope find_files<cr>", "Files" },
    F = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "All Files" },
    h = { "<cmd>Telescope oldfiles<cr>", "History" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    M = { "<cmd>Telescope media_files<cr>", "Media" },
    n = { "<cmd>Telescope notify<cr>", "Notifications" },
    p = { "<cmd>Telescope project<cr>", "Projects" },
    r = { "<cmd>Telescope registers<cr>", "Registers" },
    t = { "<cmd>Telescope colorscheme<cr>", "Themes" },
    w = { "<cmd>Telescope live_grep<cr>", "Words" },
    o = { nil },
  },
  s = {
    name = "Swap",
    b = { nil },
    h = { nil },
    m = { nil },
    n = { nil },
    r = { nil },
    k = { nil },
    c = { nil },
    p = { "Next Parameter" },
    P = { "Previous Parameter" },
  },
  x = {
    name = "Debugger",
    b = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "Toggle Breakpoint",
    },
    B = {
      function()
        require("dap").clear_breakpoints()
      end,
      "Clear Breakpoints",
    },
    c = {
      function()
        require("dap").continue()
      end,
      "Continue",
    },
    i = {
      function()
        require("dap").step_into()
      end,
      "Step Into",
    },
    l = {
      function()
        require("dapui").float_element "breakpoints"
      end,
      "List Breakpoints",
    },
    o = {
      function()
        require("dap").step_over()
      end,
      "Step Over",
    },
    q = {
      function()
        require("dap").close()
      end,
      "Close Session",
    },
    Q = {
      function()
        require("dap").terminate()
      end,
      "Terminate",
    },
    r = {
      function()
        require("dap").repl.toggle()
      end,
      "REPL",
    },
    s = {
      function()
        require("dapui").float_element "scopes"
      end,
      "Scopes",
    },
    t = {
      function()
        require("dapui").float_element "stacks"
      end,
      "Threads",
    },
    u = {
      function()
        require("dapui").toggle()
      end,
      "Toggle Debugger UI",
    },
    w = {
      function()
        require("dapui").float_element "watches"
      end,
      "Watches",
    },
    x = {
      function()
        require("dap.ui.widgets").hover()
      end,
      "Inspect",
    },
  },
}
