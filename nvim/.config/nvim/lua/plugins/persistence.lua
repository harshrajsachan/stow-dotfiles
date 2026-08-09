return {
  {
    'folke/persistence.nvim',

    -- Load persistence when opening a real file.
    event = 'BufReadPre',

    config = function()
      require('persistence').setup {
        -- Store sessions here.
        dir = vim.fn.stdpath 'state' .. '/sessions/',

        -- What should be restored.
        options = {
          'buffers',
          'curdir',
          'tabpages',
          'winsize',
        },

        -- Only create a session when there is at least
        -- one real buffer.
        need = 1,

        -- Separate sessions for Git branches.
        branch = true,
      }
    end,
  },
}
