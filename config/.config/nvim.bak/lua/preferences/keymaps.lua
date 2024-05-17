local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap
-- Leader key define
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Moving between buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>w", ":bd<CR>", opts)

-- Explorer
keymap("n", "<C-e>", ":Ex<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)

--close window
keymap("", "<Space>", "<Nop>", opts)

-- stop arrow usage
keymap("n", "<left>", ":echo 'use h instead'<CR>",opts)
keymap("n", "<up>", ":echo 'use j instead'<CR>",opts)
keymap("n", "<down>", ":echo 'use k instead'<CR>",opts)
keymap("n", "<right>", ":echo 'use l instead'<CR>",opts)

keymap("i", "<left>", "<Esc>:echo 'use h instead'<CR>l",opts)
keymap("i", "<up>", "<Esc>:echo 'use j instead'<CR>l",opts)
keymap("i", "<down>", "<Esc>:echo 'use k instead'<CR>l",opts)
keymap("i", "<right>", "<Esc>:echo 'use l instead'<CR>l",opts)

-- sourcing neovim config
keymap("n", "<leader>s", ":so ~/.config/nvim/init.lua<CR>", opts)

-- Terminal
keymap("n", "<C-w>t", ":terminal<CR>i", opts)
keymap("t", "<C-w><C-w>", "<C-\\><C-n><C-w><C-w>", opts)
keymap("t", "<C-w>q", "<C-\\><C-n>:q!<CR>", opts)
keymap("t", "<Esc>", "<C-\\><C-n>", opts)
vim.cmd[[autocmd BufWinEnter,WinEnter term://* startinsert]]
vim.cmd[[autocmd TermOpen * setlocal nonumber norelativenumber]]
