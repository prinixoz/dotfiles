vim.g.mapleader = " "
vim.g.maplocalleader = ','

vim.keymap.set("n", "<Up>", ":echo 'use k instead' <CR>")
vim.keymap.set("n", "<Down>", ":echo 'use j instead' <CR>")
vim.keymap.set("n", "<Left>", ":echo 'use h instead' <CR>")
vim.keymap.set("n", "<Right>", ":echo 'use l instead' <CR>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "L", ":bn<CR>")
vim.keymap.set("n", "H", ":bp<CR>")
vim.keymap.set("n", "<leader>w", ":bd<CR>")
vim.keymap.set("n", "<leader>f", "m7ggVG=`7")
