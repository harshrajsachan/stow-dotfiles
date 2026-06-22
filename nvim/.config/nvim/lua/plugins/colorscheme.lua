return {
  "oskarnurm/koda.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme koda")

    local set = vim.api.nvim_set_hl

    -- Keywords: if, for, while, return, class
    set(0, "Keyword", { fg = "#c0c0c0", bold = true })
    set(0, "@keyword", { fg = "#c0c0c0", bold = true })

    -- Types: int, bool, vector, string
    set(0, "Type", { fg = "#7aa2f7" })
    set(0, "@type", { fg = "#7aa2f7" })

    -- Functions
    set(0, "Function", { fg = "#ffd580" })
    set(0, "@function", { fg = "#ffd580" })

    -- Comments
    set(0, "Comment", { fg = "#8a9199", italic = true })

    -- Strings
    set(0, "String", { fg = "#98c379" })

    -- Operators
    set(0, "Operator", { fg = "#89ddff" })

    -- Constants
    set(0, "Constant", { fg = "#d9ba73" })

    -- Numbers
    set(0, "Number", { fg = "#d9ba73" })

    -- Booleans
    set(0, "Boolean", { fg = "#d9ba73" })
  end,
}
