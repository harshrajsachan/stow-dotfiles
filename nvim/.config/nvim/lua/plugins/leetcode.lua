return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    -- IMPORTANT: disable swap EARLY
    vim.opt.swapfile = false
    vim.opt.backup = false
    vim.opt.writebackup = false

    require("leetcode").setup({
      lang = "cpp",
      image_support = false,
    })

    local aug = vim.api.nvim_create_augroup("LeetLocal", { clear = true })

    -- use BufEnter instead of FileType
    vim.api.nvim_create_autocmd("BufEnter", {
      group = aug,
      callback = function(args)
        local file = vim.api.nvim_buf_get_name(args.buf)

        -- detect leetcode buffers by path
        if not file:match("leetcode") then
          return
        end

        local opts = { buffer = args.buf, silent = true }

        -- ⚡ keymaps (now will work)
        vim.keymap.set("n", "<leader>la", "<cmd>Leet test<CR>", opts)
        vim.keymap.set("n", "<leader>ls", "<cmd>Leet submit<CR>", opts)
        vim.keymap.set("n", "<leader>lr", "<cmd>Leet reset<CR>", opts)
        vim.keymap.set("n", "<leader>ld", "<cmd>Leet desc<CR>", opts)
        vim.keymap.set("n", "<leader>lh", "<cmd>Leet hints<CR>", opts)
        vim.keymap.set("n", "<leader>ll", "<cmd>Leet list<CR>", opts)
        vim.keymap.set("n", "<leader>lp", "<cmd>Leet lang<CR>", opts)
        vim.keymap.set("n", "<leader>lo", "<cmd>Leet open<CR>", opts)
        vim.keymap.set("n", "<leader>ly", "<cmd>Leet yank<CR>", opts)
      end,
    })
  end,
}
