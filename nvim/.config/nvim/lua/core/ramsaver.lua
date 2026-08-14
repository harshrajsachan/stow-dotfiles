local M = {}

M.enabled = false

-----------------------------------------------------------
-- Tree-sitter
-----------------------------------------------------------

local function stop_treesitter()
  -- Stop Tree-sitter in every loaded buffer
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(bufnr) then
      pcall(vim.treesitter.stop, bufnr)
    end
  end

  -- Disable Tree-sitter based features
  vim.g.loaded_nvim_treesitter = 0
end

local function start_treesitter()
  vim.g.loaded_nvim_treesitter = nil

  -- Restart Tree-sitter for the current buffer
  if vim.bo.filetype ~= '' then
    pcall(vim.treesitter.start)
  end
end

-----------------------------------------------------------
-- LSP
-----------------------------------------------------------

local function stop_lsp()
  -- Stop all currently running LSP clients
  for _, client in ipairs(vim.lsp.get_clients()) do
    pcall(vim.lsp.stop_client, client.id, true)
  end
end

-----------------------------------------------------------
-- Disable
-----------------------------------------------------------

function M.disable()
  if M.enabled then
    return
  end

  M.enabled = true

  ---------------------------------------------------------
  -- Stop Tree-sitter
  ---------------------------------------------------------

  stop_treesitter()

  ---------------------------------------------------------
  -- Stop LSP servers
  ---------------------------------------------------------

  stop_lsp()

  ---------------------------------------------------------
  -- Disable Mason automatic LSP enabling
  ---------------------------------------------------------

  if package.loaded['mason-lspconfig'] then
    local ok, mason_lspconfig = pcall(require, 'mason-lspconfig')

    if ok and mason_lspconfig.setup then
      pcall(mason_lspconfig.setup, {
        automatic_enable = false,
      })
    end
  end

  vim.notify('LOW RAM MODE: Tree-sitter + LSP stopped', vim.log.levels.WARN)
end

-----------------------------------------------------------
-- Enable
-----------------------------------------------------------

function M.enable()
  if not M.enabled then
    return
  end

  M.enabled = false

  ---------------------------------------------------------
  -- Restart Tree-sitter
  ---------------------------------------------------------

  start_treesitter()

  ---------------------------------------------------------
  -- Re-enable LSP
  ---------------------------------------------------------

  vim.cmd 'doautocmd FileType'

  vim.notify('NORMAL MODE: Tree-sitter + LSP restored', vim.log.levels.INFO)
end

-----------------------------------------------------------
-- Toggle
-----------------------------------------------------------

function M.toggle()
  if M.enabled then
    M.enable()
  else
    M.disable()
  end
end

-----------------------------------------------------------
-- Status
-----------------------------------------------------------

function M.status()
  if M.enabled then
    vim.notify('LOW RAM MODE: ON', vim.log.levels.WARN)
  else
    vim.notify('LOW RAM MODE: OFF', vim.log.levels.INFO)
  end
end

return M
