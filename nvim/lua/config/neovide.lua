-- start at home directory
-- vim.cmd("cd ~")

-- vim.o.guifont = "FiraCode Nerd Font:h14"
vim.o.guifont = "Maple Mono NF CN:h14"
vim.opt.linespace = 0

-- vim.g.neovide_padding_top = 8

vim.g.neovide_theme = "dark"
vim.g.neovide_opacity = 0.92
vim.g.neovide_window_blurred = true

vim.g.neovide_input_macos_alt_is_meta = false

-- ime
local function set_ime(args)
  if args.event:match("Enter$") then
    vim.g.neovide_input_ime = true
  else
    vim.g.neovide_input_ime = false
  end
end

local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
  group = ime_input,
  pattern = "*",
  callback = set_ime,
})

vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
  group = ime_input,
  pattern = "[/\\?]",
  callback = set_ime,
})
