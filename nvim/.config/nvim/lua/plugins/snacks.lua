return {
  {
    'folke/snacks.nvim',

    -- Load Snacks immediately.
    lazy = false,

    -- Load Snacks early.
    priority = 1000,

    opts = {

      -----------------------------------------------------------
      -- PICKER
      -----------------------------------------------------------

      picker = {
        enabled = true,

        -- Show hidden files by default.
        hidden = true,

        -- Show Git-ignored files by default.
        ignored = true,

        -- Configure fuzzy matching.
        matcher = {
          -- Enable fuzzy matching.
          fuzzy = true,

          -- Make uppercase searches case-sensitive.
          smartcase = true,

          -- Ignore case for normal searches.
          ignorecase = true,

          -- Give filenames more matching priority.
          filename_bonus = true,

          -- Support file:line:column searches.
          file_pos = true,
        },

        -- Configure file display.
        formatters = {
          file = {
            -- Keep filename and path together.
            filename_first = false,

            -- Truncate long paths from the center.
            truncate = 'center',

            -- Set minimum path width.
            min_width = 40,

            -- Set Nerd Font icon width.
            icon_width = 2,

            -- Use Git highlight groups.
            git_status_hl = true,
          },
        },

        -- Configure preview behavior.
        previewers = {
          file = {
            -- Don't preview files larger than 1 MB.
            max_size = 1024 * 1024,

            -- Limit extremely long lines.
            max_line_length = 500,
          },

          diff = {
            -- Use the fancy diff preview.
            style = 'fancy',
          },
        },

        -- Configure picker layout.
        layout = {
          cycle = true,

          -- Use horizontal layout on wide screens.
          preset = function()
            if vim.o.columns >= 120 then
              return 'default'
            end

            return 'vertical'
          end,
        },

        -- Configure picker windows.
        win = {
          input = {
            keys = {
              -- Move to the next result.
              ['<C-j>'] = {
                'list_down',
                mode = { 'i', 'n' },
              },

              -- Move to the previous result.
              ['<C-k>'] = {
                'list_up',
                mode = { 'i', 'n' },
              },

              -- Scroll the preview down.
              ['<C-d>'] = {
                'preview_scroll_down',
                mode = { 'i', 'n' },
              },

              -- Scroll the preview up.
              ['<C-u>'] = {
                'preview_scroll_up',
                mode = { 'i', 'n' },
              },

              -- Open in horizontal split.
              ['<C-s>'] = {
                'edit_split',
                mode = { 'i', 'n' },
              },

              -- Open in vertical split.
              ['<C-v>'] = {
                'edit_vsplit',
                mode = { 'i', 'n' },
              },

              -- Open in a new tab.
              ['<C-t>'] = {
                'tab',
                mode = { 'i', 'n' },
              },

              -- Send selected items to quickfix.
              ['<C-q>'] = {
                'qflist',
                mode = { 'i', 'n' },
              },

              -- Select item and move down.
              ['<Tab>'] = {
                'select_and_next',
                mode = { 'i', 'n' },
              },

              -- Select item and move up.
              ['<S-Tab>'] = {
                'select_and_prev',
                mode = { 'i', 'n' },
              },

              -- Toggle the preview window.
              ['<A-p>'] = {
                'toggle_preview',
                mode = { 'i', 'n' },
              },

              -- Toggle hidden files.
              ['<A-h>'] = {
                'toggle_hidden',
                mode = { 'i', 'n' },
              },

              -- Toggle Git-ignored files.
              ['<A-i>'] = {
                'toggle_ignored',
                mode = { 'i', 'n' },
              },
            },
          },

          list = {
            keys = {
              -- Move to the next result.
              ['j'] = 'list_down',

              -- Move to the previous result.
              ['k'] = 'list_up',

              -- Move to the next result.
              ['<C-j>'] = 'list_down',

              -- Move to the previous result.
              ['<C-k>'] = 'list_up',

              -- Scroll the preview down.
              ['<C-d>'] = 'preview_scroll_down',

              -- Scroll the preview up.
              ['<C-u>'] = 'preview_scroll_up',

              -- Open the selected item.
              ['<CR>'] = 'confirm',

              -- Close the picker.
              ['q'] = 'cancel',

              -- Open in horizontal split.
              ['<C-s>'] = 'edit_split',

              -- Open in vertical split.
              ['<C-v>'] = 'edit_vsplit',

              -- Open in a new tab.
              ['<C-t>'] = 'tab',

              -- Send selected items to quickfix.
              ['<C-q>'] = 'qflist',

              -- Select item and move down.
              ['<Tab>'] = 'select_and_next',

              -- Select item and move up.
              ['<S-Tab>'] = 'select_and_prev',

              -- Toggle the preview window.
              ['<A-p>'] = 'toggle_preview',
            },
          },
        },
      },

      -- Enable the Snacks file explorer.
      explorer = {
        enabled = true,

        -- Use system trash when deleting.
        trash = true,

        -- Keep netrw unchanged for now.
        replace_netrw = false,
      },

      -- Enable Snacks indent guides.
      indent = {
        enabled = true,
      },

      -- Enable the improved input UI.
      input = {
        enabled = true,
      },

      -- Enable the notification system.
      notifier = {
        enabled = true,

        -- Keep notifications visible for 3 seconds.
        timeout = 3000,
      },

      -- Enable code scope indicators.
      scope = {
        enabled = true,
      },

      -- Enable smooth scrolling.
      scroll = {
        enabled = true,
      },

      -- Enable word reference navigation.
      words = {
        enabled = true,
      },

      -- Enable faster file opening.
      quickfile = {
        enabled = true,
      },

      -- Enable the Snacks terminal.
      terminal = {
        enabled = true,
      },
    },
  },
}
