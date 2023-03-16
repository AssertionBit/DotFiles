local builtin = require('telescope.builtin')

-- Outline
vim.keymap.set('n', '<C-o>', '<Cmd>SymbolsOutline<cr>', {})

-- FZF
vim.keymap.set('n', '<C-f>', '<Cmd>NvimTreeFindFile<cr>', {})
vim.keymap.set('n', '<C-d>', '<Cmd>NvimTreeFocus<cr>', {})
vim.keymap.set('n', '<C-w>', '<Cmd>NvimTreeToggle<cr>', {})
vim.keymap.set('n', '<C-]>', '<Cmd>NvimTreeResize +5<cr>', {})

-- Renaming
vim.keymap.set('n', '<C-r>', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true } )

