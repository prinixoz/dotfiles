vim = vim

vim.g.mapleader = " "
vim.g.maplocalleader = ','

-- No Normal keys only vim keys are allowed;
vim.keymap.set("n", "<Up>", ":echo 'use k instead' <CR>")
vim.keymap.set("n", "<Down>", ":echo 'use j instead' <CR>")
vim.keymap.set("n", "<Left>", ":echo 'use h instead' <CR>")
vim.keymap.set("n", "<Right>", ":echo 'use l instead' <CR>")


vim.keymap.set("n", "Y", "y$") -- Copy the whole line with capital Y;

-- terminal
vim.api.nvim_set_keymap('n', '<leader>t', ':terminal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- Moving the whole line in visual mode;
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Changing buffers;
vim.keymap.set("n", "L", ":bn<CR>")
vim.keymap.set("n", "H", ":bp<CR>")
vim.api.nvim_set_keymap('n', '<Tab>', '<c-^>\'”zz', { silent = true, noremap = true }) -- Toggling betwen buffers prev and current;
vim.keymap.set("n", "<leader>w", ":bd<CR>")
-- Line indenting
vim.keymap.set("n", "<leader>f", "m7ggVG=`7")

-- Explorer

-- Store the last opened directory and window height when closing netrw
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "netrw://*",
  callback = function()
    vim.g.netrw_last_dir = vim.fn.getcwd()
    vim.g.netrw_winheight = vim.api.nvim_win_get_height(0)
  end
})



