return {
  'folke/zen-mode.nvim',
  opts = {
    window = {
      backdrop = 0.95,

      -- 85% of the editor width
      width = 0.85,

      -- Full editor height
      height = 1,

      options = {
        signcolumn = 'no',
        number = false,
        relativenumber = false,
        cursorline = false,
        cursorcolumn = false,
        foldcolumn = '0',
        list = false,
      },
    },

    plugins = {
      options = {
        enabled = true,
        ruler = false,
        showcmd = false,

        -- Hide statusline in Zen Mode
        laststatus = 0,
      },

      twilight = {
        enabled = true,
      },

      gitsigns = {
        enabled = false,
      },

      tmux = {
        enabled = false,
      },

      todo = {
        enabled = false,
      },

      kitty = {
        enabled = false,
        font = '+4',
      },

      alacritty = {
        enabled = false,
        font = '14',
      },

      wezterm = {
        enabled = false,
        font = '+4',
      },

      neovide = {
        enabled = false,
        scale = 1.2,

        disable_animations = {
          neovide_animation_length = 0,
          neovide_cursor_animate_command_line = false,
          neovide_scroll_animation_length = 0,
          neovide_position_animation_length = 0,
          neovide_cursor_animation_length = 0,
          neovide_cursor_vfx_mode = '',
        },
      },
    },

    on_open = function() end,

    on_close = function() end,
  },

  keys = {
    {
      '<leader>zz',
      function()
        require('zen-mode').toggle()
      end,
      desc = 'Toggle Zen Mode',
    },
  },
}
