return {
  {
    -- Fuzzy finder for files, buffers, grep, diagnostics, etc.
    'nvim-telescope/telescope.nvim',

    -- Load Telescope when Neovim starts.
    event = 'VimEnter',

    branch = 'master',

    dependencies = {
      -- Required by Telescope.
      'nvim-lua/plenary.nvim',

      -- Native FZF sorter.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',

        -- Only use it if make is installed.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },

      -- Use Telescope for vim.ui.select().
      {
        'nvim-telescope/telescope-ui-select.nvim',
      },

      -- Icons.
      {
        'nvim-tree/nvim-web-devicons',
        enabled = vim.g.have_nerd_font,
      },
    },

    config = function()
      local telescope = require 'telescope'
      local actions = require 'telescope.actions'
      local builtin = require 'telescope.builtin'
      local themes = require 'telescope.themes'

      -----------------------------------------------------------
      -- TELESCOPE SETUP
      -----------------------------------------------------------

      telescope.setup {

        defaults = {
          -- Use horizontal layout.
          layout_strategy = 'horizontal',

          layout_config = {
            horizontal = {
              -- Results = roughly 50%
              -- Preview = roughly 50%
              preview_width = 0.5,

              -- Search prompt at bottom.
              prompt_position = 'bottom',

              width = 0.95,
              height = 0.90,
            },
          },

          sorting_strategy = 'ascending',

          -- Selected item icon.
          selection_caret = ' ',

          -- Search icon.
          prompt_prefix = '   ',

          -- Shorten long paths.
          path_display = {
            'truncate',
          },

          -- Don't search these.
          file_ignore_patterns = {
            'node_modules',
            '%.git',
            '%.venv',
            '__pycache__',
            '%.cache',
          },

          -------------------------------------------------------
          -- TELESCOPE KEYMAPS
          -------------------------------------------------------

          mappings = {
            i = {
              -- Move selection.
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-j>'] = actions.move_selection_next,

              -- Open.
              ['<C-l>'] = actions.select_default,

              -- Close.
              ['<C-q>'] = actions.close,

              -- Preview scrolling.
              ['<C-u>'] = actions.preview_scrolling_up,
              ['<C-d>'] = actions.preview_scrolling_down,

              -- Quickfix.
              ['<C-x>'] = actions.send_selected_to_qflist,
              ['<C-a>'] = actions.send_to_qflist,

              -- Splits.
              ['<C-s>'] = actions.select_horizontal,
              ['<C-v>'] = actions.select_vertical,

              -- New tab.
              ['<C-t>'] = actions.select_tab,
            },

            n = {
              ['j'] = actions.move_selection_next,
              ['k'] = actions.move_selection_previous,

              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,

              ['q'] = actions.close,

              ['<C-u>'] = actions.preview_scrolling_up,
              ['<C-d>'] = actions.preview_scrolling_down,

              ['<C-x>'] = actions.send_selected_to_qflist,
            },
          },
        },

        ---------------------------------------------------------
        -- INDIVIDUAL PICKERS
        ---------------------------------------------------------

        pickers = {

          -- Find files.
          find_files = {
            -- Include hidden files.
            hidden = true,

            file_ignore_patterns = {
              'node_modules',
              '%.git',
              '%.venv',
              '__pycache__',
              '%.cache',
            },
          },

          -- Live grep.
          live_grep = {
            additional_args = function()
              return {
                '--hidden',

                -- Don't grep node_modules.
                '--glob',
                '!node_modules',

                -- Don't grep .git.
                '--glob',
                '!*.git/*',

                -- Don't grep Python virtual environments.
                '--glob',
                '!*.venv/*',
              }
            end,
          },

          -- Recent files.
          oldfiles = {
            -- Include recent files from all directories.
            cwd_only = false,
          },

          -- Buffers.
          buffers = {
            -- Most recently used first.
            sort_mru = true,

            -- Include current buffer.
            ignore_current_buffer = false,
          },

          -- Diagnostics.
          diagnostics = {
            initial_mode = 'normal',
          },
        },

        ---------------------------------------------------------
        -- TELESCOPE EXTENSIONS
        ---------------------------------------------------------

        extensions = {
          -- Use Telescope for vim.ui.select().
          ['ui-select'] = themes.get_dropdown {
            previewer = false,
          },
        },
      }

      -----------------------------------------------------------
      -- LOAD EXTENSIONS
      -----------------------------------------------------------

      -- Faster FZF sorting.
      pcall(telescope.load_extension, 'fzf')

      -- Telescope-powered UI select.
      pcall(telescope.load_extension, 'ui-select')

      -----------------------------------------------------------
      -- SEARCH
      -----------------------------------------------------------

      -- Help.
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, {
        desc = '[S]earch [H]elp',
      })

      -- Keymaps.
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, {
        desc = '[S]earch [K]eymaps',
      })

      -- Files.
      vim.keymap.set('n', '<leader>sf', builtin.find_files, {
        desc = '[S]earch [F]iles',
      })

      -- Telescope picker list.
      vim.keymap.set('n', '<leader>ss', builtin.builtin, {
        desc = '[S]earch [S]elect Telescope',
      })

      -- Current word.
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, {
        desc = '[S]earch current [W]ord',
      })

      -- Live grep.
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, {
        desc = '[S]earch by [G]rep',
      })

      -- Diagnostics.
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, {
        desc = '[S]earch [D]iagnostics',
      })

      -- Resume previous Telescope picker.
      vim.keymap.set('n', '<leader>sr', builtin.resume, {
        desc = '[S]earch [R]esume',
      })

      -----------------------------------------------------------
      -- RECENT FILES
      -----------------------------------------------------------

      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {
        desc = '[F]ind [R]ecent files',
      })

      -----------------------------------------------------------
      -- BUFFERS
      -----------------------------------------------------------

      vim.keymap.set('n', '<leader>fb', builtin.buffers, {
        desc = '[F]ind [B]uffers',
      })

      -----------------------------------------------------------
      -- GIT FILES
      -----------------------------------------------------------

      vim.keymap.set('n', '<leader>gf', builtin.git_files, {
        desc = '[G]it [F]iles',
      })

      -----------------------------------------------------------
      -- CURRENT BUFFER SEARCH
      -----------------------------------------------------------

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(themes.get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, {
        desc = '[/] Search current buffer',
      })

      -----------------------------------------------------------
      -- GREP OPEN FILES
      -----------------------------------------------------------

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, {
        desc = '[S]earch [/] in Open Files',
      })

      -----------------------------------------------------------
      -- NEOVIM CONFIG
      -----------------------------------------------------------

      vim.keymap.set('n', '<leader>fc', function()
        builtin.find_files {
          cwd = vim.fn.stdpath 'config',
          hidden = true,
        }
      end, {
        desc = '[F]ind [C]onfig File',
      })

      -----------------------------------------------------------
      -- WORD UNDER CURSOR
      -----------------------------------------------------------

      vim.keymap.set('n', '<leader>fw', function()
        builtin.grep_string {
          search = vim.fn.expand '<cword>',
        }
      end, {
        desc = '[F]ind current [W]ord',
      })
    end,
  },
}
