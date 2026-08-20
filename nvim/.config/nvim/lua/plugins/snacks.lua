return {
  {
    -- Neovim utilities.
    'folke/snacks.nvim',

    event = 'VeryLazy',

    keys = {

      ---------------------------------------------------------
      -- LAZYGIT
      ---------------------------------------------------------

      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'LazyGit',
      },

      {
        '<leader>gl',
        function()
          Snacks.lazygit.log()
        end,
        desc = 'LazyGit Logs',
      },

      ---------------------------------------------------------
      -- GIT WORKFLOW
      ---------------------------------------------------------

      -- What has changed?
      {
        '<leader>gs',
        function()
          Snacks.picker.git_status()
        end,
        desc = 'Git Status',
      },

      -- See changes/diffs.
      {
        '<leader>gd',
        function()
          Snacks.picker.git_diff()
        end,
        desc = 'Git Diff',
      },

      -- Branch management.
      {
        '<leader>gb',
        function()
          Snacks.picker.git_branches()
        end,
        desc = 'Git Branches',
      },

      -- Stashes.
      {
        '<leader>gS',
        function()
          Snacks.picker.git_stash()
        end,
        desc = 'Git Stash',
      },

      -- History of current file.
      {
        '<leader>gF',
        function()
          Snacks.picker.git_log_file()
        end,
        desc = 'Git File History',
      },

      -- History of current line.
      {
        '<leader>gL',
        function()
          Snacks.picker.git_log_line()
        end,
        desc = 'Git Line History',
      },

      ---------------------------------------------------------
      -- NEOVIM UTILITIES
      ---------------------------------------------------------

      -- Undo tree/history.
      {
        '<leader>su',
        function()
          Snacks.picker.undo()
        end,
        desc = 'Undo History',
      },

      -- Marks.
      {
        '<leader>sm',
        function()
          Snacks.picker.marks()
        end,
        desc = 'Marks',
      },

      -- Jump history.
      {
        '<leader>sj',
        function()
          Snacks.picker.jumps()
        end,
        desc = 'Jumps',
      },

      -- Projects.
      {
        '<leader>fp',
        function()
          Snacks.picker.projects()
        end,
        desc = 'Projects',
      },

      ---------------------------------------------------------
      -- FILE OPERATIONS
      ---------------------------------------------------------

      {
        '<leader>rN',
        function()
          Snacks.rename.rename_file()
        end,
        desc = 'Rename Current File',
      },

      {
        '<leader>dB',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete Buffer',
      },

      ---------------------------------------------------------
      -- COLORSCHEME
      ---------------------------------------------------------

      {
        '<leader>th',
        function()
          Snacks.picker.colorschemes {
            layout = 'ivy',
          }
        end,
        desc = 'Pick Color Scheme',
      },
    },

    opts = {

      -----------------------------------------------------------
      -- PICKER
      -----------------------------------------------------------

      picker = {
        enabled = true,

        -- Useful for Git/utility pickers.
        hidden = true,
        ignored = true,

        -- Snacks handles vim.ui.select().
        ui_select = true,

        ---------------------------------------------------------
        -- MATCHER
        ---------------------------------------------------------

        matcher = {
          fuzzy = true,
          smartcase = true,
          ignorecase = true,
          filename_bonus = true,
          file_pos = true,
          frecency = true,
        },

        ---------------------------------------------------------
        -- FORMATTERS
        ---------------------------------------------------------

        formatters = {
          file = {
            filename_first = false,
            truncate = 'center',
            min_width = 40,
            icon_width = 2,
            git_status_hl = true,
          },
        },

        ---------------------------------------------------------
        -- PREVIEWERS
        ---------------------------------------------------------

        previewers = {
          file = {
            max_size = 1024 * 1024,
            max_line_length = 500,
          },

          diff = {
            style = 'fancy',
          },
        },

        ---------------------------------------------------------
        -- PICKER LAYOUT
        ---------------------------------------------------------

        layout = {
          cycle = true,

          preset = function()
            if vim.o.columns >= 120 then
              return 'default'
            end

            return 'vertical'
          end,
        },

        ---------------------------------------------------------
        -- LARGE PICKER LAYOUTS
        ---------------------------------------------------------

        layouts = {

          -------------------------------------------------------
          -- DEFAULT
          -------------------------------------------------------

          default = {
            layout = {
              width = 0.92,
              height = 0.90,
            },
          },

          -------------------------------------------------------
          -- VERTICAL
          -------------------------------------------------------

          vertical = {
            layout = {
              width = 0.92,
              height = 0.90,
            },
          },

          -------------------------------------------------------
          -- IVY
          -------------------------------------------------------

          ivy = {
            layout = {
              width = 0.92,
              height = 0.90,
            },
          },
        },

        ---------------------------------------------------------
        -- PICKER WINDOWS
        ---------------------------------------------------------

        win = {

          -------------------------------------------------------
          -- INPUT
          -------------------------------------------------------

          input = {
            keys = {

              ['<C-j>'] = {
                'list_down',
                mode = { 'i', 'n' },
              },

              ['<C-k>'] = {
                'list_up',
                mode = { 'i', 'n' },
              },

              ['<C-d>'] = {
                'preview_scroll_down',
                mode = { 'i', 'n' },
              },

              ['<C-u>'] = {
                'preview_scroll_up',
                mode = { 'i', 'n' },
              },

              ['<C-s>'] = {
                'edit_split',
                mode = { 'i', 'n' },
              },

              ['<C-v>'] = {
                'edit_vsplit',
                mode = { 'i', 'n' },
              },

              ['<C-t>'] = {
                'tab',
                mode = { 'i', 'n' },
              },

              ['<C-q>'] = {
                'qflist',
                mode = { 'i', 'n' },
              },

              ['<Tab>'] = {
                'select_and_next',
                mode = { 'i', 'n' },
              },

              ['<S-Tab>'] = {
                'select_and_prev',
                mode = { 'i', 'n' },
              },

              ['<A-p>'] = {
                'toggle_preview',
                mode = { 'i', 'n' },
              },

              ['<A-h>'] = {
                'toggle_hidden',
                mode = { 'i', 'n' },
              },

              ['<A-i>'] = {
                'toggle_ignored',
                mode = { 'i', 'n' },
              },
            },
          },

          -------------------------------------------------------
          -- LIST
          -------------------------------------------------------

          list = {
            keys = {

              ['j'] = 'list_down',
              ['k'] = 'list_up',

              ['<C-j>'] = 'list_down',
              ['<C-k>'] = 'list_up',

              ['<C-d>'] = 'preview_scroll_down',
              ['<C-u>'] = 'preview_scroll_up',

              ['<CR>'] = 'confirm',
              ['q'] = 'cancel',

              ['<C-s>'] = 'edit_split',
              ['<C-v>'] = 'edit_vsplit',
              ['<C-t>'] = 'tab',

              ['<C-q>'] = 'qflist',

              ['<Tab>'] = 'select_and_next',
              ['<S-Tab>'] = 'select_and_prev',

              ['<A-p>'] = 'toggle_preview',
            },
          },
        },
      },

      -----------------------------------------------------------
      -- EXPLORER
      -----------------------------------------------------------

      explorer = {
        enabled = true,

        trash = true,

        -- Don't replace netrw.
        replace_netrw = false,
      },

      -----------------------------------------------------------
      -- INDENT
      -----------------------------------------------------------

      indent = {
        enabled = true,
      },

      -----------------------------------------------------------
      -- INPUT
      -----------------------------------------------------------

      input = {
        enabled = true,
      },

      -----------------------------------------------------------
      -- SCOPE
      -----------------------------------------------------------

      scope = {
        enabled = true,
      },

      -----------------------------------------------------------
      -- SCROLL
      -----------------------------------------------------------

      scroll = {
        enabled = true,
      },

      -----------------------------------------------------------
      -- WORDS
      -----------------------------------------------------------

      words = {
        enabled = true,
      },

      -----------------------------------------------------------
      -- QUICKFILE
      -----------------------------------------------------------

      quickfile = {
        enabled = false,
      },

      -----------------------------------------------------------
      -- TERMINAL
      -----------------------------------------------------------

      terminal = {
        enabled = true,
      },
    },
  },
}
