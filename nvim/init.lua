-- 加载基础配置
vim.cmd.source(vim.fn.stdpath("config") .. "/vimrc")

-- settings
local opt = vim.opt

opt.mouse = ""                -- 禁用鼠标
opt.wrap = false              -- 不自动折行
-- opt.clipboard = "unnamedplus" -- 使用系统剪切板
-- opt.list = true               -- 启用显示空白字符
--                               -- 设置显示的空白字符符号
-- opt.listchars:append({tab = '→\\ ', trail = '·', extends = '→', precedes = '←'})
opt.scrolloff = 5             -- 上下保留行数
opt.number = false            -- 启用行号
--vim.opt.relativenumber = true -- 启用相对行号


-- keymaps
vim.g.mapleader = " "

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- windows
map("n", "<leader>nw", "<C-W>p", { desc = "Other window" })
map("n", "<leader>nd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>n-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>n|", "<C-W>v", { desc = "Split window right" })
-- custom keymaps
map("n", "<leader>h", "<cmd>noh<cr>", { desc = "No highlight" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>q!<cr>", { desc = "Force Quit" })
-- scroll 9 lines
map("n", "<C-u>", "9k", { desc = "Scroll up" })
map("n", "<C-d>", "9j", { desc = "Scroll down" })
-- toggle line number
map("n", "<leader>ll", "<cmd>set number!<CR>", { desc = "Toggle line number" })
map("n", "<leader>lr", "<cmd>set relativenumber!<CR>", { desc = "Toggle relative line number" })

