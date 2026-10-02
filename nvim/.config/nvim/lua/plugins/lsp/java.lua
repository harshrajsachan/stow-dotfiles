return {
  -- ─────────────────────────────────────────────
  -- Java LSP + Debugger + Test
  -- ─────────────────────────────────────────────
  {
    'nvim-java/nvim-java',

    ft = 'java',

    dependencies = {
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
      'rcarriga/nvim-dap-ui',
    },

    config = function()
      require('java').setup()

      vim.lsp.enable 'jdtls'

      -- DAP UI
      local dap = require 'dap'
      local dapui = require 'dapui'

      dapui.setup()

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },

  -- ─────────────────────────────────────────────
  -- Formatter
  -- ─────────────────────────────────────────────
  {
    'stevearc/conform.nvim',

    ft = 'java',

    opts = {
      formatters_by_ft = {
        java = { 'google-java-format' },
      },

      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
    },
  },

  -- ─────────────────────────────────────────────
  -- Linter
  -- ─────────────────────────────────────────────
  {
    'mfussenegger/nvim-lint',

    ft = 'java',

    opts = {
      linters_by_ft = {
        java = { 'checkstyle' },
      },
    },
  },
}
