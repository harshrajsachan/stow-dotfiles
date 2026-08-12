vim.cmd("highlight clear")
vim.cmd("syntax reset")

vim.g.colors_name = "blackwhite"

local set = vim.api.nvim_set_hl

-- ============================================================================
-- PALETTE
-- Change ONLY this section to create another theme
-- ============================================================================

local palette = {

	-- Backgrounds
	bg = "#000000",
	bg1 = "#0a0a0a",
	bg2 = "#111111",
	bg3 = "#181818",
	bg4 = "#222222",

	-- Foreground
	fg = "#efefef",
	fg1 = "#f7f7f7",
	fg2 = "#ffffff",
	muted = "#9a9a9a",
	dim = "#7a7a7a",
	faint = "#555555",

	-- Borders / UI
	border = "#303030",
	border2 = "#404040",
	cursor = "#ffffff",

	-- Accent
	accent = "#ffffff",
	accent1 = "#dddddd",
	accent2 = "#aaaaaa",

	-- Syntax
	keyword = "#ffffff",
	type = "#efefef",
	func = "#ffffff",
	variable = "#efefef",
	parameter = "#dddddd",
	constant = "#dddddd",
	string = "#dddddd",
	number = "#dddddd",
	boolean = "#dddddd",
	operator = "#ffffff",
	punctuation = "#aaaaaa",
	special = "#efefef",

	-- Diagnostics
	error = "#ffffff",
	warning = "#dddddd",
	info = "#aaaaaa",
	hint = "#777777",

	-- Git
	git_add = "#dddddd",
	git_change = "#aaaaaa",
	git_delete = "#777777",
}

-- ============================================================================
-- UI
-- ============================================================================

set(0, "Normal", {
	fg = palette.fg,
	bg = palette.bg,
})

set(0, "NormalNC", {
	fg = palette.fg,
	bg = palette.bg,
})

set(0, "NormalFloat", {
	fg = palette.fg,
	bg = palette.bg,
})

set(0, "FloatBorder", {
	fg = palette.border2,
	bg = palette.bg,
})

set(0, "FloatTitle", {
	fg = palette.accent,
	bg = palette.bg,
	bold = true,
})

set(0, "Cursor", {
	fg = palette.bg,
	bg = palette.cursor,
})

set(0, "CursorLine", {
	bg = palette.bg3,
})

set(0, "CursorColumn", {
	bg = palette.bg3,
})

set(0, "ColorColumn", {
	bg = palette.bg3,
})

set(0, "Visual", {
	bg = palette.bg4,
})

set(0, "VisualNOS", {
	bg = palette.bg4,
})

set(0, "LineNr", {
	fg = palette.dim,
})

set(0, "CursorLineNr", {
	fg = palette.cursor,
	bold = true,
})

set(0, "SignColumn", {
	fg = palette.dim,
	bg = palette.bg,
})

set(0, "FoldColumn", {
	fg = palette.dim,
	bg = palette.bg,
})

set(0, "Folded", {
	fg = palette.muted,
	bg = palette.bg2,
})

set(0, "VertSplit", {
	fg = palette.border,
})

set(0, "WinSeparator", {
	fg = palette.border,
})

set(0, "StatusLine", {
	fg = palette.fg2,
	bg = palette.bg3,
})

set(0, "StatusLineNC", {
	fg = palette.muted,
	bg = palette.bg2,
})

set(0, "TabLine", {
	fg = palette.muted,
	bg = palette.bg2,
})

set(0, "TabLineFill", {
	bg = palette.bg,
})

set(0, "TabLineSel", {
	fg = palette.fg2,
	bg = palette.bg3,
	bold = true,
})

set(0, "Title", {
	fg = palette.accent,
	bold = true,
})

set(0, "Directory", {
	fg = palette.accent,
})

set(0, "NonText", {
	fg = palette.faint,
})

set(0, "SpecialKey", {
	fg = palette.faint,
})

set(0, "Whitespace", {
	fg = palette.faint,
})

set(0, "EndOfBuffer", {
	fg = palette.bg3,
})

set(0, "MatchParen", {
	fg = palette.accent,
	bg = palette.bg4,
	bold = true,
})

-- ============================================================================
-- Popup Menu
-- ============================================================================

set(0, "Pmenu", {
	fg = palette.fg,
	bg = palette.bg2,
})

set(0, "PmenuSel", {
	fg = palette.bg,
	bg = palette.accent1,
	bold = true,
})

set(0, "PmenuSbar", {
	bg = palette.bg3,
})

set(0, "PmenuThumb", {
	bg = palette.faint,
})

set(0, "PmenuBorder", {
	fg = palette.border2,
	bg = palette.bg2,
})

