local M = {}

---------------------------------------------------------------
-- PROJECT LOCATIONS
---------------------------------------------------------------
--
-- Put the directories where you actually keep projects here.
--
-- The picker will automatically ignore directories that don't
-- exist or cannot be accessed.
---------------------------------------------------------------

local project_dirs = {
  '~/NeoVim',
  '~/Projects',
  '~/Documents/GitHub',
}

---------------------------------------------------------------
-- FIND PROJECTS
---------------------------------------------------------------

function M.open()
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  local projects = {}

  -------------------------------------------------------------
  -- Search every configured project directory.
  -------------------------------------------------------------

  for _, base in ipairs(project_dirs) do
    local root = vim.fn.expand(base)

    -- Skip missing directories.
    if vim.fn.isdirectory(root) == 1 then
      local handle = vim.loop.fs_scandir(root)

      if handle then
        while true do
          local name, file_type = vim.loop.fs_scandir_next(handle)

          if not name then
            break
          end

          -- Only directories are projects.
          if file_type == 'directory' then
            table.insert(projects, {
              name = name,
              path = root .. '/' .. name,
            })
          end
        end

        vim.loop.fs_scandir_close(handle)
      end
    end
  end

  -------------------------------------------------------------
  -- Sort alphabetically.
  -------------------------------------------------------------

  table.sort(projects, function(a, b)
    return a.name:lower() < b.name:lower()
  end)

  -------------------------------------------------------------
  -- Nothing found.
  -------------------------------------------------------------

  if #projects == 0 then
    vim.notify('No projects found', vim.log.levels.WARN, {
      title = 'Projects',
    })

    return
  end

  -------------------------------------------------------------
  -- Telescope picker.
  -------------------------------------------------------------

  pickers
    .new({}, {
      prompt_title = 'Projects',

      finder = finders.new_table {
        results = projects,

        entry_maker = function(project)
          return {
            value = project,
            display = project.name,
            ordinal = project.name .. ' ' .. project.path,
          }
        end,
      },

      sorter = conf.generic_sorter {},

      -----------------------------------------------------------
      -- ENTER
      -----------------------------------------------------------

      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()

          if not selection then
            return
          end

          actions.close(prompt_bufnr)

          -------------------------------------------------------
          -- Change working directory.
          -------------------------------------------------------

          vim.cmd('cd ' .. vim.fn.fnameescape(selection.value.path))

          -------------------------------------------------------
          -- Notify user.
          -------------------------------------------------------

          vim.notify('Opened ' .. selection.value.name, vim.log.levels.INFO, {
            title = 'Projects',
          })

          -------------------------------------------------------
          -- Immediately show files inside the project.
          -------------------------------------------------------

          require('telescope.builtin').find_files {
            cwd = selection.value.path,
            hidden = true,
          }
        end)

        return true
      end,
    })
    :find()
end

return M
