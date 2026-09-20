return {
  {
    dir = vim.fn.expand '~/project/omni.nvim',
    name = 'omni.nvim',
    lazy = false,
    priority = 1000,

    config = function()
      vim.cmd.colorscheme 'omni-velvet'
    end,
  },
}