-- ============================================================================
-- Search
-- ============================================================================

set(0, "Search", {
	fg = palette.bg,
	bg = palette.accent1,
})

set(0, "IncSearch", {
	fg = palette.bg,
	bg = palette.accent,
	bold = true,
})

set(0, "CurSearch", {
	fg = palette.bg,
	bg = palette.accent,
	bold = true,
})

-- ============================================================================
-- Syntax
-- ============================================================================

set(0, "Comment", {
	fg = palette.muted,
	italic = true,
})

set(0, "Keyword", {
	fg = palette.keyword,
	bold = true,
})

set(0, "Statement", {
	fg = palette.keyword,
	bold = true,
})

set(0, "Conditional", {
	fg = palette.keyword,
	bold = true,
})

set(0, "Repeat", {
	fg = palette.keyword,
	bold = true,
})

set(0, "Label", {
	fg = palette.keyword,
})

set(0, "Exception", {
	fg = palette.keyword,
	bold = true,
})

set(0, "Type", {
	fg = palette.type,
})

set(0, "StorageClass", {
	fg = palette.type,
})

set(0, "Structure", {
	fg = palette.type,
})

set(0, "Typedef", {
	fg = palette.type,
	bold = true,
})

set(0, "Function", {
	fg = palette.func,
	bold = true,
})

set(0, "Identifier", {
	fg = palette.variable,
})

set(0, "Constant", {
	fg = palette.constant,
})

set(0, "String", {
	fg = palette.string,
})

set(0, "Character", {
	fg = palette.string,
})

set(0, "Number", {
	fg = palette.number,
})

set(0, "Float", {
	fg = palette.number,
})

set(0, "Boolean", {
	fg = palette.boolean,
})

set(0, "Operator", {
	fg = palette.operator,
})

set(0, "Delimiter", {
	fg = palette.punctuation,
})

set(0, "Special", {
	fg = palette.special,
})

set(0, "PreProc", {
	fg = palette.special,
})

set(0, "Include", {
	fg = palette.keyword,
	bold = true,
})

-- ============================================================================
-- Tree-sitter
-- ============================================================================

set(0, "@comment", {
	fg = palette.muted,
	italic = true,
})

set(0, "@keyword", {
	fg = palette.keyword,
	bold = true,
})

set(0, "@keyword.function", {
	fg = palette.keyword,
	bold = true,
})

set(0, "@keyword.return", {
	fg = palette.keyword,
	bold = true,
})

set(0, "@keyword.operator", {
	fg = palette.operator,
	bold = true,
})

set(0, "@type", {
	fg = palette.type,
})

set(0, "@type.builtin", {
	fg = palette.type,
})

set(0, "@type.definition", {
	fg = palette.type,
	bold = true,
})

set(0, "@function", {
	fg = palette.func,
	bold = true,
})

set(0, "@function.call", {
	fg = palette.func,
})

set(0, "@function.method", {
	fg = palette.func,
	bold = true,
})

set(0, "@function.method.call", {
	fg = palette.func,
})

set(0, "@method", {
	fg = palette.func,
})

set(0, "@method.call", {
	fg = palette.func,
})

set(0, "@constructor", {
	fg = palette.func,
})

set(0, "@variable", {
	fg = palette.variable,
})

set(0, "@variable.builtin", {
	fg = palette.accent,
})

set(0, "@parameter", {
	fg = palette.parameter,
})

set(0, "@field", {
	fg = palette.variable,
})

set(0, "@property", {
	fg = palette.variable,
})

set(0, "@constant", {
	fg = palette.constant,
})

set(0, "@constant.builtin", {
	fg = palette.constant,
})

set(0, "@string", {
	fg = palette.string,
})

set(0, "@string.escape", {
	fg = palette.accent,
})

set(0, "@string.special", {
	fg = palette.accent1,
})

set(0, "@number", {
	fg = palette.number,
})

set(0, "@float", {
	fg = palette.number,
})

set(0, "@boolean", {
	fg = palette.boolean,
})

set(0, "@operator", {
	fg = palette.operator,
})

set(0, "@punctuation", {
	fg = palette.punctuation,
})

set(0, "@punctuation.bracket", {
	fg = palette.punctuation,
})

set(0, "@punctuation.delimiter", {
	fg = palette.punctuation,
})

set(0, "@namespace", {
	fg = palette.punctuation,
})

set(0, "@tag", {
	fg = palette.keyword,
})

set(0, "@tag.attribute", {
	fg = palette.variable,
})

set(0, "@tag.delimiter", {
	fg = palette.punctuation,
})

-- ============================================================================
-- Diagnostics
-- ============================================================================

set(0, "DiagnosticError", {
	fg = palette.error,
})

