return {
  'goolord/alpha-nvim',

  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- Header
    dashboard.section.header.val = {
      [[                                                    ]],
      [[███▄▄▄▄      ▄████████  ▄██████▄   ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄   ]],
      [[███▀▀▀██▄   ███    ███ ███    ███ ███    ███ ███  ▄██▀▀▀███▀▀▀██▄ ]],
      [[███   ███   ███    ▀█  ███    ███ ███    ███ ███▌ ███   ███   ███ ]],
      [[███   ███  ▄███▄▄▄     ███    ███ ███    ███ ███▌ ███   ███   ███ ]],
      [[███   ███ ▀▀███▀▀▀     ███    ███ ███    ███ ███▌ ███   ███   ███ ]],
      [[███   ███   ███    █▄  ███    ███ ███    ███ ███  ███   ███   ███ ]],
      [[███   ███   ███    ███ ███    ███ ███    ███ ███  ███   ███   ███ ]],
      [[ ▀█   █▀    ██████████  ▀██████▀   ▀██████▀  █▀    ▀█   ███   █▀  ]],
      [[                                                    ]],
    }

    -- Buttons
    dashboard.section.buttons.val = {

      dashboard.button('n', '  New File', '<cmd>NewFile<CR>'),

      dashboard.button('f', '  Find File', '<cmd>lua Snacks.picker.files()<CR>'),

      dashboard.button('r', '  Recent Files', '<cmd>lua Snacks.picker.recent()<CR>'),

      dashboard.button('p', '  Projects', '<cmd>lua Snacks.picker.projects()<CR>'),

      dashboard.button('s', '  Restore Session', "<cmd>lua require('persistence').load()<CR>"),

      dashboard.button('l', '  LeetCode', '<cmd>Leet<CR>'),

      dashboard.button('c', '  Config', "<cmd>lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })<CR>"),

      dashboard.button('q', '  Quit', '<cmd>qa<CR>'),
    }

    -- Layout
    dashboard.opts.layout = {
      { type = 'padding', val = 2 },

      dashboard.section.header,

      { type = 'padding', val = 2 },

      dashboard.section.buttons,

      { type = 'padding', val = 1 },

      dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)
  end,
}
