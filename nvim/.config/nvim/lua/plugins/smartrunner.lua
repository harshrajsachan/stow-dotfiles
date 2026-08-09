return {
  {
    -- Load the local SmartRunner.nvim repository.
    dir = vim.fn.expand("~/MyProject/smartrunner.nvim"),

    -- Give the plugin its name.
    name = "smartrunner.nvim",

    -- Load SmartRunner during startup.
    lazy = false,

    -- Configure SmartRunner.
    config = function()
      -- Load the built-in language definitions.
      local languages = require("smartrunner.languages")

      -- Configure SmartRunner.
      require("smartrunner").setup({
        runners = languages.get(),
      })
    end,
  },
}
