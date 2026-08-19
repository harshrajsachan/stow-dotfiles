local M = {}

local themes_dir = vim.fn.expand '~/.config/themes'
local current_link = themes_dir .. '/current'

local loaded_theme = nil

local watcher = nil
local debounce_timer = nil

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
-- Load current global theme
-----------------------------------------------------------

function M.reload()
  local current_dir = get_current_theme()

  if not current_dir then
    return
  end

  ---------------------------------------------------------
  -- Don't reload if theme hasn't changed
  ---------------------------------------------------------

  if current_dir == loaded_theme then
    return
  end

  ---------------------------------------------------------
  -- Theme file
  ---------------------------------------------------------

  local theme_file = current_dir .. '/nvim.lua'

  if vim.fn.filereadable(theme_file) == 0 then
    vim.notify('Neovim theme not found:\n' .. theme_file, vim.log.levels.ERROR, { title = 'Global Theme' })
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
-- Focus fallback
-----------------------------------------------------------

vim.api.nvim_create_autocmd('FocusGained', {
  callback = function()
    M.reload()
  end,
})

-----------------------------------------------------------
-- Filesystem watcher
-----------------------------------------------------------

watcher = vim.uv.new_fs_event()

-----------------------------------------------------------
-- Debounce timer
-----------------------------------------------------------

debounce_timer = vim.uv.new_timer()

local function schedule_reload()
  debounce_timer:stop()

  debounce_timer:start(
    50,
    0,
    vim.schedule_wrap(function()
      M.reload()
    end)
  )
end

-----------------------------------------------------------
-- Watch themes directory
-----------------------------------------------------------

watcher:start(
  themes_dir,
  {},
  vim.schedule_wrap(function()
    schedule_reload()
  end)
)

-----------------------------------------------------------
-- Cleanup
-----------------------------------------------------------

vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function()
    if watcher then
      watcher:stop()
      watcher:close()
      watcher = nil
    end

    if debounce_timer then
      debounce_timer:stop()
      debounce_timer:close()
      debounce_timer = nil
    end
  end,
})

return M
