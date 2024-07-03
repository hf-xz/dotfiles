-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.wrap = true
opt.scrolloff = 5
opt.spelllang = { "en", "cjk" }

-- If no prettier config file is found, the formatter will not be used
vim.g.lazyvim_prettier_needs_config = true
