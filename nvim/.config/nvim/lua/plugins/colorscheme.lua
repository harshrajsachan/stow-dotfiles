return {
  {
    "metalelf0/black-metal-theme-neovim",
    lazy = false,
    priority = 1000,

    config = function()
      -- ==================================================
      -- BASIC SETTINGS
      -- ==================================================
      vim.opt.termguicolors = true
      vim.opt.cursorline = false

      -- ==================================================
      -- LOAD THEME
      -- ==================================================
      require("black-metal").setup({
        theme = "venom",
      })

      require("black-metal").load()

      local hl = vim.api.nvim_set_hl

      local white = "#ffffff"
      local bright = "#f2f2f2"
      local soft = "#d0d0d0"
      local red = "#ff5555"
      local light_red = "#ff8080"

      -- ==================================================
      -- MAIN UI / TRANSPARENCY
      -- ==================================================
      hl(0, "Normal", {
        bg = "NONE",
        fg = white,
      })

      hl(0, "NormalNC", {
        bg = "NONE",
        fg = white,
      })

      hl(0, "EndOfBuffer", {
        bg = "NONE",
        fg = "#1a1a1a",
      })

      hl(0, "SignColumn", {
        bg = "NONE",
      })

      hl(0, "FoldColumn", {
        bg = "NONE",
      })

      hl(0, "CursorLine", {
        bg = "NONE",
      })

      hl(0, "CursorLineNr", {
        fg = red,
        bg = "NONE",
        bold = true,
      })

      hl(0, "LineNr", {
        fg = "#c0c0c0",
        bg = "NONE",
      })

      -- ==================================================
      -- BASIC SYNTAX
      -- ==================================================
      hl(0, "Comment", {
        fg = soft,
        italic = true,
      })

      hl(0, "Keyword", {
        fg = red,
        bold = true,
      })

      hl(0, "Statement", {
        fg = red,
        bold = true,
      })

      hl(0, "Conditional", {
        fg = red,
        bold = true,
      })

      hl(0, "Repeat", {
        fg = red,
        bold = true,
      })

      hl(0, "Function", {
        fg = white,
        bold = true,
      })

      hl(0, "Identifier", {
        fg = white,
      })

      hl(0, "Type", {
        fg = light_red,
      })

      hl(0, "Structure", {
        fg = light_red,
      })

      hl(0, "String", {
        fg = bright,
      })

      hl(0, "Character", {
        fg = bright,
      })

      hl(0, "Constant", {
        fg = light_red,
      })

      hl(0, "Number", {
        fg = "#ff6b6b",
      })

      hl(0, "Boolean", {
        fg = "#ff6b6b",
      })

      hl(0, "Operator", {
        fg = bright,
      })

      hl(0, "Delimiter", {
        fg = bright,
      })

      hl(0, "Special", {
        fg = bright,
      })

      -- ==================================================
      -- TREESITTER
      -- ==================================================
      hl(0, "@variable", {
        fg = white,
      })

      hl(0, "@variable.builtin", {
        fg = white,
      })

      hl(0, "@property", {
        fg = white,
      })

      hl(0, "@field", {
        fg = white,
      })

      hl(0, "@parameter", {
        fg = white,
      })

      hl(0, "@keyword", {
        fg = red,
        bold = true,
      })

      hl(0, "@keyword.function", {
        fg = red,
        bold = true,
      })

      hl(0, "@function", {
        fg = white,
        bold = true,
      })

      hl(0, "@function.call", {
        fg = white,
      })

      hl(0, "@type", {
        fg = light_red,
      })

      hl(0, "@type.builtin", {
        fg = light_red,
      })

      hl(0, "@string", {
        fg = bright,
      })

      hl(0, "@number", {
        fg = "#ff6b6b",
      })

      hl(0, "@constant", {
        fg = light_red,
      })

      hl(0, "@comment", {
        fg = soft,
        italic = true,
      })

      hl(0, "@text", {
        fg = bright,
      })

      hl(0, "@text.literal", {
        fg = bright,
      })

      hl(0, "@markup", {
        fg = bright,
      })

      hl(0, "@markup.raw", {
        fg = bright,
      })

      hl(0, "@punctuation", {
        fg = bright,
      })

      hl(0, "@punctuation.delimiter", {
        fg = bright,
      })

      hl(0, "@constructor", {
        fg = bright,
      })

      hl(0, "@module", {
        fg = bright,
      })

      hl(0, "@label", {
        fg = bright,
      })

      -- ==================================================
      -- FLOATING WINDOWS
      -- ==================================================
      hl(0, "NormalFloat", {
        fg = white,
        bg = "NONE",
      })

      hl(0, "FloatBorder", {
        fg = "#666666",
        bg = "NONE",
      })

      hl(0, "FloatTitle", {
        fg = white,
        bold = true,
      })

      hl(0, "Pmenu", {
        fg = white,
        bg = "NONE",
      })

      hl(0, "PmenuSel", {
        fg = "#000000",
        bg = red,
      })

      -- ==================================================
      -- NEOTREE
      -- ==================================================
      hl(0, "NeoTreeNormal", {
        fg = bright,
        bg = "NONE",
      })

      hl(0, "NeoTreeNormalNC", {
        fg = bright,
        bg = "NONE",
      })

      hl(0, "NeoTreeDirectoryName", {
        fg = white,
        bold = true,
      })

      hl(0, "NeoTreeFileName", {
        fg = bright,
      })

      hl(0, "NeoTreeFileNameOpened", {
        fg = white,
      })

      hl(0, "NeoTreeRootName", {
        fg = red,
        bold = true,
      })

      hl(0, "NeoTreeIndentMarker", {
        fg = "#aaaaaa",
      })

      hl(0, "NeoTreeExpander", {
        fg = white,
      })

      hl(0, "NeoTreeDimText", {
        fg = bright,
      })

      hl(0, "NeoTreeMessage", {
        fg = white,
      })

      -- ==================================================
      -- ALPHA DASHBOARD
      -- ==================================================
      hl(0, "AlphaHeader", {
        fg = white,
        bold = true,
      })

      hl(0, "AlphaButtons", {
        fg = bright,
      })

      hl(0, "AlphaShortcut", {
        fg = red,
        bold = true,
      })

      hl(0, "AlphaFooter", {
        fg = white,
      })

      -- ==================================================
      -- STATUSLINE / SPLITS
      -- ==================================================
      hl(0, "StatusLine", {
        fg = white,
        bg = "NONE",
      })

      hl(0, "StatusLineNC", {
        fg = "#999999",
        bg = "NONE",
      })

      hl(0, "VertSplit", {
        fg = "#444444",
        bg = "NONE",
      })

      hl(0, "WinSeparator", {
        fg = "#444444",
        bg = "NONE",
      })

      hl(0, "Visual", {
        bg = "#2a2a2a",
      })

      -- ==================================================
      -- BUFFERLINE / TABS
      -- ==================================================
      hl(0, "TabLine", {
        fg = "#cccccc",
        bg = "NONE",
      })

      hl(0, "TabLineSel", {
        fg = white,
        bg = "NONE",
        bold = true,
      })

      hl(0, "TabLineFill", {
        bg = "NONE",
      })

      hl(0, "BufferLineFill", {
        bg = "NONE",
      })

      hl(0, "BufferLineBackground", {
        fg = "#cccccc",
        bg = "NONE",
      })

      hl(0, "BufferLineBufferSelected", {
        fg = white,
        bold = true,
      })

      -- ==================================================
      -- MISC UI
      -- ==================================================
      hl(0, "Title", {
        fg = white,
        bold = true,
      })

      hl(0, "Directory", {
        fg = white,
        bold = true,
      })

      hl(0, "NonText", {
        fg = "#888888",
      })

      hl(0, "Whitespace", {
        fg = "#888888",
      })

      hl(0, "SpecialKey", {
        fg = "#aaaaaa",
      })

      hl(0, "Conceal", {
        fg = bright,
      })

      -- ==================================================
      -- DIAGNOSTICS
      -- ==================================================
      hl(0, "DiagnosticHint", {
        fg = white,
      })

      hl(0, "DiagnosticInfo", {
        fg = white,
      })

      hl(0, "DiagnosticVirtualTextHint", {
        fg = white,
      })

      hl(0, "DiagnosticVirtualTextInfo", {
        fg = white,
      })

      -- ==================================================
      -- DEVICONS
      -- ==================================================
      hl(0, "DevIconDefault", {
        fg = white,
      })
    end,
  },
}
