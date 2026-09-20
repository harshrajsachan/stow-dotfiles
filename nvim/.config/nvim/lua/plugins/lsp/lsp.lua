return {
  'neovim/nvim-lspconfig',

  dependencies = {
    {
      'mason-org/mason.nvim',
      config = true,
    },

    'mason-org/mason-lspconfig.nvim',

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

        map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
        map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        map('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

        -------------------------------------------------------
        -- Symbols
        -------------------------------------------------------

        map('<leader>ds', vim.lsp.buf.document_symbol, '[D]ocument [S]ymbols')
        map('<leader>ws', vim.lsp.buf.workspace_symbol, '[W]orkspace [S]ymbols')

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
    -- CONFIGURE LSP SERVERS
    --
    -- Servers are configured but NOT enabled automatically.
    -----------------------------------------------------------

    for server, cfg in pairs(servers) do
      cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, cfg.capabilities or {})

      vim.lsp.config(server, cfg)
    end

    -----------------------------------------------------------
    -- FILETYPE → LSP
    -----------------------------------------------------------

    local filetype_servers = {
      -- C / C++
      c = 'clangd',
      cpp = 'clangd',
      objc = 'clangd',
      objcpp = 'clangd',

      -- Python
      python = 'pyright',

      -- Bash / Shell
      sh = 'bashls',
      bash = 'bashls',

      -- JavaScript / TypeScript
      javascript = 'ts_ls',
      javascriptreact = 'ts_ls',
      typescript = 'ts_ls',
      typescriptreact = 'ts_ls',

      -- HTML
      html = 'html',

      -- CSS
      css = 'cssls',
      scss = 'cssls',

      -- Tailwind
      astro = 'tailwindcss',
      svelte = 'tailwindcss',

      -- Docker
      dockerfile = 'dockerls',

      -- SQL
      sql = 'sqlls',

      -- Terraform
      terraform = 'terraformls',

      -- JSON
      json = 'jsonls',

      -- YAML
      yaml = 'yamlls',

      -- Lua
      lua = 'lua_ls',
    }

    -----------------------------------------------------------
    -- MANUAL LSP START
    --
    -- <leader>ls
    -----------------------------------------------------------

    vim.keymap.set('n', '<leader>ls', function()
      local filetype = vim.bo.filetype
      local server = filetype_servers[filetype]

      if not server then
        vim.notify('No LSP configured for: ' .. filetype, vim.log.levels.WARN)
        return
      end

      vim.lsp.enable(server)

      vim.notify(server .. ' enabled', vim.log.levels.INFO)
    end, {
      desc = 'LSP: Start',
    })

    -----------------------------------------------------------
    -- MANUAL LSP STOP
    --
    -- <leader>lS
    -----------------------------------------------------------

    vim.keymap.set('n', '<leader>lS', function()
      local filetype = vim.bo.filetype
      local server = filetype_servers[filetype]

      if not server then
        vim.notify('No LSP configured for: ' .. filetype, vim.log.levels.WARN)
        return
      end

      -- Disable the server so it cannot restart.
      vim.lsp.enable(server, false)

      -- Stop the currently running client.
      for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
        if client.name == server then
          vim.lsp.stop_client(client.id)
        end
      end

      vim.notify(server .. ' stopped', vim.log.levels.INFO)
    end, {
      desc = 'LSP: Stop',
    })
  end,
}
