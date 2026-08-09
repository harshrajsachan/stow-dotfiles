return {
  {
    'nvim-neo-tree/neo-tree.nvim',

    -- Use the stable v3 branch.
    branch = 'v3.x',

    dependencies = {
      -- Required utility library.
      'nvim-lua/plenary.nvim',

      -- Provides file icons.
      'nvim-tree/nvim-web-devicons',

      -- Provides Neo-tree UI components.
      'MunifTanjim/nui.nvim',

      -- Advanced image preview support, disabled for now.
      -- '3rd/image.nvim',

      -- Advanced window selection support, disabled for now.
      -- {
      --   's1n7ax/nvim-window-picker',
      --   version = '2.*',
      --   config = function()
      --     require('window-picker').setup {
      --       filter_rules = {
      --         include_current_win = false,
      --         autoselect_one = true,
      --         bo = {
      --           filetype = {
      --             'neo-tree',
      --             'neo-tree-popup',
      --             'notify',
      --           },
      --           buftype = {
      --             'terminal',
      --             'quickfix',
      --           },
      --         },
      --       }
      --     }
      --   end,
      -- },
    },

    config = function()
      -- Configure Neo-tree.
      require('neo-tree').setup {

        -- Keep Neo-tree open when it is the last window.
        close_if_last_window = false,

        -- Use rounded floating-window borders.
        popup_border_style = 'rounded',

        -- Disable Git integration to prevent Git-based colors.
        enable_git_status = false,

        -- Disable LSP diagnostics inside Neo-tree.
        enable_diagnostics = false,

        -- Don't replace these special windows.
        open_files_do_not_replace_types = {
          'terminal',
          'trouble',
          'qf',
        },

        -- Keep normal case-sensitive sorting.
        sort_case_insensitive = false,

        -- Use Neo-tree's default sorting.
        sort_function = nil,

        -----------------------------------------------------------
        -- DEFAULT COMPONENTS
        -----------------------------------------------------------

        default_component_configs = {

          -- Configure the tree container.
          container = {
            -- Disable character fading.
            enable_character_fade = false,
          },

          -- Configure indentation.
          indent = {
            -- Set indentation size.
            indent_size = 2,

            -- Add padding around indentation.
            padding = 1,

            -- Show indentation markers.
            with_markers = true,

            -- Set the normal indentation marker.
            indent_marker = '│',

            -- Set the final indentation marker.
            last_indent_marker = '└',

            -- Highlight indentation markers.
            highlight = 'NeoTreeIndentMarker',

            -- Use default expander behavior.
            with_expanders = nil,

            -- Icon for collapsed directories.
            expander_collapsed = '',

            -- Icon for expanded directories.
            expander_expanded = '',

            -- Highlight directory expanders.
            expander_highlight = 'NeoTreeExpander',
          },

          -- Configure file icons.
          icon = {
            -- Icon for closed folders.
            folder_closed = '',

            -- Icon for opened folders.
            folder_open = '',

            -- Icon for empty folders.
            folder_empty = '󰜌',

            -- Fallback file icon.
            default = '*',

            -- Highlight file icons.
            highlight = 'NeoTreeFileIcon',
          },

          -- Configure modified file indicators.
          modified = {
            -- Show modified files with a plus.
            symbol = '[+]',

            -- Use the normal modified highlight.
            highlight = 'NeoTreeModified',
          },

          -- Configure file names.
          name = {
            -- Don't add trailing slashes.
            trailing_slash = false,

            -- Disable Git-based filename colors.
            use_git_status_colors = false,

            -- Highlight file names normally.
            highlight = 'NeoTreeFileName',
          },

          -- Git status configuration disabled because Git integration is disabled.
          -- git_status = {
          --   symbols = {
          --     added = '',
          --     modified = '',
          --     deleted = '✖',
          --     renamed = '󰁕',
          --     untracked = '',
          --     ignored = '',
          --     unstaged = '󰄱',
          --     staged = '',
          --     conflict = '',
          --   },
          -- },

          -- Advanced file-size information disabled for now.
          -- file_size = {
          --   enabled = true,
          --   required_width = 64,
          -- },

          -- Advanced file-type information disabled for now.
          -- type = {
          --   enabled = true,
          --   required_width = 122,
          -- },

          -- Advanced modification-time information disabled for now.
          -- last_modified = {
          --   enabled = true,
          --   required_width = 88,
          -- },

          -- Advanced creation-time information disabled for now.
          -- created = {
          --   enabled = true,
          --   required_width = 110,
          -- },

          -- Symlink target information disabled for now.
          -- symlink_target = {
          --   enabled = false,
          -- },
        },

        -----------------------------------------------------------
        -- GLOBAL COMMANDS
        -----------------------------------------------------------

        -- No custom global commands.
        commands = {},

        -----------------------------------------------------------
        -- MAIN WINDOW
        -----------------------------------------------------------

        window = {
          -- Put Neo-tree on the left.
          position = 'left',

          -- Set Neo-tree width.
          width = 40,

          -- Configure mapping behavior.
          mapping_options = {
            noremap = true,
            nowait = true,
          },

          -- Configure Neo-tree mappings.
          mappings = {

            -- Toggle the selected directory.
            ['<space>'] = {
              'toggle_node',
              nowait = false,
            },

            -- Open with double click.
            ['<2-LeftMouse>'] = 'open',

            -- Open the selected item.
            ['<cr>'] = 'open',

            -- Close the preview or floating window.
            ['<esc>'] = 'cancel',

            -- Advanced floating preview disabled for now.
            -- ['P'] = {
            --   'toggle_preview',
            --   config = {
            --     use_float = true,
            --   },
            -- },

            -- Open the selected item.
            ['l'] = 'open',

            -- Open in horizontal split.
            ['S'] = 'open_split',

            -- Open in vertical split.
            ['s'] = 'open_vsplit',

            -- Open in a new tab.
            ['t'] = 'open_tabnew',

            -- Advanced window picker disabled for now.
            -- ['w'] = 'open_with_window_picker',

            -- Close the current directory.
            ['C'] = 'close_node',

            -- Close all directories.
            ['z'] = 'close_all_nodes',

            -- Create a new file.
            ['a'] = {
              'add',
              config = {
                show_path = 'none',
              },
            },

            -- Create a new directory.
            ['A'] = 'add_directory',

            -- Delete the selected item.
            ['d'] = 'delete',

            -- Rename the selected item.
            ['r'] = 'rename',

            -- Copy the selected item.
            ['y'] = 'copy_to_clipboard',

            -- Cut the selected item.
            ['x'] = 'cut_to_clipboard',

            -- Paste the selected item.
            ['p'] = 'paste_from_clipboard',

            -- Copy to another location.
            ['c'] = 'copy',

            -- Move to another location.
            ['m'] = 'move',

            -- Close Neo-tree.
            ['q'] = 'close_window',

            -- Refresh Neo-tree.
            ['R'] = 'refresh',

            -- Show Neo-tree help.
            ['?'] = 'show_help',

            -- Previous source disabled for now.
            -- ['<'] = 'prev_source',

            -- Next source disabled for now.
            -- ['>'] = 'next_source',

            -- Show file details.
            ['i'] = 'show_file_details',
          },
        },

        -----------------------------------------------------------
        -- FILESYSTEM
        -----------------------------------------------------------

        filesystem = {

          -- Configure hidden and ignored files.
          filtered_items = {

            -- Don't show filtered items.
            visible = false,

            -- Show dotfiles.
            hide_dotfiles = false,

            -- Show Git-ignored files.
            hide_gitignored = false,

            -- Don't hide system hidden files.
            hide_hidden = false,

            -- Hide unnecessary generated files.
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

            -- Don't hide files using patterns.
            hide_by_pattern = {},

            -- Don't force files to stay visible.
            always_show = {},

            -- Don't force files to stay hidden.
            never_show = {},

            -- Don't force-hide files using patterns.
            never_show_by_pattern = {},
          },

          -- Follow the currently active file.
          follow_current_file = {
            -- Automatically reveal the current file.
            enabled = true,

            -- Keep manually opened directories open.
            leave_dirs_open = false,
          },

          -- Don't group empty directories.
          group_empty_dirs = false,

          -- Let Neo-tree handle directory opening.
          hijack_netrw_behavior = 'open_default',

          -- Use filesystem events for updates.
          use_libuv_file_watcher = false,

          -- Configure filesystem mappings.
          window = {
            mappings = {

              -- Navigate to the parent directory.
              ['<bs>'] = 'navigate_up',

              -- Set the current directory as root.
              ['.'] = 'set_root',

              -- Toggle hidden files.
              ['H'] = 'toggle_hidden',

              -- Advanced fuzzy finder disabled for now.
              -- ['/'] = 'fuzzy_finder',

              -- Advanced directory finder disabled for now.
              -- ['D'] = 'fuzzy_finder_directory',

              -- Advanced fuzzy sorter disabled for now.
              -- ['#'] = 'fuzzy_sorter',

              -- Advanced filter disabled for now.
              -- ['f'] = 'filter_on_submit',

              -- Clear the current filter.
              -- ['<C-x>'] = 'clear_filter',

              -- Git modification navigation disabled.
              -- ['[g'] = 'prev_git_modified',

              -- Git modification navigation disabled.
              -- [']g'] = 'next_git_modified',

              -- Advanced sorting menu disabled for now.
              -- ['o'] = {
              --   'show_help',
              --   nowait = false,
              --   config = {
              --     title = 'Order by',
              --     prefix_key = 'o',
              --   },
              -- },

              -- Sort by creation time disabled.
              -- ['oc'] = {
              --   'order_by_created',
              --   nowait = false,
              -- },

              -- Sort by diagnostics disabled.
              -- ['od'] = {
              --   'order_by_diagnostics',
              --   nowait = false,
              -- },

              -- Sort by Git status disabled.
              -- ['og'] = {
              --   'order_by_git_status',
              --   nowait = false,
              -- },

              -- Sort by modification time disabled.
              -- ['om'] = {
              --   'order_by_modified',
              --   nowait = false,
              -- },

              -- Sort by name disabled.
              -- ['on'] = {
              --   'order_by_name',
              --   nowait = false,
              -- },

              -- Sort by size disabled.
              -- ['os'] = {
              --   'order_by_size',
              --   nowait = false,
              -- },

              -- Sort by file type disabled.
              -- ['ot'] = {
              --   'order_by_type',
              --   nowait = false,
              -- },
            },

            -- Advanced fuzzy finder mappings disabled.
            -- fuzzy_finder_mappings = {
            --   ['<down>'] = 'move_cursor_down',
            --   ['<C-n>'] = 'move_cursor_down',
            --   ['<up>'] = 'move_cursor_up',
            --   ['<C-p>'] = 'move_cursor_up',
            -- },
          },

          -- No filesystem-specific commands.
          commands = {},
        },

        -----------------------------------------------------------
        -- BUFFERS
        -----------------------------------------------------------

        -- Neo-tree buffer source disabled because Snacks handles buffers.
        -- buffers = {
        --   follow_current_file = {
        --     enabled = true,
        --     leave_dirs_open = false,
        --   },
        --
        --   group_empty_dirs = true,
        --
        --   show_unloaded = true,
        --
        --   window = {
        --     mappings = {
        --       ['bd'] = 'buffer_delete',
        --       ['<bs>'] = 'navigate_up',
        --       ['.'] = 'set_root',
        --     },
        --   },
        -- },

        -----------------------------------------------------------
        -- GIT STATUS
        -----------------------------------------------------------

        -- Neo-tree Git client disabled because you use LazyGit.
        -- git_status = {
        --   window = {
        --     position = 'float',
        --
        --     mappings = {
        --       ['A'] = 'git_add_all',
        --       ['gu'] = 'git_unstage_file',
        --       ['ga'] = 'git_add_file',
        --       ['gr'] = 'git_revert_file',
        --       ['gc'] = 'git_commit',
        --       ['gp'] = 'git_push',
        --       ['gg'] = 'git_commit_and_push',
        --     },
        --   },
        -- },
      }

      -----------------------------------------------------------
      -- KEYMAPS
      -----------------------------------------------------------

      -- Toggle Neo-tree and reveal the current file when opening.
      vim.keymap.set('n', '<leader>e', function()
        local manager = require 'neo-tree.sources.manager'
        local state = manager.get_state 'filesystem'

        if state and state.winid and vim.api.nvim_win_is_valid(state.winid) then
          vim.cmd 'Neotree close'
        else
          vim.cmd 'Neotree reveal position=left'
        end
      end, {
        noremap = true,
        silent = true,
        desc = 'Toggle Neo-tree',
      })

      -- Reveal the current file using the backslash key.
      vim.keymap.set('n', '\\', '<cmd>Neotree reveal<CR>', {
        noremap = true,
        silent = true,
        desc = 'Reveal current file',
      })

      -- Git status is handled by LazyGit instead.
      -- vim.keymap.set('n', '<leader>ngs', '<cmd>Neotree float git_status<CR>', {
      --   noremap = true,
      --   silent = true,
      --   desc = 'Neo-tree Git status',
      -- })
    end,
  },
}
