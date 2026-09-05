return {
  'harshrajsachan/omni.nvim',
  lazy = false, -- load during startup if OmniTheme is your main colorscheme
  priority = 1000, -- load before other start plugins

  config = function()
    vim.g.omnitheme_transparent = true

    -- Choose your flavour.
    vim.cmd 'colorscheme blackout'
  end,
}
