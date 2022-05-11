return {
  g = {
    name = "GoTo",
    d = { "Definition" },
    D = { "Declaration" },
    I = { "Implementation" },
    r = { "References" },
    R = { "References (Trouble)" },
    o = { "Open Diagnostics" },
  },
  ["<leader>"] = {
    C = {
      name = "Crates.io",
      t = {
        function()
          require('crates').toggle()
        end,
        "Toggle extra crates.io information",
      },
      r = {
        function()
          require('crates').reload()
        end,
        "Reload information from crates.io",
      },
      U = {
        function()
          require('crates').upgrade_crate()
        end,
        "Upgrade a crate",
      },
      A = {
        function()
          require('crates').upgrade_all_crates()
        end,
        "Upgrade all crates",
      },
    },
    f = {
      name = "Telescope",
      ["?"] = { "<cmd>Telescope help_tags<cr>", "Find Help" },
      ["'"] = { "<cmd>Telescope marks<cr>", "Marks" },
      a = { "<cmd>Telescope aerial<cr>", "Aerial" },
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
      c = { "<cmd>Telescope commands<cr>", "Commands" },
      f = { "<cmd>Telescope find_files<cr>", "Files" },
      F = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "All Files" },
      h = { "<cmd>Telescope oldfiles<cr>", "History" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      n = { "<cmd>Telescope notify<cr>", "Notifications" },
      p = { "<cmd>Telescope project<cr>", "Projects" },
      P = { "<cmd>Telescope packer<cr>", "Packer" },
      r = { "<cmd>Telescope repo list<cr>", "Repos" },
      R = { "<cmd>Telescope registers<cr>", "Registers" },
      t = { "<cmd>Telescope colorscheme<cr>", "Themes" },
      w = { "<cmd>Telescope live_grep<cr>", "Words" },
      -- o = { nil },
    },
    l = {
      a = {
        function()
          vim.lsp.buf.code_action()
        end,
        "Code Actions"
      }
    },
    N = { "<cmd>tabnew<cr>", "New Buffer" },
    p = {
      C = { ":PackerClean<cr>", "Packer Clean" },
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
    T = {
      name = "Trouble",
      x = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
      w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble Workspace Diagnostics" },
      d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble Document Diagnostics" },
      q = { "<cmd>TroubleToggle quickfix<cr>", "Trouble Quickfix" },
      l = { "<cmd>TroubleToggle loclist<cr>", "Trouble LOC List" },
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
          require("dapui").float_element("breakpoints")
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
          require("dapui").float_element("scopes")
        end,
        "Scopes",
      },
      t = {
        function()
          require("dapui").float_element("stacks")
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
          require("dapui").float_element("watches")
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
    v = {
      name = "Syntax Tree Surfer",
      d = {
        function()
          require("syntax-tree-surfer").move("n", false)
        end,
        "Move TS node down",
      },
      u = {
        function()
          require("syntax-tree-surfer").move("n", true)
        end,
        "Move TS node up",
      },
      x = {
        function()
          require("syntax-tree-surfer").select()
        end,
        "Select TS node",
      },
      n = {
        function()
          require("syntax-tree-surfer").select_current_node()
        end,
        "Select current TS node",
      },
    },
  },
}
