return {
  'mason-org/mason.nvim',

  opts = {
    -- Automatically install these tools
    ensure_installed = {

      -- =========================
      -- LSP SERVERS
      -- =========================

      -- C / C++
      'clangd',

      -- Java
      'jdtls',

      -- Python
      'pyright',

      -- Lua
      'lua-language-server',

      -- HTML
      'html-lsp',

      -- CSS
      'css-lsp',

      -- JavaScript / TypeScript
      'typescript-language-server',

      -- JSON
      'json-lsp',

      -- Bash
      'bash-language-server',

      -- =========================
      -- FORMATTERS
      -- =========================

      -- C / C++
      'clang-format',

      -- Java
      'google-java-format',

      -- Python
      'black',

      -- Lua
      'stylua',

      -- HTML
      'prettier',

      -- CSS / JavaScript / TypeScript / JSON
      'prettier',

      -- =========================
      -- LINTERS
      -- =========================

      -- Python
      'ruff',

      -- JavaScript / TypeScript
      'eslint_d',
    },
  },
}
