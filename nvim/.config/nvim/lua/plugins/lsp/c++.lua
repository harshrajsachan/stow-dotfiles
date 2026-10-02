return {
  -- ─────────────────────────────────────────────
  -- LSP
  -- ─────────────────────────────────────────────
  {
    'neovim/nvim-lspconfig',
    ft = { 'c', 'cpp' },

    opts = {
      servers = {
        clangd = {
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=iwyu',
            '--completion-style=detailed',
          },

          init_options = {
            clangdFileStatus = true,
          },
        },
      },
    },
  },

  -- ─────────────────────────────────────────────
  -- Formatter
  -- ─────────────────────────────────────────────
  {
    'stevearc/conform.nvim',
    ft = { 'c', 'cpp' },

    opts = {
      formatters_by_ft = {
        c = { 'clang_format' },
        cpp = { 'clang_format' },
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
    ft = { 'c', 'cpp' },

    opts = {
      linters_by_ft = {
        c = { 'clangtidy' },
        cpp = { 'clangtidy' },
      },
    },
  },

  -- ─────────────────────────────────────────────
  -- Debugger
  -- ─────────────────────────────────────────────
  {
    'mfussenegger/nvim-dap',
    ft = { 'c', 'cpp' },

    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },

    config = function()
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

      -- GDB
      dap.adapters.gdb = {
        type = 'executable',
        command = 'gdb',
        args = { '-i', 'dap' },
      }

      dap.configurations.cpp = {
        {
          name = 'Launch C++',
          type = 'gdb',
          request = 'launch',

          program = function()
            return vim.fn.input('Executable: ', vim.fn.getcwd() .. '/', 'file')
          end,

          cwd = '${workspaceFolder}',
          stopAtBeginningOfMain = false,
        },
      }

      dap.configurations.c = dap.configurations.cpp
    end,
  },
}
