return {
  {
    -- Primary search / fuzzy-finding engine.
    'nvim-telescope/telescope.nvim',

    event = 'VimEnter',

    branch = 'master',

    dependencies = {
      'nvim-lua/plenary.nvim',

      -- Native FZF sorter.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },

      -- Telescope replacement for vim.ui.select().
      {
        'nvim-telescope/telescope-ui-select.nvim',
      },

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
      -- TELESCOPE
      -----------------------------------------------------------

      telescope.setup {
        defaults = {

          -------------------------------------------------------
          -- LAYOUT
          -------------------------------------------------------

          layout_strategy = 'horizontal',

          layout_config = {
            horizontal = {
              -- Give the preview more room.
              preview_width = 0.58,

              -- Search prompt at the bottom.
              prompt_position = 'bottom',

              -- Almost full screen.
              width = 0.96,
              height = 0.92,

              -- Small gap between results and preview.
              preview_cutoff = 40,
            },
          },

          -- Results from top to bottom.
          sorting_strategy = 'ascending',

          -- Better for long source-code paths.
          path_display = {
            'truncate',
          },

          -- Search prompt.
          prompt_prefix = '   ',

          -- Selected result.
          selection_caret = ' ',

          -------------------------------------------------------
          -- FILE FILTERING
          -------------------------------------------------------

          file_ignore_patterns = {
            'node_modules',
            '%.git',
            '%.venv',
            '__pycache__',
            '%.cache',
            'target',
            'dist',
            'build',
          },

          -------------------------------------------------------
          -- PREVIEW
          -------------------------------------------------------

          preview = {
            treesitter = true,
          },

          -------------------------------------------------------
          -- INSERT MODE
          -------------------------------------------------------

          mappings = {
            i = {

              -- Move selection.
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,

              -- Confirm.
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

              -- Tab.
              ['<C-t>'] = actions.select_tab,
            },

            -----------------------------------------------------
            -- NORMAL MODE
            -----------------------------------------------------

            n = {

              ['j'] = actions.move_selection_next,
              ['k'] = actions.move_selection_previous,

              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,

              ['q'] = actions.close,

              ['<C-u>'] = actions.preview_scrolling_up,
              ['<C-d>'] = actions.preview_scrolling_down,

              ['<C-x>'] = actions.send_selected_to_qflist,

              ['<C-s>'] = actions.select_horizontal,
              ['<C-v>'] = actions.select_vertical,

              ['<C-t>'] = actions.select_tab,
            },
          },
        },

        ---------------------------------------------------------
        -- INDIVIDUAL PICKERS
        ---------------------------------------------------------

        pickers = {

          -------------------------------------------------------
          -- FILES
          -------------------------------------------------------

          find_files = {
            hidden = true,

            file_ignore_patterns = {
              'node_modules',
              '%.git',
              '%.venv',
              '__pycache__',
              '%.cache',
              'target',
              'dist',
              'build',
            },

            -- Keep preview useful.
            previewer = true,
          },

          -------------------------------------------------------
          -- LIVE GREP
          -------------------------------------------------------

          live_grep = {

            -- Search hidden files.
            additional_args = function()
              return {
                '--hidden',

                '--glob',
                '!node_modules',

                '--glob',
                '!*.git/*',

                '--glob',
                '!*.venv/*',

                '--glob',
                '!__pycache__/*',

                '--glob',
                '!target/*',

                '--glob',
                '!dist/*',

                '--glob',
                '!build/*',
              }
            end,

            -- Large preview for source code.
            layout_config = {
              horizontal = {
                preview_width = 0.62,
                width = 0.98,
                height = 0.94,
              },
            },

            previewer = true,
          },

          -------------------------------------------------------
          -- GREP STRING
          -------------------------------------------------------

          grep_string = {
            additional_args = function()
              return {
                '--hidden',

                '--glob',
                '!node_modules',

                '--glob',
                '!*.git/*',

                '--glob',
                '!*.venv/*',

                '--glob',
                '!target/*',
              }
            end,

            layout_config = {
              horizontal = {
                preview_width = 0.62,
              },
            },
          },

          -------------------------------------------------------
          -- RECENT FILES
          -------------------------------------------------------

          oldfiles = {
            cwd_only = false,
          },

          -------------------------------------------------------
          -- BUFFERS
          -------------------------------------------------------

          buffers = {
            sort_mru = true,
            ignore_current_buffer = false,
          },

          -------------------------------------------------------
          -- DIAGNOSTICS
          -------------------------------------------------------

          diagnostics = {
            initial_mode = 'normal',
          },

          -------------------------------------------------------
          -- HELP
          -------------------------------------------------------

          help_tags = {
            layout_config = {
              horizontal = {
                preview_width = 0.60,
              },
            },
          },

          -------------------------------------------------------
          -- KEYMAPS
          -------------------------------------------------------

          keymaps = {
            layout_config = {
              horizontal = {
                preview_width = 0.55,
              },
            },
          },

          -------------------------------------------------------
          -- GIT FILES
          -------------------------------------------------------

          git_files = {
            show_untracked = true,
          },
        },

        ---------------------------------------------------------
        -- EXTENSIONS
        ---------------------------------------------------------

        extensions = {
          ['ui-select'] = themes.get_dropdown {
            previewer = false,
            width = 0.55,
            preview = false,
          },
        },
      }

      -----------------------------------------------------------
      -- LOAD EXTENSIONS
      -----------------------------------------------------------

      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')

      -----------------------------------------------------------
      -- SEARCH
      -----------------------------------------------------------

      -- Help
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, {
        desc = '[S]earch [H]elp',
      })

      -- Keymaps
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, {
        desc = '[S]earch [K]eymaps',
      })

      -- Files
      vim.keymap.set('n', '<leader>sf', builtin.find_files, {
        desc = '[S]earch [F]iles',
      })

      -- Telescope's own picker selector.
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

      -- Resume.
      vim.keymap.set('n', '<leader>sr', builtin.resume, {
        desc = '[S]earch [R]esume',
      })

      -----------------------------------------------------------
      -- FILES
      -----------------------------------------------------------

      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {
        desc = '[F]ind [R]ecent files',
      })

      vim.keymap.set('n', '<leader>fb', builtin.buffers, {
        desc = '[F]ind [B]uffers',
      })

      -----------------------------------------------------------
      -- GIT FILE SEARCH
      -----------------------------------------------------------

      -- Telescope handles finding files tracked by Git.
      -- Actual Git operations are handled by Snacks/LazyGit.
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
          width = 0.80,
          height = 0.70,
        })
      end, {
        desc = 'Search Current Buffer',
      })

      -----------------------------------------------------------
      -- GREP OPEN FILES
      -----------------------------------------------------------

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',

          layout_config = {
            horizontal = {
              preview_width = 0.62,
              width = 0.98,
              height = 0.94,
            },
          },
        }
      end, {
        desc = '[S]earch [/] Open Files',
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
        desc = '[F]ind Current [W]ord',
      })
    end,
  },
}
