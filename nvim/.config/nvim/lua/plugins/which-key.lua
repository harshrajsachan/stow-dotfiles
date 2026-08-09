return {
  {
    'folke/which-key.nvim',

    event = 'VeryLazy',

    opts = {
      preset = 'classic',

      win = {
        no_overlap = false,

        width = {
          min = 35,
          max = 45,
        },

        height = {
          min = 4,
          max = 20,
        },

        -- Right side
        col = math.huge,
        row = math.huge,

        border = 'single',
        padding = { 1, 2 },

        title = true,
        title_pos = 'center',
      },

      layout = {
        width = {
          min = 20,
          max = 35,
        },

        spacing = 3,
        align = 'left',
      },

      icons = {
        mappings = true,
      },

      show_help = true,
      show_keys = true,

      triggers = {
        {
          '<leader>',
          mode = 'n',
        },
      },
    },
  },
}
