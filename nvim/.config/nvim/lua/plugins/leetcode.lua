return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    -- Disable swap files
    vim.opt.swapfile = false
    vim.opt.backup = false
    vim.opt.writebackup = false

    require("leetcode").setup({
      lang = "cpp",
      image_support = true,
    })

    -- Global keymaps
    vim.keymap.set("n", "<leader>lc", "<cmd>Leet cookie update<CR>", {
      desc = "Update LeetCode Cookie",
      silent = true,
    })

    vim.keymap.set("n", "<leader>ll", "<cmd>Leet list<CR>", {
      desc = "LeetCode List",
      silent = true,
    })

    vim.keymap.set("n", "<leader>lk", function()
      local prev = vim.fn.bufnr("#")
      if prev > 0 and vim.api.nvim_buf_is_valid(prev) then
        vim.cmd("bdelete " .. prev)
      end
    end, {
      desc = "Delete previous buffer",
      silent = true,
    })

    local aug = vim.api.nvim_create_augroup("LeetLocal", { clear = true })

    vim.api.nvim_create_autocmd("BufEnter", {
      group = aug,
      callback = function(args)
        local file = vim.api.nvim_buf_get_name(args.buf)

        if not file:lower():match("leetcode") then
          return
        end

        -- Disable diagnostics
        vim.diagnostic.enable(false, { bufnr = args.buf })

        -- Disable inlay hints
        pcall(vim.lsp.inlay_hint.enable, false, { bufnr = args.buf })

        -- Disable LazyVim autoformat
        vim.b[args.buf].autoformat = false

        -- Detach every LSP from this buffer
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
          vim.lsp.buf_detach_client(args.buf, client.id)
        end

        local opts = { buffer = args.buf, silent = true }

        vim.keymap.set("n", "<leader>la", "<cmd>Leet test<CR>", opts)
        vim.keymap.set("n", "<leader>ls", "<cmd>Leet submit<CR>", opts)
        vim.keymap.set("n", "<leader>lr", "<cmd>Leet reset<CR>", opts)
        vim.keymap.set("n", "<leader>ld", "<cmd>Leet desc<CR>", opts)
        vim.keymap.set("n", "<leader>lh", "<cmd>Leet hints<CR>", opts)
        vim.keymap.set("n", "<leader>lp", "<cmd>Leet lang<CR>", opts)
        vim.keymap.set("n", "<leader>lo", "<cmd>Leet open<CR>", opts)
        vim.keymap.set("n", "<leader>ly", "<cmd>Leet yank<CR>", opts)
        vim.keymap.set("n", "<leader>le", "<cmd>Leet random difficulty=easy status=todo<CR>", opts)
        vim.keymap.set("n", "<leader>lm", "<cmd>Leet random difficulty=medium status=todo<CR>", opts)
      end,
    })
  end,
}
