return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", has = "Hover" },
            { "K", false },
          },
        },
      },
    },
  },
}
