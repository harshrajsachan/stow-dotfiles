return {
  {
    'saghen/blink.cmp',

    version = '*',

    event = {
      'InsertEnter',
      'CmdlineEnter',
    },

    dependencies = {
      'rafamadriz/friendly-snippets',
    },

    opts = {
      completion = {
        menu = {
          draw = {
            treesitter = {
              'lsp',
            },
          },
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },

      cmdline = {
        enabled = true,

        keymap = {
          preset = 'cmdline',

          ['<Right>'] = false,
          ['<Left>'] = false,
        },

        completion = {
          list = {
            selection = {
              preselect = false,
            },
          },

          menu = {
            auto_show = function()
              return vim.fn.getcmdtype() == ':'
            end,
          },

          ghost_text = {
            enabled = true,
          },
        },
      },

      -- No custom keybindings.
      -- Blink uses its normal/default behavior.
      keymap = {
        preset = 'default',
      },

      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer',
        },
      },

      snippets = {
        preset = 'default',
      },
    },
  },
}
