-- Disable the netrw banner (intro message)
vim.g.netrw_banner = 0

-- Make netrw ignore hidden files by default
vim.g.netrw_list_hide = '\\.git\\|\\.svn\\|\\.DS_Store'

-- Enable sorting files by extension (alphabetically) and folder first
vim.g.netrw_sort_by = 'extension'

-- Show a readable directory listing (remove some unnecessary details)
vim.g.netrw_liststyle = 3  -- This will give a "tree" style view

vim.g.netrw_winsize = 18
vim.g.netrw_localcopydircmd = 'cp -r'

vim.api.nvim_set_keymap('n', '<C-e>', ':Lexplore<CR>', { noremap = true, silent = true })

