return {
  {
    'nvim-lualine/lualine.nvim',

    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },

    config = function()
      -----------------------------------------------------------
      -- COMPONENTS
      -----------------------------------------------------------

      local mode = {
        'mode',

        fmt = function(str)
          return ' ' .. str
        end,
      }

      local filename = {
        'filename',
        file_status = true,
        path = 0,
        shorting_target = 40,
      }

      local hide_in_width = function()
        return vim.fn.winwidth(0) > 100
      end

      local diagnostics = {
        'diagnostics',

        sources = {
          'nvim_diagnostic',
        },

        sections = {
          'error',
          'warn',
        },

        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
          hint = ' ',
        },

        colored = false,
        update_in_insert = false,
        always_visible = false,
        cond = hide_in_width,
      }

      local diff = {
        'diff',

        colored = false,

        symbols = {
          added = ' ',
          modified = ' ',
          removed = ' ',
        },

        cond = hide_in_width,
      }

      -----------------------------------------------------------
      -- LUALINE SETUP
      -----------------------------------------------------------

      require('lualine').setup {
        options = {
          icons_enabled = true,

          theme = 'auto',

          -- One global Lualine when enabled.
          globalstatus = true,

          section_separators = {
            left = '',
            right = '',
          },

          component_separators = {
            left = '',
            right = '',
          },

          disabled_filetypes = {
            'alpha',
            'dashboard',
            'neo-tree',
            'NvimTree',
            'lazy',
            'mason',
            'TelescopePrompt',
            'TelescopeResults',
          },

          always_divide_middle = true,
        },

        ---------------------------------------------------------
        -- ACTIVE
        ---------------------------------------------------------

        sections = {
          lualine_a = {
            mode,
          },

          lualine_b = {
            {
              'branch',

              cond = function()
                return vim.b.gitsigns_head ~= nil or vim.fn.FugitiveHead() ~= ''
              end,
            },
          },

          lualine_c = {
            filename,
          },

          lualine_x = {
            diagnostics,
            diff,

            {
              'encoding',
              cond = hide_in_width,
            },

            {
              'filetype',
              cond = hide_in_width,
            },
          },

          lualine_y = {
            'location',
          },

          lualine_z = {
            'progress',
          },
        },

        ---------------------------------------------------------
        -- INACTIVE
        ---------------------------------------------------------

        inactive_sections = {
          lualine_a = {},
          lualine_b = {},

          lualine_c = {
            {
              'filename',
              path = 1,

              color = {
                gui = 'italic',
              },
            },
          },

          lualine_x = {
            {
              'location',
              padding = 0,
            },
          },

          lualine_y = {},
          lualine_z = {},
        },

        ---------------------------------------------------------
        -- TABLINE
        ---------------------------------------------------------

        tabline = {},

        ---------------------------------------------------------
        -- EXTENSIONS
        ---------------------------------------------------------

        extensions = {
          'fugitive',
        },
      }

      -----------------------------------------------------------
      -- STATUSLINE STATE
      -----------------------------------------------------------

      local statusline_enabled = false

      -----------------------------------------------------------
      -- FORCE OFF
      -----------------------------------------------------------
      --
      -- Lualine's setup can set laststatus to 3 because
      -- globalstatus = true.
      --
      -- Override it after setup.
      -----------------------------------------------------------

      vim.opt.laststatus = 0

      -----------------------------------------------------------
      -- TOGGLE
      -----------------------------------------------------------

      local function toggle_statusline()
        statusline_enabled = not statusline_enabled

        if statusline_enabled then
          vim.opt.laststatus = 3
        else
          vim.opt.laststatus = 0
        end

        vim.cmd 'redrawstatus'
      end

      -----------------------------------------------------------
      -- KEYMAP
      -----------------------------------------------------------

      vim.keymap.set('n', '<leader>st', toggle_statusline, {
        desc = 'Toggle Statusline',
        silent = true,
      })

      -----------------------------------------------------------
      -- COMMAND
      -----------------------------------------------------------

      vim.api.nvim_create_user_command('StatuslineToggle', function()
        toggle_statusline()
      end, {
        desc = 'Toggle Statusline',
      })

      -----------------------------------------------------------
      -- FINAL STARTUP OVERRIDE
      -----------------------------------------------------------
      --
      -- This runs after VimEnter, when all startup plugins have
      -- finished initializing.
      -----------------------------------------------------------

      vim.api.nvim_create_autocmd('VimEnter', {
        once = true,

        callback = function()
          statusline_enabled = false
          vim.opt.laststatus = 0
          vim.cmd 'redrawstatus'
        end,
      })

      -----------------------------------------------------------
      -- SPLIT SEPARATOR
      -----------------------------------------------------------

      vim.opt.fillchars = {
        vert = '│',
        horiz = '─',

        horizup = '┴',
        horizdown = '┬',

        vertleft = '┤',
        vertright = '├',

        verthoriz = '┼',
      }
    end,
  },
}