set(0, "DiagnosticWarn", {
	fg = palette.warning,
})

set(0, "DiagnosticInfo", {
	fg = palette.info,
})

set(0, "DiagnosticHint", {
	fg = palette.hint,
})

set(0, "DiagnosticVirtualTextError", {
	fg = palette.error,
})

set(0, "DiagnosticVirtualTextWarn", {
	fg = palette.warning,
})

set(0, "DiagnosticVirtualTextInfo", {
	fg = palette.info,
})

set(0, "DiagnosticVirtualTextHint", {
	fg = palette.hint,
})

set(0, "DiagnosticUnderlineError", {
	undercurl = true,
})

set(0, "DiagnosticUnderlineWarn", {
	undercurl = true,
})

set(0, "DiagnosticUnderlineInfo", {
	undercurl = true,
})

set(0, "DiagnosticUnderlineHint", {
	undercurl = true,
})

-- ============================================================================
-- GitSigns
-- ============================================================================

set(0, "GitSignsAdd", {
	fg = palette.git_add,
})

set(0, "GitSignsChange", {
	fg = palette.git_change,
})

set(0, "GitSignsDelete", {
	fg = palette.git_delete,
})

-- ============================================================================
-- Telescope
-- ============================================================================

set(0, "TelescopeNormal", {
	fg = palette.fg,
	bg = palette.bg,
})

set(0, "TelescopeBorder", {
	fg = palette.border2,
	bg = palette.bg,
})

set(0, "TelescopePromptNormal", {
	fg = palette.fg,
	bg = palette.bg,
})

set(0, "TelescopePromptBorder", {
	fg = palette.border2,
	bg = palette.bg,
})

set(0, "TelescopeResultsNormal", {
	fg = palette.fg,
	bg = palette.bg,
})

set(0, "TelescopeResultsBorder", {
	fg = palette.border2,
	bg = palette.bg,
})

set(0, "TelescopePreviewNormal", {
	fg = palette.fg,
	bg = palette.bg,
})

set(0, "TelescopePreviewBorder", {
	fg = palette.border2,
	bg = palette.bg,
})

set(0, "TelescopeSelection", {
	fg = palette.fg1,
	bg = palette.bg4,
})

set(0, "TelescopeMatching", {
	fg = palette.accent,
	bold = true,
})

set(0, "TelescopeTitle", {
	fg = palette.accent,
	bold = true,
})

set(0, "TelescopePromptTitle", {
	fg = palette.accent,
	bold = true,
})

set(0, "TelescopeResultsTitle", {
	fg = palette.accent,
	bold = true,
})

set(0, "TelescopePreviewTitle", {
	fg = palette.accent,
	bold = true,
})

-- ============================================================================
-- Noice
-- ============================================================================

set(0, "NoiceCmdlinePopup", {
	fg = palette.fg,
	bg = palette.bg,
})

set(0, "NoiceCmdlinePopupBorder", {
	fg = palette.border2,
	bg = palette.bg,
})

set(0, "NoicePopup", {
	fg = palette.fg,
	bg = palette.bg,
})

set(0, "NoicePopupBorder", {
	fg = palette.border2,
	bg = palette.bg,
})

set(0, "NoiceMini", {
	fg = palette.fg,
	bg = palette.bg,
})

set(0, "NoiceFormatTitle", {
	fg = palette.accent,
	bold = true,
})

set(0, "NoiceFormatProgressDone", {
	fg = palette.accent,
})

set(0, "NoiceFormatProgressTodo", {
	fg = palette.muted,
})

-- ============================================================================
-- Notify
-- ============================================================================

set(0, "NotifyBackground", {
	bg = palette.bg,
})

for _, level in ipairs({
	"INFO",
	"WARN",
	"ERROR",
	"DEBUG",
	"TRACE",
}) do
	set(0, "Notify" .. level .. "Border", {
		fg = palette.border2,
		bg = palette.bg,
	})

	set(0, "Notify" .. level .. "Title", {
		fg = palette.accent,
		bold = true,
	})

	set(0, "Notify" .. level .. "Icon", {
		fg = palette.accent,
	})
end

-- ============================================================================
-- Snacks
-- ============================================================================

set(0, "SnacksNotifierNormal", {
	fg = palette.fg,
	bg = palette.bg,
})

set(0, "SnacksNotifierBorder", {
	fg = palette.border2,
	bg = palette.bg,
})

set(0, "SnacksNotifierTitle", {
	fg = palette.accent,
	bold = true,
})

set(0, "SnacksNotifierIcon", {
	fg = palette.accent,
})

-- ============================================================================
-- WhichKey
-- ============================================================================

