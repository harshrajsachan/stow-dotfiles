return {
  'hrsh7th/nvim-cmp',

  event = 'InsertEnter',

  dependencies = {
    {
      'L3MON4D3/LuaSnip',

      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end

        return 'make install_jsregexp'
      end)(),

      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },

    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
  },

  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    luasnip.config.setup {}

    -- Load custom snippets
    dofile(vim.fn.stdpath 'config' .. '/lua/snippets/cpp.lua')

    local kind_icons = {
      Text = '󰉿',
      Method = 'm',
      Function = '󰊕',
      Constructor = '',
      Field = '',
      Variable = '󰆧',
      Class = '󰌗',
      Interface = '',
      Module = '',
      Property = '',
      Unit = '',
      Value = '󰎠',
      Enum = '',
      Keyword = '󰌋',
      Snippet = '',
      Color = '󰏘',
      File = '󰈙',
      Reference = '',
      Folder = '󰉋',
      EnumMember = '',
      Constant = '󰇽',
      Struct = '',
      Event = '',
      Operator = '󰆕',
      TypeParameter = '󰊄',
    }

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      completion = {
        completeopt = 'menu,menuone,noinsert',
      },

      preselect = cmp.PreselectMode.Item,

      mapping = {
        -- Next completion
        ['<C-n>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item {
              behavior = cmp.SelectBehavior.Insert,
            }
          else
            cmp.complete()
          end
        end, { 'i' }),

        -- Previous completion
        ['<C-p>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item {
              behavior = cmp.SelectBehavior.Insert,
            }
          else
            cmp.complete()
          end
        end, { 'i' }),

        -- Accept the selected completion
        ['<C-y>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm {
              select = false,
            }
          else
            fallback()
          end
        end, { 'i' }),

        -- Scroll documentation
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- Manually trigger completion
        ['<C-Space>'] = cmp.mapping.complete {},

        -- Enter = normal Enter
        ['<CR>'] = cmp.mapping(function(fallback)
          cmp.close()
          fallback()
        end, { 'i' }),

        -- Tab = LuaSnip expand / jump
        ['<Tab>'] = cmp.mapping(function(fallback)
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),

        -- Shift-Tab = LuaSnip jump backward
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },

      sources = {
        {
          name = 'luasnip',
          priority = 1000,
        },

        {
          name = 'lazydev',
          group_index = 0,
          priority = 100,
        },

        {
          name = 'nvim_lsp',
          priority = 500,
        },

        {
          name = 'buffer',
          priority = 250,
        },

        {
          name = 'path',
          priority = 200,
        },
      },

      formatting = {
        fields = {
          'kind',
          'abbr',
          'menu',
        },

        format = function(entry, vim_item)
          vim_item.kind = string.format('%s', kind_icons[vim_item.kind])

          vim_item.menu = ({
            nvim_lsp = '[LSP]',
            luasnip = '[Snippet]',
            buffer = '[Buffer]',
            path = '[Path]',
          })[entry.source.name]

          return vim_item
        end,
      },
    }
  end,
}
