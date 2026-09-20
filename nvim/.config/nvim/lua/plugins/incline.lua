return {
  {
    'b0o/incline.nvim',

    event = 'VeryLazy',

    config = function()
      vim.opt.laststatus = 0
      vim.opt.winbar = ''

      local incline = require 'incline'

      incline.setup {
        hide = {
          cursorline = 'smart',
          focused_win = false,
          only_win = false,
        },

        window = {
          placement = {
            horizontal = 'right',
            vertical = 'bottom',
          },

          margin = {
            horizontal = 1,
            vertical = 1,
          },

          padding = {
            left = 1,
            right = 1,
          },

          width = 'fit',

          overlap = {
            borders = true,
            statusline = true,
            tabline = false,
            winbar = false,
          },

          zindex = 50,

          winhighlight = {
            active = {
              Normal = 'Normal',
              EndOfBuffer = 'None',
            },

            inactive = {
              Normal = 'Normal',
              EndOfBuffer = 'None',
            },
          },
        },

        render = function(props)
          if not props.focused then
            return nil
          end

          local line = vim.api.nvim_win_get_cursor(props.win)[1]
          local total = vim.api.nvim_buf_line_count(props.buf)

          local percentage = math.floor((line / math.max(total, 1)) * 100)

          return {
            {
              ' ' .. vim.fn.mode():upper(),
              group = 'StatusLine',
              gui = 'bold',
            },
            {
              '  ' .. percentage .. '%',
              group = 'StatusLine',
              gui = 'bold',
            },
          }
        end,
      }

      vim.api.nvim_create_autocmd({
        'BufEnter',
        'WinEnter',
        'BufWinEnter',
        'WinNew',
      }, {
        callback = function()
          vim.opt_local.winbar = ''
        end,
      })

      vim.api.nvim_create_autocmd({
        'ModeChanged',
        'CursorMoved',
        'CursorMovedI',
        'BufEnter',
        'WinEnter',
      }, {
        callback = function()
          incline.refresh()
        end,
      })
    end,
  },
}
