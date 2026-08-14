return {
  {
    'nvim-neo-tree/neo-tree.nvim',

    -- Stable Neo-tree release.
    branch = 'v3.x',

    dependencies = {
      -- Required utility library.
      'nvim-lua/plenary.nvim',

      -- File icons.
      'nvim-tree/nvim-web-devicons',

      -- Neo-tree UI components.
      'MunifTanjim/nui.nvim',
    },

    config = function()
      -----------------------------------------------------------
      -- NEO-TREE SETUP
      -----------------------------------------------------------

      require('neo-tree').setup {

        ---------------------------------------------------------
        -- GENERAL
        ---------------------------------------------------------

        -- Close Neo-tree when it becomes the last remaining window.
        close_if_last_window = true,

        -- Rounded floating-window borders.
        popup_border_style = 'rounded',

        -- KEEP Git integration enabled.
        enable_git_status = true,

        -- Keep diagnostics disabled inside Neo-tree.
        enable_diagnostics = false,

        -- Don't replace special windows.
        open_files_do_not_replace_types = {
          'terminal',
          'trouble',
          'qf',
        },

        -- Normal case-sensitive sorting.
        sort_case_insensitive = false,

        -- Use Neo-tree's default sorting.
        sort_function = nil,

        -----------------------------------------------------------
        -- DEFAULT COMPONENTS
        -----------------------------------------------------------

        default_component_configs = {

          ---------------------------------------------------------
          -- CONTAINER
          ---------------------------------------------------------

          container = {
            -- Don't fade indentation characters.
            enable_character_fade = false,
          },

          ---------------------------------------------------------
          -- INDENT
          ---------------------------------------------------------

          indent = {
            indent_size = 2,
            padding = 1,

            -- Show indentation markers.
            with_markers = true,

            indent_marker = '│',
            last_indent_marker = '└',

            highlight = 'NeoTreeIndentMarker',

            with_expanders = nil,

            expander_collapsed = '',
            expander_expanded = '',

            expander_highlight = 'NeoTreeExpander',
          },

          ---------------------------------------------------------
          -- FILE ICONS
          ---------------------------------------------------------

          icon = {
            folder_closed = '',
            folder_open = '',
            folder_empty = '󰜌',

            default = '*',

            highlight = 'NeoTreeFileIcon',
          },

          ---------------------------------------------------------
          -- MODIFIED FILES
          ---------------------------------------------------------

          modified = {
            symbol = '[+]',
            highlight = 'NeoTreeModified',
          },

          ---------------------------------------------------------
          -- FILE NAME
          ---------------------------------------------------------

          name = {
            trailing_slash = false,

            -- Let Git status affect filename highlighting.
            use_git_status_colors = true,

            highlight = 'NeoTreeFileName',
          },

          ---------------------------------------------------------
          -- GIT STATUS
          ---------------------------------------------------------

          git_status = {

            symbols = {
              -- File was added.
              added = '✚',

              -- File was modified.
              modified = '',

              -- File was deleted.
              deleted = '✖',

              -- File was renamed.
              renamed = '󰁕',

              -- Untracked file.
              untracked = '',

              -- Ignored file.
              ignored = '',

              -- Unstaged changes.
              unstaged = '󰄱',

              -- Staged changes.
              staged = '',

              -- Merge conflict.
              conflict = '',
            },
          },

          ---------------------------------------------------------
          -- FILE SIZE
          ---------------------------------------------------------

          file_size = {
            enabled = false,
            required_width = 64,
          },

          ---------------------------------------------------------
          -- FILE TYPE
          ---------------------------------------------------------

          type = {
            enabled = false,
            required_width = 122,
          },

          ---------------------------------------------------------
          -- LAST MODIFIED
          ---------------------------------------------------------

          last_modified = {
            enabled = false,
            required_width = 88,
          },

          ---------------------------------------------------------
          -- CREATED
          ---------------------------------------------------------

          created = {
            enabled = false,
            required_width = 110,
          },

          ---------------------------------------------------------
          -- SYMLINK
          ---------------------------------------------------------

          symlink_target = {
            enabled = false,
          },
        },

        -----------------------------------------------------------
        -- GLOBAL COMMANDS
        -----------------------------------------------------------

        commands = {},

        -----------------------------------------------------------
        -- MAIN WINDOW
        -----------------------------------------------------------

        window = {

          -- Neo-tree on the left.
          position = 'right',

          -- Your original width.
          width = 30,

          mapping_options = {
            noremap = true,
            nowait = true,
          },

          mappings = {

            -------------------------------------------------------
            -- NAVIGATION
            -------------------------------------------------------

            ['<space>'] = {
              'toggle_node',
              nowait = false,
            },

            ['<2-LeftMouse>'] = 'open',

            ['<cr>'] = 'open',

            ['l'] = 'open',

            ['h'] = 'close_node',

            -------------------------------------------------------
            -- OPENING
            -------------------------------------------------------

            ['S'] = 'open_split',

            ['s'] = 'open_vsplit',

            ['t'] = 'open_tabnew',

            -------------------------------------------------------
            -- DIRECTORY
            -------------------------------------------------------

            ['C'] = 'close_node',

            ['z'] = 'close_all_nodes',

            -------------------------------------------------------
            -- FILE OPERATIONS
            -------------------------------------------------------

            ['a'] = {
              'add',
              config = {
                show_path = 'none',
              },
            },

            ['A'] = 'add_directory',

            ['d'] = 'delete',

            ['r'] = 'rename',

            ['y'] = 'copy_to_clipboard',

            ['x'] = 'cut_to_clipboard',

            ['p'] = 'paste_from_clipboard',

            ['c'] = 'copy',

            ['m'] = 'move',

            -------------------------------------------------------
            -- WINDOW
            -------------------------------------------------------

            ['q'] = 'close_window',

            ['R'] = 'refresh',

            ['?'] = 'show_help',

            ['i'] = 'show_file_details',

            -------------------------------------------------------
            -- GIT NAVIGATION
            -------------------------------------------------------

            -- Previous modified Git file.
            ['[g'] = 'prev_git_modified',

            -- Next modified Git file.
            [']g'] = 'next_git_modified',
          },
        },

        -----------------------------------------------------------
        -- FILESYSTEM
        -----------------------------------------------------------

        filesystem = {

          ---------------------------------------------------------
          -- FILTERED ITEMS
          ---------------------------------------------------------

          filtered_items = {

            -- Don't show filtered files unless toggled.
            visible = false,

            -- Show dotfiles.
            hide_dotfiles = false,

            -- Show Git-ignored files.
            hide_gitignored = false,

            -- Show hidden files.
            hide_hidden = false,

            -- Hide generated/unnecessary files.
            hide_by_name = {
              '.DS_Store',
              'thumbs.db',
              'node_modules',
              '__pycache__',
              '.virtual_documents',
              '.git',
              '.python-version',
              '.venv',
            },

            hide_by_pattern = {},

            always_show = {},

            never_show = {},

            never_show_by_pattern = {},
          },

          ---------------------------------------------------------
          -- FOLLOW CURRENT FILE
          ---------------------------------------------------------

          follow_current_file = {

            -- Automatically reveal the file currently being edited.
            enabled = true,

            -- Don't leave manually opened directories expanded.
            leave_dirs_open = false,
          },

          ---------------------------------------------------------
          -- DIRECTORY GROUPING
          ---------------------------------------------------------

          group_empty_dirs = false,

          ---------------------------------------------------------
          -- NETRW
          ---------------------------------------------------------

          -- Don't hijack Neovim's working directory through netrw.
          hijack_netrw_behavior = 'disabled',

          ---------------------------------------------------------
          -- FILE WATCHER
          ---------------------------------------------------------

          use_libuv_file_watcher = false,

          ---------------------------------------------------------
          -- FILESYSTEM WINDOW
          ---------------------------------------------------------

          window = {
            mappings = {

              -- Go to parent directory.
              ['<bs>'] = 'navigate_up',

              -- Make current directory the Neo-tree root.
              ['.'] = 'set_root',

              -- Toggle hidden files.
              ['H'] = 'toggle_hidden',

              -----------------------------------------------------
              -- GIT MODIFICATIONS
              -----------------------------------------------------

              -- Previous changed file.
              ['[g'] = 'prev_git_modified',

              -- Next changed file.
              [']g'] = 'next_git_modified',
            },
          },

          commands = {},
        },

        -----------------------------------------------------------
        -- BUFFER SOURCE
        -----------------------------------------------------------

        -- Keep this disabled because Telescope handles
        -- buffer searching and Snacks handles buffer utilities.

        -----------------------------------------------------------
        -- GIT STATUS SOURCE
        -----------------------------------------------------------

        -- Git operations themselves are handled by LazyGit.
        --
        -- Neo-tree still shows Git status signs in the filesystem
        -- tree, but we don't need a separate Git-status panel.
      }

      -----------------------------------------------------------
      -- TOGGLE NEO-TREE
      -----------------------------------------------------------

      vim.keymap.set('n', '<leader>e', function()
        local manager = require 'neo-tree.sources.manager'
        local state = manager.get_state 'filesystem'

        if state and state.winid and vim.api.nvim_win_is_valid(state.winid) then
          vim.cmd 'Neotree close'
        else
          vim.cmd 'Neotree filesystem reveal position=right'
        end
      end, {
        noremap = true,
        silent = true,
        desc = 'Toggle Neo-tree',
      })

      -----------------------------------------------------------
      -- REVEAL CURRENT FILE
      -----------------------------------------------------------

      vim.keymap.set('n', '\\', function()
        vim.cmd 'Neotree filesystem reveal position=right'
      end, {
        noremap = true,
        silent = true,
        desc = 'Reveal current file',
      })
    end,
  },
}
