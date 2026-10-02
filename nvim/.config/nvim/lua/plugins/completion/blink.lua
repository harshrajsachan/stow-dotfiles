return {
  {
    'saghen/blink.cmp',

    -- Use the latest stable release.
    version = '*',

    -- Load completion when entering Insert mode or command line.
    event = {
      'InsertEnter',
      'CmdlineEnter',
    },

    dependencies = {
      -- Collection of useful snippets.
      'rafamadriz/friendly-snippets',
    },

    opts = {
      -----------------------------------------------------------
      -- NORMAL INSERT-MODE COMPLETION
      -----------------------------------------------------------

      completion = {
        menu = {
          draw = {
            treesitter = {
              'lsp',
            },
          },
        },

        -- Automatically show documentation
        -- when selecting a completion item.
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },

      -----------------------------------------------------------
      -- COMMAND-LINE COMPLETION
      -----------------------------------------------------------

      cmdline = {
        enabled = true,

        keymap = {
          -- Use Blink's command-line keybindings.
          preset = 'cmdline',

          -- Don't let Left/Right accidentally interact
          -- with the completion menu.
          ['<Right>'] = false,
          ['<Left>'] = false,
        },

        completion = {
          list = {
            -- Don't automatically select the first item.
            selection = {
              preselect = false,
            },
          },

          menu = {
            -- Automatically show suggestions when using `:`
            --
            -- Example:
            --
            -- :T
            --
            -- ↓
            --
            -- Telescope
            -- TS...
            -- ...
            auto_show = function()
              return vim.fn.getcmdtype() == ':'
            end,
          },

          -- Show a faint suggestion directly in the command line.
          ghost_text = {
            enabled = true,
          },
        },
      },

      -----------------------------------------------------------
      -- KEYMAP
      -----------------------------------------------------------

      keymap = {
        -- Enter accepts the selected completion.
        preset = 'enter',

        -- Ctrl+y also accepts the current completion.
        ['<C-y>'] = {
          'select_and_accept',
        },
      },

      -----------------------------------------------------------
      -- COMPLETION SOURCES
      -----------------------------------------------------------

      sources = {
        -- These are the normal sources used while coding.
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer',
        },
      },

      -----------------------------------------------------------
      -- SNIPPETS
      -----------------------------------------------------------

      snippets = {
        preset = 'default',
      },
    },
  },
}
