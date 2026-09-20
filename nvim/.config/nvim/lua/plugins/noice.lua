return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',

    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },

    opts = {
      cmdline = {
        enabled = true,
        view = 'cmdline',
      },

      views = {
        cmdline = {
          position = {
            row = '100%',
            col = 0,
          },

          size = {
            width = '100%',
            height = 1,
          },

          border = {
            style = 'none',
            padding = { 0, 0 },
          },

          win_options = {
            winblend = 0,
            winhighlight = 'Normal:Normal',
          },
        },
      },

      lsp = {
        progress = {
          enabled = true,
        },

        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },

      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
  },
}
