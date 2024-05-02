-- 加载基础 vimrc 配置
vim.cmd.source(vim.fn.stdpath("config") .. "/vimrc")

-- 加载 neovim 插件
require("config.lazy")
