return {
  'folke/snacks.nvim',

  ---@type snacks.Config
  opts = {
    terminal = {
      win = {
        style = 'terminal',
      },
    },
  },

  keys = {
    -----------------------------------------------------------
    -- Ctrl-\ : Toggle NORMAL terminal
    -- Uses Neovim's current cwd
    -----------------------------------------------------------
    {
      '<C-\\>',
      function()
        require('snacks').terminal.toggle(nil, {
          id = 'normal-terminal',
          cwd = vim.fn.getcwd(),
        })
      end,
      mode = { 'n', 't' },
      desc = 'Toggle Terminal',
    },

    -----------------------------------------------------------
    -- Ctrl-Shift-\ : Toggle FILE-DIRECTORY terminal
    --
    -- On a keyboard this produces |
    -----------------------------------------------------------
    {
      '<C-S-\\>',
      function()
        local file = vim.api.nvim_buf_get_name(0)

        local cwd = vim.fn.getcwd()

        if file ~= '' then
          cwd = vim.fn.fnamemodify(file, ':p:h')
        end

        require('snacks').terminal.toggle(nil, {
          id = 'file-terminal',
          cwd = cwd,
        })
      end,
      mode = { 'n', 't' },
      desc = 'Toggle Terminal (File Directory)',
    },
  },
}
