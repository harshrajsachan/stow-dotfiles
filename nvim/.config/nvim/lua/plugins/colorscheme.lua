return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,

  opts = {
    flavour = 'mocha',

    color_overrides = {
      mocha = {
        base = '#000000',
        mantle = '#000000',
        crust = '#000000',
      },
    },
  },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,

    opts = {
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,

      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },

      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,

      inverse = true,
      contrast = '',

      palette_overrides = {},
      overrides = {},

      dim_inactive = false,
      transparent_mode = true,
    },
  },
}
