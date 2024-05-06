-- 加载基础配置
vim.cmd.source(vim.fn.stdpath("config") .. "/vimrc")

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
