-- Autocmds are automatically loaded on the VeryLazy event
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local bg = "#000000"
    vim.api.nvim_set_hl(0, "Normal", { bg = bg })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = bg })
    vim.api.nvim_set_hl(0, "WinSeparator", { bg = "#000000", fg = "#000000" })
    vim.opt.fillchars = { vert = " " }
    vim.opt.signcolumn = "no"
    vim.opt.colorcolumn = ""
    vim.opt.cursorcolumn = false
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = bg })
  end,
})
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
