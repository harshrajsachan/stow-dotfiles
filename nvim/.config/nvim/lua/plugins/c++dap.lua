return {
  'mfussenegger/nvim-dap',

  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
  },

  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dapui.setup()

    -- Open UI when debugging starts
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end

    -- Close UI when debugging ends
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    -- GDB
    dap.adapters.cppdbg = {
      type = 'executable',
      command = 'gdb',
      args = { '-i', 'dap' },
    }

    -- C / C++
    dap.configurations.cpp = {
      {
        name = 'Launch C++',
        type = 'cppdbg',
        request = 'launch',

        program = function()
          return vim.fn.input('Executable: ', vim.fn.getcwd() .. '/', 'file')
        end,

        cwd = '${workspaceFolder}',

        stopAtBeginningOfProgram = false,

        setupCommands = {
          {
            text = '-enable-pretty-printing',
            description = 'Enable pretty printing',
            ignoreFailures = false,
          },
        },
      },
    }

    -- C uses the same debugger configuration
    dap.configurations.c = dap.configurations.cpp
  end,
}
