require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps
require 'core.snippets' -- Custom code snippets
require 'core.theme' -- Custom themes

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require('lazy').setup {
  require 'plugins.neotree',
  require 'plugins.terminal',
  require 'plugins.lazygit',
  require 'plugins.smartrunner',
  require 'plugins.flash',
  require 'plugins.telescope',
  require 'plugins.persistence',
  require 'plugins.which-key',
  require 'plugins.noice',
  require 'plugins.new-file',
  require 'plugins.leet',
  require 'plugins.bufferline',
  require 'plugins.lualine',
  require 'plugins.autocompletion',
  require 'plugins.gitsigns',
  require 'plugins.alpha',
  require 'plugins.snacks',
  require 'plugins.comment',
  require 'plugins.markdown',
  require 'plugins.rhubarb',
  require 'plugins.sleuth',
  require 'plugins.to-do',
  require 'plugins.image',
  require 'plugins.autopair',
  require 'plugins.colorizer',
  require 'plugins.fugitive',
  require 'plugins.tmux-nav',
  require 'plugins.yazi',

  -- LSP
  require 'plugins.lsp.lsp',
  require 'plugins.lsp.mason',
  require 'plugins.lsp.none-ls',

  -- Completion
  require 'plugins.completion.blink',
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
