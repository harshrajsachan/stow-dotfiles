-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.clipboard = "unnamedplus"
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand("~/.cargo/bin")
