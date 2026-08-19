return {
  'kawre/leetcode.nvim',

  build = ':TSUpdate',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    ---------------------------------------------------------------------------
    -- BASIC
    ---------------------------------------------------------------------------

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
    -- AUTOCOMMAND GROUP
    ---------------------------------------------------------------------------

    local aug = vim.api.nvim_create_augroup('LeetMinimal', {
      clear = true,
    })

    ---------------------------------------------------------------------------
    -- DETECT LEETCODE BUFFER
    ---------------------------------------------------------------------------

    local function is_leetcode(bufnr)
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return false
      end

      local file = vim.api.nvim_buf_get_name(bufnr):lower()

      return file:match 'leetcode' ~= nil
    end

    ---------------------------------------------------------------------------
    -- DETECT LEETCODE DESCRIPTION BUFFER
    ---------------------------------------------------------------------------

    local function is_leetcode_description(bufnr)
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return false
      end

      return vim.bo[bufnr].filetype == 'leetcode.nvim' and vim.bo[bufnr].buftype == 'nofile'
    end

    ---------------------------------------------------------------------------
    -- DISABLE LSP
    ---------------------------------------------------------------------------

    local function disable_lsp(bufnr)
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end

      -------------------------------------------------------------------------
      -- Diagnostics
      -------------------------------------------------------------------------

      vim.diagnostic.enable(false, {
        bufnr = bufnr,
      })

      -------------------------------------------------------------------------
      -- Inlay hints
      -------------------------------------------------------------------------

      pcall(function()
        vim.lsp.inlay_hint.enable(false, {
          bufnr = bufnr,
        })
      end)

      -------------------------------------------------------------------------
      -- Semantic tokens
      -------------------------------------------------------------------------

      pcall(function()
        vim.lsp.semantic_tokens.enable(false, {
          bufnr = bufnr,
        })
      end)

      -------------------------------------------------------------------------
      -- Detach only clients actually attached to this buffer
      -------------------------------------------------------------------------

      for _, client in
        ipairs(vim.lsp.get_clients {
          bufnr = bufnr,
        })
      do
        if client and client.id and not client:is_stopped() then
          pcall(function()
            vim.lsp.buf_detach_client(bufnr, client.id)
          end)
        end
      end

      -------------------------------------------------------------------------
      -- Disable formatting
      -------------------------------------------------------------------------

      vim.b[bufnr].autoformat = false
      vim.b[bufnr].formatexpr = ''
    end

    ---------------------------------------------------------------------------
    -- DISABLE GITSIGNS
    ---------------------------------------------------------------------------

    local function disable_gitsigns(bufnr)
      pcall(function()
        require('gitsigns').detach(bufnr)
      end)

      pcall(vim.fn.sign_unplace, '*', {
        buffer = bufnr,
      })
    end

    ---------------------------------------------------------------------------
    -- HIDE LUALINE
    ---------------------------------------------------------------------------

    local function hide_lualine()
      pcall(function()
        require('lualine').hide {
          place = {
            'statusline',
            'winbar',
          },
          unhide = false,
        }
      end)

      vim.opt.laststatus = 0
    end

    ---------------------------------------------------------------------------
    -- RESTORE LUALINE
    ---------------------------------------------------------------------------

    local function restore_lualine()
      pcall(function()
        require('lualine').hide {
          place = {
            'statusline',
            'winbar',
          },
          unhide = true,
        }
      end)
    end

    ---------------------------------------------------------------------------
    -- HIDE BUFFERLINE / TABLINE
    ---------------------------------------------------------------------------

    local function hide_bufferline()
      vim.opt.showtabline = 0
    end

    ---------------------------------------------------------------------------
    -- RESTORE BUFFERLINE / TABLINE
    ---------------------------------------------------------------------------

    local function restore_bufferline()
      vim.opt.showtabline = 2
    end

    ---------------------------------------------------------------------------
    -- MINIMAL WINDOW
    ---------------------------------------------------------------------------

    local function enable_minimal_ui()
      local win = vim.api.nvim_get_current_win()

      if not vim.api.nvim_win_is_valid(win) then
        return
      end

      -------------------------------------------------------------------------
      -- No Git / diagnostic signs
      -------------------------------------------------------------------------

      vim.wo[win].signcolumn = 'no'

      -------------------------------------------------------------------------
      -- No fold column
      -------------------------------------------------------------------------

      vim.wo[win].foldcolumn = '0'

      -------------------------------------------------------------------------
      -- Disable folding
      -------------------------------------------------------------------------

      vim.wo[win].foldenable = false

      -------------------------------------------------------------------------
      -- Line numbers
      -------------------------------------------------------------------------

      vim.wo[win].number = true
      vim.wo[win].relativenumber = false

      -------------------------------------------------------------------------
      -- No cursorline
      -------------------------------------------------------------------------

      vim.wo[win].cursorline = false

      -------------------------------------------------------------------------
      -- No color column
      -------------------------------------------------------------------------

      vim.wo[win].colorcolumn = ''

      -------------------------------------------------------------------------
      -- No winbar
      -------------------------------------------------------------------------

      vim.wo[win].winbar = ''

      -------------------------------------------------------------------------
      -- No list characters
      -------------------------------------------------------------------------

      vim.wo[win].list = false
    end

    ---------------------------------------------------------------------------
    -- DESCRIPTION WINDOW UI
    ---------------------------------------------------------------------------

    local function enable_description_ui()
      local win = vim.api.nvim_get_current_win()

      if not vim.api.nvim_win_is_valid(win) then
        return
      end

      -------------------------------------------------------------------------
      -- Description should have NO line numbers
      -------------------------------------------------------------------------

      vim.wo[win].number = false
      vim.wo[win].relativenumber = false

      -------------------------------------------------------------------------
      -- No signs
      -------------------------------------------------------------------------

      vim.wo[win].signcolumn = 'no'

      -------------------------------------------------------------------------
      -- No fold column
      -------------------------------------------------------------------------

      vim.wo[win].foldcolumn = '0'

      -------------------------------------------------------------------------
      -- No folding
      -------------------------------------------------------------------------

      vim.wo[win].foldenable = false

      -------------------------------------------------------------------------
      -- No cursorline
      -------------------------------------------------------------------------

      vim.wo[win].cursorline = false

      -------------------------------------------------------------------------
      -- No color column
      -------------------------------------------------------------------------

      vim.wo[win].colorcolumn = ''

      -------------------------------------------------------------------------
      -- No winbar
      -------------------------------------------------------------------------

      vim.wo[win].winbar = ''

      -------------------------------------------------------------------------
      -- No list characters
      -------------------------------------------------------------------------

      vim.wo[win].list = false

      -------------------------------------------------------------------------
      -- Keep LeetCode UI clean
      -------------------------------------------------------------------------

      hide_lualine()
      hide_bufferline()
    end

    ---------------------------------------------------------------------------
    -- CLOSE MASON
    ---------------------------------------------------------------------------

    local function close_mason()
      pcall(vim.cmd, 'MasonClose')
    end

    ---------------------------------------------------------------------------
    -- CLEAN LEETCODE BUFFER
    ---------------------------------------------------------------------------

    local function clean_leetcode(bufnr)
      if not is_leetcode(bufnr) then
        return
      end

      disable_lsp(bufnr)
      disable_gitsigns(bufnr)
      enable_minimal_ui()
      hide_lualine()
      hide_bufferline()
      close_mason()
    end

    ---------------------------------------------------------------------------
    -- LEETCODE ENTER
    ---------------------------------------------------------------------------

    vim.api.nvim_create_autocmd('BufEnter', {
      group = aug,

      callback = function(args)
        -----------------------------------------------------------------------
        -- DESCRIPTION BUFFER
        -----------------------------------------------------------------------

        if is_leetcode_description(args.buf) then
          enable_description_ui()
          return
        end

        -----------------------------------------------------------------------
        -- NORMAL BUFFER
        -----------------------------------------------------------------------

        if not is_leetcode(args.buf) then
          restore_lualine()
          restore_bufferline()
          return
        end

        -----------------------------------------------------------------------
        -- Hide buffer/tab bar
        -----------------------------------------------------------------------

        hide_bufferline()

        -----------------------------------------------------------------------
        -- Clean current LeetCode buffer
        -----------------------------------------------------------------------

        clean_leetcode(args.buf)

        -----------------------------------------------------------------------
        -- LeetCode creates some UI asynchronously.
        -- Clean again after creation.
        -----------------------------------------------------------------------

        vim.defer_fn(function()
          if vim.api.nvim_buf_is_valid(args.buf) and is_leetcode(args.buf) then
            clean_leetcode(args.buf)
          end
        end, 100)

        vim.defer_fn(function()
          if vim.api.nvim_buf_is_valid(args.buf) and is_leetcode(args.buf) then
            clean_leetcode(args.buf)
          end
        end, 300)
      end,
    })

    ---------------------------------------------------------------------------
    -- LSP ATTACH PROTECTION
    ---------------------------------------------------------------------------

    vim.api.nvim_create_autocmd('LspAttach', {
      group = aug,

      callback = function(args)
        if not is_leetcode(args.buf) then
          return
        end

        vim.schedule(function()
          if not vim.api.nvim_buf_is_valid(args.buf) then
            return
          end

          ---------------------------------------------------------------------
          -- Only detach clients that are actually attached.
          ---------------------------------------------------------------------

          for _, client in
            ipairs(vim.lsp.get_clients {
              bufnr = args.buf,
            })
          do
            if client and client.id and not client:is_stopped() then
              pcall(function()
                vim.lsp.buf_detach_client(args.buf, client.id)
              end)
            end
          end

          disable_lsp(args.buf)
        end)
      end,
    })

    ---------------------------------------------------------------------------
    -- GITSIGNS PROTECTION
    ---------------------------------------------------------------------------

    vim.api.nvim_create_autocmd('User', {
      group = aug,
      pattern = 'GitSignsUpdate',

      callback = function()
        local buf = vim.api.nvim_get_current_buf()

        if is_leetcode(buf) then
          disable_gitsigns(buf)
        end
      end,
    })

    ---------------------------------------------------------------------------
    -- MASON PROTECTION
    ---------------------------------------------------------------------------

    vim.api.nvim_create_autocmd('FileType', {
      group = aug,
      pattern = 'mason',

      callback = function()
        local current = vim.api.nvim_get_current_buf()

        if is_leetcode(current) then
          vim.schedule(close_mason)
        end
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

    ---------------------------------------------------------------------------
    -- RESTORE UI WHEN LEAVING LEETCODE
    ---------------------------------------------------------------------------

    vim.api.nvim_create_autocmd('BufLeave', {
      group = aug,

      callback = function(args)
        -----------------------------------------------------------------------
        -- Do NOT restore anything when moving between the solution and
        -- LeetCode description window.
        -----------------------------------------------------------------------

        if is_leetcode(args.buf) or is_leetcode_description(args.buf) then
          return
        end

        restore_lualine()
        restore_bufferline()
      end,
    })
  end,
}
