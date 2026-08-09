return {
  {
    'nvim-lualine/lualine.nvim',

    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },

    config = function()
      -----------------------------------------------------------
      -- MODE
      -----------------------------------------------------------
      --
      -- Shows the current Vim mode.
      --
      -- Example:
      --  NORMAL
      --  INSERT
      --  VISUAL
      -----------------------------------------------------------

      local mode = {
        'mode',

        fmt = function(str)
          return ' ' .. str
        end,
      }

      -----------------------------------------------------------
      -- FILENAME
      -----------------------------------------------------------
      --
      -- Shows the current filename.
      --
      -- file_status = true
      --   Shows modified / readonly indicators.
      --
      -- path = 0
      --   Only show the filename.
      -----------------------------------------------------------

      local filename = {
        'filename',

        file_status = true,

        path = 0,

        -- Don't display an empty filename.
        shorting_target = 40,
      }

      -----------------------------------------------------------
      -- WINDOW WIDTH CHECK
      -----------------------------------------------------------
      --
      -- Some information can be hidden when the window is
      -- narrow so Lualine doesn't become overcrowded.
      -----------------------------------------------------------

      local hide_in_width = function()
        return vim.fn.winwidth(0) > 100
      end

      -----------------------------------------------------------
      -- DIAGNOSTICS
      -----------------------------------------------------------
      --
      -- Shows LSP diagnostics:
      --
      --  errors
      --  warnings
      -----------------------------------------------------------

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

        -- Let the colorscheme handle the appearance.
        colored = false,

        -- Don't constantly update while typing.
        update_in_insert = false,

        -- Don't show empty diagnostic sections.
        always_visible = false,

        -- Hide when the window is narrow.
        cond = hide_in_width,
      }

      -----------------------------------------------------------
      -- GIT DIFF
      -----------------------------------------------------------
      --
      -- Shows changes in the current file:
      --
      --  added
      --  modified
      --  removed
      -----------------------------------------------------------

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

        ---------------------------------------------------------
        -- OPTIONS
        ---------------------------------------------------------

        options = {

          -- Enable Nerd Font icons.
          icons_enabled = true,

          -- `auto` lets Lualine use your colorscheme.
          theme = 'auto',

          -------------------------------------------------------
          -- IMPORTANT
          --
          -- Normally every split gets its own statusline.
          --
          -- globalstatus = true
          --
          -- makes one Lualine span the entire Neovim window.
          -------------------------------------------------------

          globalstatus = true,

          -------------------------------------------------------
          -- Keep separators simple.
          --
          -- This gives a cleaner LazyVim-like appearance.
          -------------------------------------------------------

          section_separators = {
            left = '',
            right = '',
          },

          component_separators = {
            left = '│',
            right = '│',
          },

          -------------------------------------------------------
          -- Don't show Lualine inside these windows.
          -------------------------------------------------------

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

          -- Keep the middle section properly divided.
          always_divide_middle = true,
        },

        ---------------------------------------------------------
        -- ACTIVE STATUSLINE
        ---------------------------------------------------------

        sections = {

          -------------------------------------------------------
          -- LEFT
          -------------------------------------------------------

          -- Current Vim mode.
          lualine_a = {
            mode,
          },

          -- Git branch.
          lualine_b = {
            {
              'branch',

              -- Only display if inside a Git repository.
              cond = function()
                return vim.b.gitsigns_head ~= nil or vim.fn.FugitiveHead() ~= ''
              end,
            },
          },

          -- Filename.
          lualine_c = {
            filename,
          },

          -------------------------------------------------------
          -- RIGHT
          -------------------------------------------------------

          -- Diagnostics, diff, encoding and filetype.
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

          -- Cursor position.
          lualine_y = {
            'location',
          },

          -- File progress.
          lualine_z = {
            'progress',
          },
        },

        ---------------------------------------------------------
        -- INACTIVE SPLITS
        ---------------------------------------------------------
        --
        -- Because globalstatus is enabled, this section is
        -- mostly a fallback for special situations.
        --
        -- Keep it minimal.
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
        --
        -- Empty because we're using the normal statusline.
        ---------------------------------------------------------

        tabline = {},

        ---------------------------------------------------------
        -- EXTENSIONS
        ---------------------------------------------------------
        --
        -- Allows Lualine to work nicely with Fugitive.
        ---------------------------------------------------------

        extensions = {
          'fugitive',
        },
      }

      -----------------------------------------------------------
      -- SPLIT SEPARATOR
      -----------------------------------------------------------
      --
      -- Makes the line between Neovim splits thin and subtle.
      --
      -- This is NOT part of Lualine.
      -- Neovim itself draws this separator.
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