set(0, "WhichKey", {
	fg = palette.accent,
})

set(0, "WhichKeyBorder", {
	fg = palette.border2,
})

set(0, "WhichKeyNormal", {
	fg = palette.fg,
	bg = palette.bg,
})

set(0, "WhichKeyTitle", {
	fg = palette.accent,
	bold = true,
})

set(0, "WhichKeyDesc", {
	fg = palette.fg,
})

set(0, "WhichKeyGroup", {
	fg = palette.accent1,
})

set(0, "WhichKeySeparator", {
	fg = palette.faint,
})

-- ============================================================================
-- Alpha
-- ============================================================================

set(0, "AlphaHeader", {
	fg = palette.accent,
})

set(0, "AlphaButtons", {
	fg = palette.fg,
})

set(0, "AlphaShortcut", {
	fg = palette.accent1,
})

set(0, "AlphaFooter", {
	fg = palette.muted,
})

-- ============================================================================
-- Neo-tree
-- ============================================================================

set(0, "NeoTreeNormal", {
	fg = palette.fg,
	bg = palette.bg,
})

set(0, "NeoTreeNormalNC", {
	fg = palette.fg,
	bg = palette.bg,
})

set(0, "NeoTreeDirectoryName", {
	fg = palette.accent,
})

set(0, "NeoTreeDirectoryIcon", {
	fg = palette.punctuation,
})

set(0, "NeoTreeRootName", {
	fg = palette.accent,
	bold = true,
})

set(0, "NeoTreeFileName", {
	fg = palette.fg,
})

set(0, "NeoTreeFileNameOpened", {
	fg = palette.accent,
	bold = true,
})

set(0, "NeoTreeGitAdded", {
	fg = palette.git_add,
})

set(0, "NeoTreeGitModified", {
	fg = palette.git_change,
})

set(0, "NeoTreeGitDeleted", {
	fg = palette.git_delete,
})

set(0, "NeoTreeIndentMarker", {
	fg = palette.faint,
})

set(0, "NeoTreeExpander", {
	fg = palette.muted,
})

-- ============================================================================
-- Blink CMP
-- ============================================================================

set(0, "BlinkCmpMenu", {
	fg = palette.fg,
	bg = palette.bg2,
})

set(0, "BlinkCmpMenuBorder", {
	fg = palette.border2,
	bg = palette.bg2,
})

set(0, "BlinkCmpLabel", {
	fg = palette.fg,
})

set(0, "BlinkCmpLabelMatch", {
	fg = palette.accent,
	bold = true,
})

set(0, "BlinkCmpKind", {
	fg = palette.muted,
})

set(0, "BlinkCmpSource", {
	fg = palette.muted,
})

set(0, "BlinkCmpDoc", {
	fg = palette.fg,
	bg = palette.bg,
})

set(0, "BlinkCmpDocBorder", {
	fg = palette.border2,
	bg = palette.bg,
})

set(0, "BlinkCmpSignatureHelp", {
	fg = palette.fg,
	bg = palette.bg,
})

set(0, "BlinkCmpSignatureHelpBorder", {
	fg = palette.border2,
	bg = palette.bg,
})

-- ============================================================================
-- LeetCode.nvim
-- ============================================================================

for _, hl in ipairs(vim.fn.getcompletion("leetcode_", "highlight")) do
	set(0, hl, {
		fg = palette.accent,
	})
end

set(0, "leetcode_easy", {
	fg = palette.fg,
	bold = true,
})

set(0, "leetcode_medium", {
	fg = palette.accent1,
	bold = true,
})

set(0, "leetcode_hard", {
	fg = palette.accent,
	bold = true,
})

set(0, "leetcode_easy_alt", {
	fg = palette.dim,
})

set(0, "leetcode_medium_alt", {
	fg = palette.dim,
})

set(0, "leetcode_hard_alt", {
	fg = palette.dim,
})

set(0, "leetcode_alt", {
	fg = palette.muted,
})

-- ============================================================================
-- LSP References
-- ============================================================================

set(0, "LspReferenceText", {
	bg = palette.bg4,
})

set(0, "LspReferenceRead", {
	bg = palette.bg4,
})

set(0, "LspReferenceWrite", {
	bg = palette.bg4,
})

-- ============================================================================
-- Diff
-- ============================================================================

set(0, "DiffAdd", {
	fg = palette.git_add,
	bg = palette.bg1,
})

set(0, "DiffChange", {
	fg = palette.git_change,
	bg = palette.bg1,
})

set(0, "DiffDelete", {
	fg = palette.git_delete,
	bg = palette.bg1,
})

set(0, "DiffText", {
	fg = palette.fg2,
	bg = palette.bg4,
	bold = true,
})
