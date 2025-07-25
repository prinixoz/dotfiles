-- === Global Leader Keys ===
vim.g.mapleader = " "      -- Space as leader key
vim.g.maplocalleader = "," -- Comma as local leader key

-- === Normal Mode Keymaps ===

-- Encourage using h/j/k/l instead of arrow keys
vim.keymap.set("n", "<Up>", ":echo 'use k instead' <CR>")
vim.keymap.set("n", "<Down>", ":echo 'use j instead' <CR>")
vim.keymap.set("n", "<Left>", ":echo 'use h instead' <CR>")
vim.keymap.set("n", "<Right>", ":echo 'use l instead' <CR>")

-- Copy to end of line with capital Y (like D and C)
vim.keymap.set("n", "Y", "y$")

-- Buffer navigation
vim.keymap.set("n", "L", ":bn<CR>") -- Next buffer
vim.keymap.set("n", "H", ":bp<CR>") -- Previous buffer
vim.keymap.set("n", "<leader>w", ":bd<CR>") -- Close current buffer
vim.api.nvim_set_keymap("n", "<Tab>", "<c-^>'”zz", { noremap = true, silent = true }) -- Toggle to previous buffer

-- Indent entire file quickly
vim.keymap.set("n", "<leader>f", "m7ggVG=`7") -- Re-indent entire file and return cursor

-- === Visual Mode Keymaps ===

-- Move selected line(s) up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- === Terminal Keymaps ===

-- Open terminal in normal mode
vim.api.nvim_set_keymap("n", "<leader>t", ":terminal<CR>", { noremap = true, silent = true })

-- Exit terminal mode with Esc
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '(', '()<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '[', '[]<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '{', '{}<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '"', '""<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', "'", "''<Left>", { noremap = true })
