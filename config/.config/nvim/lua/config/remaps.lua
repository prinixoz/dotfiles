vim.g.mapleader = " "
vim.keymap.set("n", "<C-e>", vim.cmd.Ex)


-- Telescope Fuzzy finder
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
