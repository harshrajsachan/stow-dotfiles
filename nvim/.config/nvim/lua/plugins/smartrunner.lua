return {
  "harshrajsachan/smartrunner.nvim",
  config = function()
    local languages = require("smartrunner.languages")

    vim.keymap.set("n", "<leader>lr", function()
      require("smartrunner").run()
    end, { desc = "SmartRunner: Run File" })

    vim.keymap.set("n", "<leader>lb", function()
      require("smartrunner").build()
    end, { desc = "SmartRunner: Build" })

    vim.keymap.set("n", "<leader>lk", function()
      require("smartrunner").stop()
    end, { desc = "SmartRunner: Stop" })

    vim.keymap.set("n", "<leader>lR", function()
      require("smartrunner").restart()
    end, { desc = "SmartRunner: Restart" })

    vim.keymap.set("n", "<leader>lt", function()
      require("smartrunner").toggle()
    end, { desc = "SmartRunner: Toggle Terminal" })

    vim.keymap.set("n", "<leader>lc", function()
      require("smartrunner").close()
    end, { desc = "SmartRunner: Close Terminal" })
    require("smartrunner").setup({
      runners = languages.get(),
    })
  end,
}
