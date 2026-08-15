return {
  'brenoprata10/nvim-highlight-colors',

  event = { 'BufReadPost', 'BufNewFile' },

  opts = {
    render = 'background',
    enable_named_colors = true,
    enable_tailwind = false,

    exclude_filetypes = {
      'lazy',
      'mason',
      'TelescopePrompt',
      'TelescopeResults',
      'neo-tree',
      'NvimTree',
      'alpha',
      'dashboard',
    },
  },
}
