-- NVIM Config
require('core')
require('plugins-list')
require('config-ui')
require('config-lsp')
require('tweeks')
require('keymap')

if vim.g.neovide then
  vim.o.guifont= "JetbrainsMonoNL Nerd Font Mono:h10"
end
