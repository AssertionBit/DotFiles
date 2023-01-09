local builtin = require('telescope.builtin')

-- FZF
vim.keymap.set('n', '<C-f>', '<Cmd>FZF<cr>', {})

-- Renaming
vim.keymap.set('n', '<C-r>', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true } )

