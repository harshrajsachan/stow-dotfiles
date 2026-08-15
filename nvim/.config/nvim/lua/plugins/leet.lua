return {
  'kawre/leetcode.nvim',

  build = ':TSUpdate',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    vim.opt.swapfile = false
    vim.opt.backup = false
    vim.opt.writebackup = false

    require('leetcode').setup {
      lang = 'cpp',
      image_support = true,
    }

    ---------------------------------------------------------------------------
    -- GLOBAL KEYMAPS
    ---------------------------------------------------------------------------

    vim.keymap.set('n', '<leader>lc', '<cmd>Leet cookie update<CR>', {
      desc = 'Update LeetCode Cookie',
      silent = true,
    })

    vim.keymap.set('n', '<leader>ll', '<cmd>Leet list<CR>', {
      desc = 'LeetCode List',
      silent = true,
    })

    ---------------------------------------------------------------------------
    -- LEETCODE
    ---------------------------------------------------------------------------

    local aug = vim.api.nvim_create_augroup('LeetLocal', { clear = true })

    local function is_leetcode(bufnr)
      local file = vim.api.nvim_buf_get_name(bufnr)
      return file:lower():match 'leetcode' ~= nil
    end

    local function disable_lsp(bufnr)
      -- Diagnostics
      vim.diagnostic.enable(false, {
        bufnr = bufnr,
      })

      -- Inlay hints
      pcall(vim.lsp.inlay_hint.enable, false, {
        bufnr = bufnr,
      })

      -- Detach every currently attached LSP
      for _, client in
        ipairs(vim.lsp.get_clients {
          bufnr = bufnr,
        })
      do
        pcall(vim.lsp.buf_detach_client, bufnr, client.id)
      end

      -- Prevent formatting
      vim.b[bufnr].autoformat = false
    end

    ---------------------------------------------------------------------------
    -- LEETCODE BUFFER ENTER
    ---------------------------------------------------------------------------

    vim.api.nvim_create_autocmd('BufEnter', {
      group = aug,

      callback = function(args)
        if not is_leetcode(args.buf) then
          return
        end

        -----------------------------------------------------------------------
        -- Remove previous buffer
        -----------------------------------------------------------------------

        local prev = vim.fn.bufnr '#'

        if prev > 0 and prev ~= args.buf and vim.api.nvim_buf_is_valid(prev) and not is_leetcode(prev) then
          pcall(vim.cmd, 'bdelete! ' .. prev)
        end

        -----------------------------------------------------------------------
        -- Disable LSP
        -----------------------------------------------------------------------

        disable_lsp(args.buf)

        -----------------------------------------------------------------------
        -- Close Mason if it is open
        -----------------------------------------------------------------------

        pcall(vim.cmd, 'MasonClose')
      end,
    })

    ---------------------------------------------------------------------------
    -- CATCH LSP ATTACHMENT
    ---------------------------------------------------------------------------

    vim.api.nvim_create_autocmd('LspAttach', {
      group = aug,

      callback = function(args)
        if not is_leetcode(args.buf) then
          return
        end

        -- Immediately detach anything trying to attach
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(args.buf) then
            pcall(vim.lsp.buf_detach_client, args.buf, args.data.client_id)

            disable_lsp(args.buf)
          end
        end)
      end,
    })

    ---------------------------------------------------------------------------
    -- LEETCODE KEYMAPS
    ---------------------------------------------------------------------------

    vim.api.nvim_create_autocmd('BufEnter', {
      group = aug,

      callback = function(args)
        if not is_leetcode(args.buf) then
          return
        end

        local opts = {
          buffer = args.buf,
          silent = true,
        }

        vim.keymap.set('n', '<leader>la', '<cmd>Leet test<CR>', opts)
        vim.keymap.set('n', '<leader>ls', '<cmd>Leet submit<CR>', opts)
        vim.keymap.set('n', '<leader>lr', '<cmd>Leet reset<CR>', opts)
        vim.keymap.set('n', '<leader>ld', '<cmd>Leet desc<CR>', opts)
        vim.keymap.set('n', '<leader>lh', '<cmd>Leet hints<CR>', opts)
        vim.keymap.set('n', '<leader>lp', '<cmd>Leet lang<CR>', opts)
        vim.keymap.set('n', '<leader>lo', '<cmd>Leet open<CR>', opts)
        vim.keymap.set('n', '<leader>ly', '<cmd>Leet yank<CR>', opts)
        vim.keymap.set('n', '<leader>le', '<cmd>Leet random difficulty=easy status=todo<CR>', opts)
        vim.keymap.set('n', '<leader>lm', '<cmd>Leet random difficulty=medium status=todo<CR>', opts)
      end,
    })
  end,
}
