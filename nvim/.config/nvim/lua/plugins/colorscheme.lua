return {
  {
    "metalelf0/black-metal-theme-neovim",
    lazy = false,
    priority = 1000,
    config = function()
      require("black-metal").setup({
        theme = "venom",
      })

      require("black-metal").load()

      -- 🔹 Force transparency AFTER theme loads
      vim.cmd([[
        highlight Normal guibg=NONE ctermbg=NONE
        highlight NormalNC guibg=NONE ctermbg=NONE
        highlight EndOfBuffer guibg=NONE ctermbg=NONE
        highlight SignColumn guibg=NONE ctermbg=NONE
        highlight LineNr guibg=NONE ctermbg=NONE
        highlight FoldColumn guibg=NONE ctermbg=NONE
        highlight CursorLine guibg=NONE ctermbg=NONE
        ]])
    end,
  },
}
