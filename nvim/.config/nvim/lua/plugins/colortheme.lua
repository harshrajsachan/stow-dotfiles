return {
  'oskarnurm/koda.nvim',
  lazy = false,
  priority = 1000,

  config = function()
    vim.cmd.colorscheme 'koda'

    local set = vim.api.nvim_set_hl

    --------------------------------------------------------------------------
    -- Palette
    --------------------------------------------------------------------------
    local white = '#ffffff'
    local w1 = '#f7f7f7'
    local w2 = '#efefef'
    local w3 = '#dddddd'
    local w4 = '#c8c8c8'

    local g1 = '#9a9a9a'
    local g2 = '#7a7a7a'

    local bg = '#0b0b0b'
    local bg2 = '#111111'
    local bg3 = '#141414'

    local sel = '#222222'

    local function apply()
      ------------------------------------------------------------------------
      -- UI
      ------------------------------------------------------------------------
      set(0, 'Normal', { fg = w2, bg = bg })
      set(0, 'NormalNC', { fg = w2, bg = bg })
      set(0, 'NormalFloat', { fg = w2, bg = bg })
      set(0, 'FloatBorder', { fg = w4, bg = bg })

      set(0, 'CursorLine', { bg = bg3 })
      set(0, 'CursorColumn', { bg = bg3 })
      set(0, 'ColorColumn', { bg = bg3 })

      set(0, 'Visual', { bg = sel })

      set(0, 'LineNr', { fg = g2 })
      set(0, 'CursorLineNr', { fg = white, bold = true })

      set(0, 'VertSplit', { fg = '#303030' })
      set(0, 'WinSeparator', { fg = '#303030' })

      set(0, 'StatusLine', { fg = white, bg = '#202020' })
      set(0, 'StatusLineNC', { fg = g1, bg = '#181818' })

      set(0, 'Title', { fg = white, bold = true })

      ------------------------------------------------------------------------
      -- Popup Menu
      ------------------------------------------------------------------------
      set(0, 'Pmenu', { fg = w2, bg = bg2 })
      set(0, 'PmenuSel', { fg = bg, bg = w3 })
      set(0, 'PmenuSbar', { bg = '#1d1d1d' })
      set(0, 'PmenuThumb', { bg = '#555555' })
      set(0, 'PmenuBorder', { fg = w4, bg = bg2 })

      ------------------------------------------------------------------------
      -- Search
      ------------------------------------------------------------------------
      set(0, 'Search', { fg = bg, bg = w3 })
      set(0, 'IncSearch', { fg = bg, bg = white })
      set(0, 'MatchParen', { fg = white, bold = true })

      ------------------------------------------------------------------------
      -- Syntax
      ------------------------------------------------------------------------
      set(0, 'Comment', { fg = g1, italic = true })

      set(0, 'Keyword', { fg = white, bold = true })
      set(0, '@keyword', { fg = white, bold = true })

      set(0, 'Type', { fg = w2 })
      set(0, '@type', { fg = w2 })
      set(0, '@type.builtin', { fg = w2 })
      set(0, '@type.definition', { fg = white, bold = true })

      set(0, 'Function', { fg = white, bold = true })
      set(0, '@function', { fg = white })
      set(0, '@function.call', { fg = white })
      set(0, '@method', { fg = white })

      set(0, 'Identifier', { fg = w2 })
      set(0, '@variable', { fg = w2 })
      set(0, '@parameter', { fg = w3 })
      set(0, '@field', { fg = w2 })
      set(0, '@property', { fg = w2 })

      set(0, 'Constant', { fg = w3 })
      set(0, '@constant', { fg = w3 })

      set(0, 'String', { fg = w3 })
      set(0, '@string', { fg = w3 })

      set(0, 'Number', { fg = w3 })
      set(0, '@number', { fg = w3 })

      set(0, 'Boolean', { fg = w3 })
      set(0, '@boolean', { fg = w3 })

      set(0, 'Operator', { fg = white })
      set(0, '@operator', { fg = white })

      set(0, '@punctuation', { fg = w3 })
      set(0, '@constructor', { fg = white })
      set(0, '@namespace', { fg = w3 })

      set(0, 'Directory', { fg = white })
      set(0, 'Delimiter', { fg = w3 })
      set(0, 'Special', { fg = w2 })

      ------------------------------------------------------------------------
      -- Diagnostics
      ------------------------------------------------------------------------
      set(0, 'DiagnosticError', { fg = w2 })
      set(0, 'DiagnosticWarn', { fg = w2 })
      set(0, 'DiagnosticInfo', { fg = w2 })
      set(0, 'DiagnosticHint', { fg = w2 })

      ------------------------------------------------------------------------
      -- Git
      ------------------------------------------------------------------------
      set(0, 'GitSignsAdd', { fg = w2 })
      set(0, 'GitSignsChange', { fg = w2 })
      set(0, 'GitSignsDelete', { fg = w2 })

      ------------------------------------------------------------------------
      -- Telescope
      ------------------------------------------------------------------------
      set(0, 'TelescopeNormal', { fg = w2, bg = bg })
      set(0, 'TelescopeBorder', { fg = w4, bg = bg })
      set(0, 'TelescopePromptBorder', { fg = w4, bg = bg })
      set(0, 'TelescopeResultsBorder', { fg = w4, bg = bg })
      set(0, 'TelescopePreviewBorder', { fg = w4, bg = bg })
      set(0, 'TelescopeSelection', { bg = sel })
      set(0, 'TelescopeTitle', { fg = white, bold = true })

      ------------------------------------------------------------------------
      -- Noice
      ------------------------------------------------------------------------
      set(0, 'NoiceCmdlinePopup', { fg = w2, bg = bg })
      set(0, 'NoiceCmdlinePopupBorder', { fg = w4, bg = bg })

      set(0, 'NoicePopup', { fg = w2, bg = bg })
      set(0, 'NoicePopupBorder', { fg = w4, bg = bg })

      set(0, 'NoiceMini', { fg = w2, bg = bg })

      set(0, 'NoiceFormatTitle', { fg = white, bold = true })
      set(0, 'NoiceFormatProgressDone', { fg = white })
      set(0, 'NoiceFormatProgressTodo', { fg = g1 })

      ------------------------------------------------------------------------
      -- Notify
      ------------------------------------------------------------------------
      set(0, 'NotifyBackground', { bg = bg })

      for _, lvl in ipairs { 'INFO', 'WARN', 'ERROR', 'DEBUG', 'TRACE' } do
        set(0, 'Notify' .. lvl .. 'Border', { fg = w4, bg = bg })
        set(0, 'Notify' .. lvl .. 'Title', { fg = white, bold = true })
        set(0, 'Notify' .. lvl .. 'Icon', { fg = white })
      end

      ------------------------------------------------------------------------
      -- Snacks
      ------------------------------------------------------------------------
      set(0, 'SnacksNotifierNormal', { fg = w2, bg = bg })
      set(0, 'SnacksNotifierBorder', { fg = w4, bg = bg })
      set(0, 'SnacksNotifierTitle', { fg = white, bold = true })
      set(0, 'SnacksNotifierIcon', { fg = white })

      ------------------------------------------------------------------------
      -- WhichKey
      ------------------------------------------------------------------------
      set(0, 'WhichKey', { fg = white })
      set(0, 'WhichKeyBorder', { fg = w4 })
      set(0, 'WhichKeyNormal', { fg = w2, bg = bg })
      set(0, 'WhichKeyTitle', { fg = white, bold = true })

      ------------------------------------------------------------------------
      -- Alpha
      ------------------------------------------------------------------------
      set(0, 'AlphaHeader', { fg = white })
      set(0, 'AlphaButtons', { fg = w2 })
      set(0, 'AlphaShortcut', { fg = w4 })
      set(0, 'AlphaFooter', { fg = g1 })

      ------------------------------------------------------------------------
      -- Neo-tree
      ------------------------------------------------------------------------
      set(0, 'NeoTreeNormal', { fg = w2, bg = bg })
      set(0, 'NeoTreeNormalNC', { fg = w2, bg = bg })
      set(0, 'NeoTreeDirectoryName', { fg = white })
      set(0, 'NeoTreeDirectoryIcon', { fg = w3 })
      set(0, 'NeoTreeRootName', { fg = white, bold = true })

      ------------------------------------------------------------------------
      -- Blink
      ------------------------------------------------------------------------
      set(0, 'BlinkCmpMenu', { fg = w2, bg = bg2 })
      set(0, 'BlinkCmpMenuBorder', { fg = w4, bg = bg2 })
      set(0, 'BlinkCmpLabel', { fg = w2 })
      set(0, 'BlinkCmpLabelMatch', { fg = white, bold = true })
      set(0, 'BlinkCmpDoc', { fg = w2, bg = bg })
      set(0, 'BlinkCmpDocBorder', { fg = w4, bg = bg })

      ------------------------------------------------------------------------
      -- Leetcode.nvim
      ------------------------------------------------------------------------
      for _, hl in ipairs(vim.fn.getcompletion('leetcode_', 'highlight')) do
        set(0, hl, { fg = white })
      end

      set(0, 'leetcode_easy', {
        fg = w2,
        bold = true,
      })

      set(0, 'leetcode_medium', {
        fg = w3,
        bold = true,
      })

      set(0, 'leetcode_hard', {
        fg = white,
        bold = true,
      })

      set(0, 'leetcode_easy_alt', {
        fg = g2,
      })

      set(0, 'leetcode_medium_alt', {
        fg = g2,
      })

      set(0, 'leetcode_hard_alt', {
        fg = g2,
      })

      set(0, 'leetcode_alt', {
        fg = g1,
      })
    end

    apply()

    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = apply,
    })

    -- Reapply after Leetcode loads its own highlights
    vim.defer_fn(apply, 100)
    --------------------------------------------------------------------------
    -- Disable semantic tokens
    --------------------------------------------------------------------------
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end,
    })
  end,
}
