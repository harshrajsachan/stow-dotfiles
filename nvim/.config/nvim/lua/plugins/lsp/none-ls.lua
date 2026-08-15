return {
  'nvimtools/none-ls.nvim',

  dependencies = {
    'nvimtools/none-ls-extras.nvim',
  },

  config = function()
    local null_ls = require 'null-ls'

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    local sources = {
      -- Lua
      formatting.stylua,

      -- Web / config / markdown
      formatting.prettier.with {
        filetypes = {
          'html',
          'json',
          'yaml',
          'markdown',
        },
      },

      -- Shell
      formatting.shfmt.with {
        args = { '-i', '4' },
      },

      -- Terraform
      formatting.terraform_fmt,

      -- Makefile
      diagnostics.checkmake,

      -- Python
      require('none-ls.formatting.ruff').with {
        extra_args = { '--extend-select', 'I' },
      },

      require 'none-ls.formatting.ruff_format',
    }

    local augroup = vim.api.nvim_create_augroup('LspFormatting', { clear = true })

    null_ls.setup {
      sources = sources,

      on_attach = function(client, bufnr)
        if client:supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds {
            group = augroup,
            buffer = bufnr,
          }

          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,

            callback = function()
              vim.lsp.buf.format {
                bufnr = bufnr,
                async = false,
                filter = function(format_client)
                  return format_client.name == 'null-ls' or format_client.name == 'none-ls'
                end,
              }
            end,
          })
        end
      end,
    }
  end,
}
