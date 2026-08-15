return {
  'mfussenegger/nvim-jdtls',

  ft = { 'java' },

  dependencies = {
    'mfussenegger/nvim-dap',
  },

  config = function()
    -- JDTLS is configured in ftplugin/java.lua
  end,
}
