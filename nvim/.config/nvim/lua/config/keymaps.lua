vim.keymap.set("n", "<leader>tt", function()
  require("config.theme").toggle()
end, { desc = "Toggle Theme" })
-- disable default Lazy binding
vim.keymap.set("n", "<leader>l", "<Nop>", { silent = true })
-- move Lazy to <leader>L
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Lazy" })
--yank whole file
vim.keymap.set("n", "<leader>yy", function()
  vim.cmd("%y")
end, { desc = "Yank entire file" })
vim.keymap.set("n", "<leader>dd", "<cmd>%d+<cr>", { desc = "Cut entire file to clipboard" })
-- Keymaps are automatically loaded on the VeryLazy event
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "save" }) -- keymap are automatically loaded on the VeryLazy event
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" }) -- keymap are automatically loaded on the VeryLazy event
vim.keymap.set("n", "<leader>wq", "<cmd>wq<cr>", { desc = "Save and quit" }) -- keymap are automatically loaded on the VeryLazy event
-- Move selected lines down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- Move selected lines up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
--space key leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- Resize with arrows
-- Resize windows
vim.keymap.set("n", "<Up>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<Down>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<Left>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<Right>", "<cmd>vertical resize +2<cr>")

-- Buffers
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>")
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>")
vim.keymap.set("n", "<leader>x", "<cmd>bdelete!<cr>") -- or <cmd>bd!<cr> if no plugin
vim.keymap.set("n", "<leader>b", "<cmd>enew<cr>")

-- Numbers
vim.keymap.set("n", "<leader>+", "<C-a>")
vim.keymap.set("n", "<leader>-", "<C-x>")

-- Splits
vim.keymap.set("n", "<leader>v", "<C-w>v")
vim.keymap.set("n", "<leader>h", "<C-w>s")

-- Tabs
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<cr>")
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<cr>")
vim.keymap.set("n", "<leader>tn", "<cmd>tabnext<cr>")
vim.keymap.set("n", "<leader>tp", "<cmd>tabprevious<cr>")

-- Visual indent (stay selected)
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
--move ctrl-d while at centter
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
--move while cursor in  centter
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
--go to normal with ij
vim.keymap.set("i", "jk", "<Esc>")
--move through window
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-q>", "<cmd>close<CR>", { desc = "Close current window" })
--find and replace
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
--delete one char without yank
vim.keymap.set("n", "x", '"_x')

--c++ run
vim.keymap.set("n", "<leader>r", function()
  vim.cmd("w")

  local file = vim.fn.shellescape(vim.fn.expand("%:p"))
  local dir = vim.fn.shellescape(vim.fn.expand("%:p:h"))
  local output = vim.fn.shellescape(vim.fn.expand("%:t:r"))

  vim.cmd("split")
  vim.cmd("terminal cd " .. dir .. " && g++ -std=c++17 -O2 -Wall " .. file .. " -o " .. output .. " && ./" .. output)
end, { desc = "Run C++ (robust)" })
--java run
vim.keymap.set("n", "<leader>j", function()
  vim.cmd("w")

  local file = vim.fn.expand("%:p") -- full path
  local dir = vim.fn.expand("%:p:h") -- directory
  local classname = vim.fn.expand("%:t:r") -- filename = class name

  vim.cmd("split")
  vim.cmd("terminal cd " .. dir .. " && javac " .. file .. " && java " .. classname)
end, { desc = "Compile & Run Java" })
--python run
vim.keymap.set("n", "<leader>p", function()
  vim.cmd("w")

  local file = vim.fn.expand("%:p") -- full path
  local dir = vim.fn.expand("%:p:h") -- file directory

  vim.cmd("split")
  vim.cmd("terminal cd " .. dir .. " && python3 " .. file)
end, { desc = "Run Python" })
