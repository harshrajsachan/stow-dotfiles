return {
  'neovim/nvim-lspconfig',

  dependencies = {
    -- Mason
    {
      'mason-org/mason.nvim',
      config = true,
    },

    -- Mason ↔ LSP name mapping
    'mason-org/mason-lspconfig.nvim',

    -- LSP progress notifications
    {
      'j-hui/fidget.nvim',
      opts = {
        notification = {
          window = {
            winblend = 0,
          },
        },
      },
    },

    -- nvim-cmp LSP capabilities
    'hrsh7th/cmp-nvim-lsp',
  },

  config = function()
    -----------------------------------------------------------
    -- LSP ATTACH
    -----------------------------------------------------------

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', {
        clear = true,
      }),

      callback = function(event)
        -------------------------------------------------------
        -- Helper for buffer-local LSP mappings
        -------------------------------------------------------

        local map = function(keys, func, desc, mode)
          mode = mode or 'n'

          vim.keymap.set(mode, keys, func, {
            buffer = event.buf,
            desc = 'LSP: ' .. desc,
          })
        end

        -------------------------------------------------------
        -- Navigation
        -------------------------------------------------------

        map('gd', Snacks.picker.lsp_definitions, '[G]oto [D]efinition')

        map('gr', Snacks.picker.lsp_references, '[G]oto [R]eferences')

        map('gI', Snacks.picker.lsp_implementations, '[G]oto [I]mplementation')

        map('<leader>D', Snacks.picker.lsp_type_definitions, 'Type [D]efinition')

        -------------------------------------------------------
        -- Symbols
        -------------------------------------------------------

        map('<leader>ds', Snacks.picker.lsp_symbols, '[D]ocument [S]ymbols')

        map('<leader>ws', Snacks.picker.lsp_workspace_symbols, '[W]orkspace [S]ymbols')

        -------------------------------------------------------
        -- Rename
        -------------------------------------------------------

        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -------------------------------------------------------
        -- Code actions
        -------------------------------------------------------

        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

        -------------------------------------------------------
        -- Declaration
        -------------------------------------------------------

        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -------------------------------------------------------
        -- Current LSP client
        -------------------------------------------------------

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -------------------------------------------------------
        -- Document highlight
        -------------------------------------------------------

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', {
            clear = false,
          })

          vim.api.nvim_create_autocmd({
            'CursorHold',
            'CursorHoldI',
          }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({
            'CursorMoved',
            'CursorMovedI',
          }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', {
              clear = true,
            }),

            callback = function(event2)
              vim.lsp.buf.clear_references()

              vim.api.nvim_clear_autocmds {
                group = 'kickstart-lsp-highlight',
                buffer = event2.buf,
              }
            end,
          })
        end

        -------------------------------------------------------
        -- Inlay hints
        -------------------------------------------------------

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {
              bufnr = event.buf,
            })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -----------------------------------------------------------
    -- CMP CAPABILITIES
    -----------------------------------------------------------

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -----------------------------------------------------------
    -- LANGUAGE SERVERS
    --
    -- These are Neovim LSP names, NOT Mason package names.
    --
    -- Mason:
    --   clangd                     -> clangd
    --   pyright                    -> pyright
    --   bash-language-server       -> bashls
    --   lua-language-server        -> lua_ls
    --   typescript-language-server -> ts_ls
    --   html-lsp                   -> html
    --   css-lsp                    -> cssls
    --   json-lsp                   -> jsonls
    --
    -- JDTLS is intentionally handled separately.
    -----------------------------------------------------------

    local servers = {

      ---------------------------------------------------------
      -- C / C++
      ---------------------------------------------------------

      clangd = {},

      ---------------------------------------------------------
      -- Python
      ---------------------------------------------------------

      pyright = {},

      ---------------------------------------------------------
      -- Bash / Shell
      ---------------------------------------------------------

      bashls = {},

      ---------------------------------------------------------
      -- JavaScript / TypeScript
      ---------------------------------------------------------

      ts_ls = {},

      ---------------------------------------------------------
      -- HTML
      ---------------------------------------------------------

      html = {
        filetypes = {
          'html',
          'twig',
          'hbs',
        },
      },

      ---------------------------------------------------------
      -- CSS
      ---------------------------------------------------------

      cssls = {},

      ---------------------------------------------------------
      -- Tailwind
      ---------------------------------------------------------

      tailwindcss = {},

      ---------------------------------------------------------
      -- Docker
      ---------------------------------------------------------

      dockerls = {},

      ---------------------------------------------------------
      -- SQL
      ---------------------------------------------------------

      sqlls = {},

      ---------------------------------------------------------
      -- Terraform
      ---------------------------------------------------------

      terraformls = {},

      ---------------------------------------------------------
      -- JSON
      ---------------------------------------------------------

      jsonls = {},

      ---------------------------------------------------------
      -- YAML
      ---------------------------------------------------------

      yamlls = {},

      ---------------------------------------------------------
      -- Lua
      ---------------------------------------------------------

      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },

            runtime = {
              version = 'LuaJIT',
            },

            workspace = {
              checkThirdParty = false,

              library = vim.api.nvim_get_runtime_file('', true),
            },

            diagnostics = {
              globals = {
                'vim',
              },

              disable = {
                'missing-fields',
              },
            },

            format = {
              enable = false,
            },
          },
        },
      },
    }

    -----------------------------------------------------------
    -- CONFIGURE + ENABLE LSP SERVERS
    -----------------------------------------------------------

    for server, cfg in pairs(servers) do
      cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, cfg.capabilities or {})

      vim.lsp.config(server, cfg)
      vim.lsp.enable(server)
    end
  end,
}
