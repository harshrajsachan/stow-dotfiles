return {
  "snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = [[
███▄▄▄▄      ▄████████  ▄██████▄        ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄   
███▀▀▀██▄   ███    ███ ███    ███      ███    ███ ███  ▄██▀▀▀███▀▀▀██▄ 
███   ███   ███    █▀  ███    ███      ███    ███ ███▌ ███   ███   ███ 
███   ███  ▄███▄▄▄     ███    ███      ███    ███ ███▌ ███   ███   ███ 
███   ███ ▀▀███▀▀▀     ███    ███      ███    ███ ███▌ ███   ███   ███ 
███   ███   ███    █▄  ███    ███      ███    ███ ███  ███   ███   ███ 
███   ███   ███    ███ ███    ███      ███    ███ ███  ███   ███   ███ 
 ▀█   █▀    ██████████  ▀██████▀        ▀██████▀  █▀    ▀█   ███   █▀  

 ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.dashboard.pick('projects')" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "l", desc = "LeetCode", action = ":Leet" },
          { icon = " ", key = "g", desc = "Git Status", action = ":LazyGit" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
}
