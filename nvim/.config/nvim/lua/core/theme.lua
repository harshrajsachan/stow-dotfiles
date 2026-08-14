local M = {}

local themes_dir = vim.fn.expand '~/.config/themes'
local current_link = themes_dir .. '/current'

local loaded_theme = nil
local timer = nil

-----------------------------------------------------------
-- Get current theme directory
-----------------------------------------------------------

local function get_current_theme()
  local current_dir = vim.fn.resolve(current_link)

  if current_dir == current_link then
    return nil
  end

  if vim.fn.isdirectory(current_dir) == 0 then
    return nil
  end

  return current_dir
end

-----------------------------------------------------------
-- Fire ColorScheme event
-----------------------------------------------------------

local function trigger_colorscheme()
  local colorscheme = vim.g.colors_name

  if not colorscheme or colorscheme == '' then
    return
  end

  vim.api.nvim_exec_autocmds('ColorScheme', {
    pattern = colorscheme,
    modeline = false,
  })
end

-----------------------------------------------------------
-- Load current global theme
-----------------------------------------------------------

function M.reload()
  local current_dir = get_current_theme()

  if not current_dir then
    return
  end

  local theme_file = current_dir .. '/nvim.lua'

  if vim.fn.filereadable(theme_file) == 0 then
    vim.notify('Neovim theme not found:\n' .. theme_file, vim.log.levels.ERROR, { title = 'Global Theme' })
    return
  end

  ---------------------------------------------------------
  -- Don't reload if theme hasn't changed
  ---------------------------------------------------------

  if current_dir == loaded_theme then
    return
  end

  ---------------------------------------------------------
  -- Load theme
  ---------------------------------------------------------

  local ok, err = pcall(dofile, theme_file)

  if not ok then
    vim.notify('Failed to load theme:\n' .. err, vim.log.levels.ERROR, { title = 'Global Theme' })
    return
  end

  ---------------------------------------------------------
  -- Tell Neovim that the colorscheme changed
  ---------------------------------------------------------

  trigger_colorscheme()

  ---------------------------------------------------------
  -- Remember loaded theme
  ---------------------------------------------------------

  loaded_theme = current_dir
end

-----------------------------------------------------------
-- Initial load
-----------------------------------------------------------

M.reload()

-----------------------------------------------------------
-- Manual reload
-----------------------------------------------------------

vim.api.nvim_create_user_command('ThemeReload', function()
  loaded_theme = nil
  M.reload()
end, {
  desc = 'Reload global theme',
})

-----------------------------------------------------------
-- Check when Neovim gains focus
-----------------------------------------------------------

vim.api.nvim_create_autocmd('FocusGained', {
  callback = function()
    M.reload()
  end,
})

-----------------------------------------------------------
-- Live watcher
-----------------------------------------------------------

timer = vim.uv.new_timer()

timer:start(
  1000,
  1000,
  vim.schedule_wrap(function()
    M.reload()
  end)
)

return M
