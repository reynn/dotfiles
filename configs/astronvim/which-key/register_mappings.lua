local function vim_opt_toggle(opt, on, off, name)
  local message = name
  if vim.opt[opt]._value == off then
    vim.opt[opt] = on
    message = message .. " Enabled"
  else
    vim.opt[opt] = off
    message = message .. " Disabled"
  end
  vim.notify(message, "info", {})
end

return {
  n = {
    g = {
      name = "GoTo",
      d = { "Definition" },
      D = { "Declaration" },
      I = { "Implementation" },
      r = { "References" },
      R = { "References (Trouble)" },
      o = { "Open Diagnostics" },
    },
    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "Show Hover"
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
          "Code Actions",
        },
        l = {
          function()
            vim.lsp.codelens.run()
          end,
          "CodeLens Actions",
        }
      },
      N = { "<cmd>tabnew<cr>", "New Buffer" },
      o = {
        name = 'Options',
        c = {
          function()
            vim_opt_toggle("conceallevel", 2, 0, "Conceal")
          end,
          "Toggle Conceal"
        },
        l = {
          function()
            vim_opt_toggle("list", true, false, "List")
          end,
          "Toggle list chars"
        },
      },
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
  },
  v = {
    ["<leader>"] = {
      ["C"] = {
        name = "Crates.io",
        U = {
          function()
            require('crates').upgrade_crates()
          end,
          "Upgrade selected crates"
        },
      },
      x = {
        name = "Debugger",
        e = {
          function()
            require("dapui").eval()
          end,
          "Evaluate Line",
        },
      },
    },
    ["<C-h>"] = {
      function()
        require("syntax-tree-surfer").surf("parent", "visual")
      end,
      "Parent",
    },
    ["<C-l>"] = {
      function()
        require("syntax-tree-surfer").surf("child", "visual")
      end,
      "Child",
    },
    ["<C-j>"] = {
      function()
        require("syntax-tree-surfer").surf("next", "visual", true)
      end,
      "Swap Next",
    },
    ["<C-k>"] = {
      function()
        require("syntax-tree-surfer").surf("prev", "visual", true)
      end,
      "Swap Prev",
    },
  },
  x = {
    ["J"] = {
      function()
        require("syntax-tree-surfer").surf("next", "visual")
      end,
      "Navigate to next TS node",
    },
    ["K"] = {
      function()
        require("syntax-tree-surfer").surf("prev", "visual")
      end,
      "Navigate to previous TS node",
    },
    ["H"] = {
      function()
        require("syntax-tree-surfer").surf("parent", "visual")
      end,
      "Navigate to parent TS node",
    },
    ["L"] = {
      function()
        require("syntax-tree-surfer").surf("child", "visual")
      end,
      "Navigate to child TS node",
    },
  },
  i = {
    ["<c-d>"] = {
      n = { "<c-r>=strftime('%Y-%m-%d')<cr>", "Y-m-d" },
      x = { "<c-r>=strftime('%m/%d/%y')<cr>", "m/d/y" },
      f = { "<c-r>=strftime('%B %d, %Y')<cr>", "B d, Y" },
      X = { "<c-r>=strftime('%H:%M')<cr>", "H:M" },
      F = { "<c-r>=strftime('%H:%M:%S')<cr>", "H:M:S" },
      d = { "<c-r>=strftime('%Y/%m/%d %H:%M:%S -')<cr>", "Y/m/d H:M:S -" },
    }
  },
}
