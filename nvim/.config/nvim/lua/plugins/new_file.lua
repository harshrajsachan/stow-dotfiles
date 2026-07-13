return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      vim.api.nvim_create_user_command("NewFile", function()
        local dir = vim.fn.expand("~/NeoVim")
        vim.fn.mkdir(dir, "p")

        local types = {
          { "📄 Text", "txt" },
          { " C++", "cpp" },
          { " Python", "py" },
          { " Java", "java" },
          { " HTML", "html" },
          { " CSS", "css" },
          { " JavaScript", "js" },
          { " Markdown", "md" },
          { " JSON", "json" },
          { " Shell", "sh" },
          { " Lua", "lua" },
          { "󰈔 Custom", nil },
        }

        vim.ui.select(types, {
          prompt = "Select File Type",
          format_item = function(item)
            return item[1]
          end,
        }, function(choice)
          if not choice then
            return
          end

          local ext = choice[2]
          if not ext then
            ext = vim.fn.input("Extension: ")
            if ext == "" then
              return
            end
          end

          local name = vim.fn.input("File name: ")
          if name == "" then
            return
          end

          local path = string.format("%s/%s.%s", dir, name, ext)

          vim.cmd("edit " .. vim.fn.fnameescape(path))
          vim.cmd("startinsert")
        end)
      end, {})
    end,
  },
}
