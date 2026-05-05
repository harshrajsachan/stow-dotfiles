vim.opt.backspace = "indent,eol,start"
vim.opt.guicursor = table.concat({
  -- Normal, Visual, Command
  "n-v-c:block-Cursor/lCursor",
  -- Insert
  "i:hor30-CursorInsert/lCursorInsert",
  -- Visual explicitly (optional override)
  "v:block-CursorVisual/lCursorVisual",
}, ",")
