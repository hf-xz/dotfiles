local del = vim.keymap.del
local map = vim.keymap.set

-- Resize window using <ctrl> arrow keys
del("n", "<C-Up>")
del("n", "<C-Down>")
del("n", "<C-Left>")
del("n", "<C-Right>")

-- Move Lines
del("n", "<A-j>")
del("n", "<A-k>")
del("i", "<A-j>")
del("i", "<A-k>")
del("v", "<A-j>")
del("v", "<A-k>")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
del("n", "n")
del("n", "N")
del("x", "n")
del("x", "N")
del("o", "n")
del("o", "N")

-- save file
del({ "i", "x", "n", "s" }, "<C-s>")
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit All" })
map("n", "<leader>qw", "<cmd>x<CR>", { desc = "Save & Quit" })
map("n", "<leader>qQ", "<cmd>qa!<CR>", { desc = "Force Quit" })

-- better indenting
del("v", "<")
del("v", ">")

-- windows
-- del("n", "<leader>ww")
-- del("n", "<leader>wd")
-- del("n", "<leader>wm")
-- del("n", "<leader>w-")
-- del("n", "<leader>w|")
-- del("n", "<leader>-")
-- del("n", "<leader>|")
-- map("n", "<leader>nn", "<C-W>p", { desc = "Other Window", remap = true })
-- map("n", "<leader>nd", "<C-W>c", { desc = "Delete Window", remap = true })
-- map("n", "<leader>nm", function()
--   LazyVim.toggle.maximize()
-- end, { desc = "Maximize Toggle" })
-- map("n", "<leader>n-", "<C-W>s", { desc = "Split Window Below", remap = true })
-- map("n", "<leader>n\\", "<C-W>v", { desc = "Split Window Right", remap = true })
-- map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
-- map("n", "<leader>\\", "<C-W>v", { desc = "Split Window Right", remap = true })
