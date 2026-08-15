local jdtls = require 'jdtls'
local jdtls_setup = require 'jdtls.setup'

-----------------------------------------------------------
-- Paths
-----------------------------------------------------------

local home = vim.env.HOME

local mason_jdtls = home .. '/.local/share/nvim/mason/packages/jdtls'

local workspace_dir = home .. '/.local/share/nvim/jdtls-workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

-----------------------------------------------------------
-- OS
-----------------------------------------------------------

local system = 'linux'

-----------------------------------------------------------
-- Root directory
-----------------------------------------------------------

local root_dir = jdtls_setup.find_root {
  'mvnw',
  'gradlew',
  'pom.xml',
  'build.gradle',
  'settings.gradle',
  '.git',
}

if root_dir == nil then
  return
end

-----------------------------------------------------------
-- JDTLS command
-----------------------------------------------------------

local cmd = {
  'jdtls',

  '-data',
  workspace_dir,
}

-----------------------------------------------------------
-- Java settings
-----------------------------------------------------------

local config = {
  cmd = cmd,

  root_dir = root_dir,

  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },

      maven = {
        downloadSources = true,
      },

      configuration = {
        updateBuildConfiguration = 'interactive',

        runtimes = {
          {
            name = 'JavaSE-26',
            path = '/usr/lib/jvm/java-26-openjdk',
          },

          {
            name = 'JavaSE-8',
            path = '/usr/lib/jvm/java-8-openjdk',
          },
        },
      },

      format = {
        enabled = true,
      },

      signatureHelp = {
        enabled = true,
      },

      contentProvider = {
        preferred = 'fernflower',
      },

      completion = {
        favoriteStaticMembers = {
          'org.junit.Assert.*',
          'org.junit.Assume.*',
          'org.junit.jupiter.api.Assertions.*',
          'org.junit.jupiter.api.Assumptions.*',
          'org.junit.jupiter.api.DynamicContainer.*',
          'org.junit.jupiter.api.DynamicTest.*',
        },
      },
    },
  },

  init_options = {
    bundles = {},
  },
}

-----------------------------------------------------------
-- Java keymaps
-----------------------------------------------------------

local map = function(mode, keys, func, desc)
  vim.keymap.set(mode, keys, func, {
    buffer = true,
    desc = 'Java: ' .. desc,
  })
end

map('n', '<leader>jo', jdtls.organize_imports, 'Organize Imports')

map('n', '<leader>jc', jdtls.compile, 'Compile')

map('n', '<leader>jr', jdtls.update_project_config, 'Update Project Config')

map('n', '<leader>jt', jdtls.test_nearest_method, 'Test Method')

map('n', '<leader>jT', jdtls.test_class, 'Test Class')

jdtls.start_or_attach(config)
