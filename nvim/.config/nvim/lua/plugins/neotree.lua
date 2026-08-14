return {
  {
    'nvim-neo-tree/neo-tree.nvim',

    branch = 'v3.x',

    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
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

        close_if_last_window = true,

        popup_border_style = 'rounded',

        enable_git_status = true,

        enable_diagnostics = false,

        ---------------------------------------------------------
        -- ONLY FILESYSTEM SOURCE
        --
        -- Prevents Buffers / Git Status from becoming
        -- Neo-tree sources.
        ---------------------------------------------------------

        sources = {
          'filesystem',
        },

        ---------------------------------------------------------
        -- DON'T REPLACE SPECIAL WINDOWS
        ---------------------------------------------------------

        open_files_do_not_replace_types = {
          'terminal',
          'trouble',
          'qf',
          'help',
          'nofile',
        },

        ---------------------------------------------------------
        -- SORTING
        ---------------------------------------------------------

        sort_case_insensitive = false,

        sort_function = nil,

        ---------------------------------------------------------
        -- DEFAULT COMPONENTS
        ---------------------------------------------------------

        default_component_configs = {

          -------------------------------------------------------
          -- CONTAINER
          -------------------------------------------------------

          container = {
            enable_character_fade = false,
          },

          -------------------------------------------------------
          -- INDENT
          -------------------------------------------------------

          indent = {
            indent_size = 2,

            padding = 1,

            with_markers = true,

            indent_marker = '│',

            last_indent_marker = '└',

            highlight = 'NeoTreeIndentMarker',

            with_expanders = nil,

            expander_collapsed = '',

            expander_expanded = '',

            expander_highlight = 'NeoTreeExpander',
          },

          -------------------------------------------------------
          -- FILE ICONS
          -------------------------------------------------------

          icon = {
            folder_closed = '',

            folder_open = '',

            folder_empty = '󰜌',

            default = '*',

            highlight = 'NeoTreeFileIcon',
          },

          -------------------------------------------------------
          -- UNSAVED FILE
          --
          -- [+] means the current Neovim buffer has unsaved
          -- changes.
          -------------------------------------------------------

          modified = {
            symbol = '[+]',

            highlight = 'NeoTreeModified',
          },

          -------------------------------------------------------
          -- FILE NAME
          -------------------------------------------------------

          name = {
            trailing_slash = false,

            -----------------------------------------------------
            -- IMPORTANT:
            --
            -- Keep Git signs but DON'T let Neo-tree recolor
            -- the entire filename orange.
            -----------------------------------------------------

            use_git_status_colors = false,

            highlight = 'NeoTreeFileName',
          },

          -------------------------------------------------------
          -- GIT STATUS
          -------------------------------------------------------

          git_status = {
            symbols = {

              ---------------------------------------------------
              -- ADDED
              ---------------------------------------------------

              added = '✚',

              ---------------------------------------------------
              -- MODIFIED
              ---------------------------------------------------

              modified = '',

              ---------------------------------------------------
              -- DELETED
              ---------------------------------------------------

              deleted = '✖',

              ---------------------------------------------------
              -- RENAMED
              ---------------------------------------------------

              renamed = '󰁕',

              ---------------------------------------------------
              -- UNTRACKED
              ---------------------------------------------------

              untracked = '',

              ---------------------------------------------------
              -- IGNORED
              ---------------------------------------------------

              ignored = '',

              ---------------------------------------------------
              -- UNSTAGED
              ---------------------------------------------------

              unstaged = '󰄱',

              ---------------------------------------------------
              -- STAGED
              ---------------------------------------------------

              staged = '',

              ---------------------------------------------------
              -- CONFLICT
              ---------------------------------------------------

              conflict = '',
            },
          },

          -------------------------------------------------------
          -- FILE SIZE
          -------------------------------------------------------

          file_size = {
            enabled = false,

            required_width = 64,
          },

          -------------------------------------------------------
          -- FILE TYPE
          -------------------------------------------------------

          type = {
            enabled = false,

            required_width = 122,
          },

          -------------------------------------------------------
          -- LAST MODIFIED
          -------------------------------------------------------

          last_modified = {
            enabled = false,

            required_width = 88,
          },

          -------------------------------------------------------
          -- CREATED
          -------------------------------------------------------

          created = {
            enabled = false,

            required_width = 110,
          },

          -------------------------------------------------------
          -- SYMLINK
          -------------------------------------------------------

          symlink_target = {
            enabled = false,
          },
        },

        ---------------------------------------------------------
        -- GLOBAL COMMANDS
        ---------------------------------------------------------

        commands = {},

        ---------------------------------------------------------
        -- MAIN WINDOW
        ---------------------------------------------------------

        window = {

          -------------------------------------------------------
          -- KEEP YOUR ORIGINAL POSITION
          -------------------------------------------------------

          position = 'right',

          -------------------------------------------------------
          -- KEEP YOUR ORIGINAL WIDTH
          -------------------------------------------------------

          width = 30,

          mapping_options = {
            noremap = true,

            nowait = true,
          },

          mappings = {

            -----------------------------------------------------
            -- NAVIGATION
            -----------------------------------------------------

            ['<space>'] = {
              'toggle_node',

              nowait = false,
            },

            ['<2-LeftMouse>'] = 'open',

            ['<cr>'] = 'open',

            ['l'] = 'open',

            ['h'] = 'close_node',

            -----------------------------------------------------
            -- OPENING
            -----------------------------------------------------

            ['S'] = 'open_split',

            ['s'] = 'open_vsplit',

            ['t'] = 'open_tabnew',

            -----------------------------------------------------
            -- DIRECTORY
            -----------------------------------------------------

            ['C'] = 'close_node',

            ['z'] = 'close_all_nodes',

            -----------------------------------------------------
            -- FILE OPERATIONS
            -----------------------------------------------------

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

            -----------------------------------------------------
            -- WINDOW
            -----------------------------------------------------

            ['q'] = 'close_window',

            ['R'] = 'refresh',

            ['?'] = 'show_help',

            ['i'] = 'show_file_details',

            -----------------------------------------------------
            -- GIT NAVIGATION
            -----------------------------------------------------

            ['[g'] = 'prev_git_modified',

            [']g'] = 'next_git_modified',
          },
        },

        ---------------------------------------------------------
        -- FILESYSTEM
        ---------------------------------------------------------

        filesystem = {

          -------------------------------------------------------
          -- FILTERED ITEMS
          -------------------------------------------------------

          filtered_items = {

            -----------------------------------------------------
            -- Don't show filtered files by default
            -----------------------------------------------------

            visible = false,

            -----------------------------------------------------
            -- Show dotfiles
            -----------------------------------------------------

            hide_dotfiles = false,

            -----------------------------------------------------
            -- Show Git ignored files
            -----------------------------------------------------

            hide_gitignored = false,

            -----------------------------------------------------
            -- Show hidden files
            -----------------------------------------------------

            hide_hidden = false,

            -----------------------------------------------------
            -- Files/directories we don't need in the tree
            -----------------------------------------------------

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

          -------------------------------------------------------
          -- FOLLOW CURRENT FILE
          -------------------------------------------------------

          follow_current_file = {
            enabled = true,

            leave_dirs_open = false,
          },

          -------------------------------------------------------
          -- DIRECTORY GROUPING
          -------------------------------------------------------

          group_empty_dirs = false,

          -------------------------------------------------------
          -- NETRW
          -------------------------------------------------------

          hijack_netrw_behavior = 'disabled',

          -------------------------------------------------------
          -- FILE WATCHER
          -------------------------------------------------------

          use_libuv_file_watcher = false,

          -------------------------------------------------------
          -- FILESYSTEM WINDOW
          -------------------------------------------------------

          window = {
            mappings = {

              ---------------------------------------------------
              -- GO TO PARENT DIRECTORY
              ---------------------------------------------------

              ['<bs>'] = 'navigate_up',

              ---------------------------------------------------
              -- SET CURRENT DIRECTORY AS ROOT
              ---------------------------------------------------

              ['.'] = 'set_root',

              ---------------------------------------------------
              -- TOGGLE HIDDEN FILES
              ---------------------------------------------------

              ['H'] = 'toggle_hidden',

              ---------------------------------------------------
              -- GIT NAVIGATION
              ---------------------------------------------------

              ['[g'] = 'prev_git_modified',

              [']g'] = 'next_git_modified',
            },
          },

          commands = {},
        },
      }

      -----------------------------------------------------------
      -- NEO-TREE COLORS
      --
      -- IMPORTANT:
      --
      -- We don't hard-code orange/yellow/red colors here.
      --
      -- Neo-tree follows the currently active colorscheme.
      -- This is especially important because your theme system
      -- can switch colors dynamically.
      -----------------------------------------------------------

      local function setup_neotree_colors()
        ---------------------------------------------------------
        -- Main background
        ---------------------------------------------------------

        vim.api.nvim_set_hl(0, 'NeoTreeNormal', {
          link = 'Normal',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', {
          link = 'NormalNC',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeEndOfBuffer', {
          link = 'EndOfBuffer',
        })

        ---------------------------------------------------------
        -- Window separator
        ---------------------------------------------------------

        vim.api.nvim_set_hl(0, 'NeoTreeWinSeparator', {
          link = 'WinSeparator',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeVertSplit', {
          link = 'WinSeparator',
        })

        ---------------------------------------------------------
        -- Cursor line
        ---------------------------------------------------------

        vim.api.nvim_set_hl(0, 'NeoTreeCursorLine', {
          link = 'CursorLine',
        })

        ---------------------------------------------------------
        -- File names
        ---------------------------------------------------------

        vim.api.nvim_set_hl(0, 'NeoTreeFileName', {
          link = 'Normal',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeDirectoryName', {
          link = 'Normal',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeFileNameOpened', {
          link = 'Normal',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeDirectoryNameOpened', {
          link = 'Normal',
        })

        ---------------------------------------------------------
        -- Icons
        ---------------------------------------------------------

        vim.api.nvim_set_hl(0, 'NeoTreeFileIcon', {
          link = 'Normal',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeDirectoryIcon', {
          link = 'Normal',
        })

        ---------------------------------------------------------
        -- Unsaved [+]
        ---------------------------------------------------------

        vim.api.nvim_set_hl(0, 'NeoTreeModified', {
          link = 'Normal',
        })

        ---------------------------------------------------------
        -- Indentation
        ---------------------------------------------------------

        vim.api.nvim_set_hl(0, 'NeoTreeIndentMarker', {
          link = 'NonText',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeExpander', {
          link = 'NonText',
        })

        ---------------------------------------------------------
        -- Git signs
        --
        -- Symbols remain visible.
        -- Their colors follow the current colorscheme instead
        -- of becoming orange.
        ---------------------------------------------------------

        vim.api.nvim_set_hl(0, 'NeoTreeGitAdded', {
          link = 'Normal',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeGitModified', {
          link = 'Normal',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeGitDeleted', {
          link = 'Normal',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeGitRenamed', {
          link = 'Normal',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeGitUntracked', {
          link = 'Normal',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeGitIgnored', {
          link = 'Normal',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeGitUnstaged', {
          link = 'Normal',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeGitStaged', {
          link = 'Normal',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeGitConflict', {
          link = 'Normal',
        })

        ---------------------------------------------------------
        -- Root
        ---------------------------------------------------------

        vim.api.nvim_set_hl(0, 'NeoTreeRootName', {
          link = 'Normal',
        })

        ---------------------------------------------------------
        -- Message / dimmed text
        ---------------------------------------------------------

        vim.api.nvim_set_hl(0, 'NeoTreeMessage', {
          link = 'Comment',
        })

        vim.api.nvim_set_hl(0, 'NeoTreeDimText', {
          link = 'Comment',
        })
      end

      -----------------------------------------------------------
      -- APPLY COLORS
      -----------------------------------------------------------

      setup_neotree_colors()

      -----------------------------------------------------------
      -- REAPPLY AFTER COLORScheme CHANGES
      --
      -- This is important for your live theme switching.
      -----------------------------------------------------------

      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
          vim.schedule(function()
            setup_neotree_colors()
          end)
        end,
      })

      -----------------------------------------------------------
      -- NEO-TREE BUFFER CLEANUP
      --
      -- Neo-tree is a UI window, not a normal editing buffer.
      --
      -- Don't let Neo-tree appear in :ls.
      --
      -- bufhidden = wipe means when the Neo-tree window is
      -- actually closed, its buffer is destroyed instead of
      -- being left around.
      -----------------------------------------------------------

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'neo-tree',
        callback = function(args)
          vim.bo[args.buf].buflisted = false
          vim.bo[args.buf].bufhidden = 'wipe'
          vim.bo[args.buf].swapfile = false
          vim.bo[args.buf].undofile = false
        end,
      })

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
