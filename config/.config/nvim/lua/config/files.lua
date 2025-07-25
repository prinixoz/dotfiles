-- === Netrw Settings ===

vim.g.netrw_banner = 0                                   -- Disable the netrw banner
vim.g.netrw_list_hide = '\\.git\\|\\.svn\\|\\.DS_Store'  -- Hide version control & system files
vim.g.netrw_sort_by = 'extension'                        -- Sort files by extension
vim.g.netrw_liststyle = 3                                -- Tree-style listing
vim.g.netrw_winsize = 18                                 -- Set netrw window width
vim.g.netrw_localcopydircmd = 'cp -r'                    -- Use recursive copy for directories

-- === Netrw Keymaps ===

vim.api.nvim_set_keymap('n', '<leader>e', ':Lexplore<CR>', { noremap = true, silent = true }) -- Open file explorer

-- === Netrw Autocommands ===

-- Save last directory and window height when closing netrw
vim.api.nvim_create_autocmd("BufWinLeave", {
    pattern = "netrw://*",
    callback = function()
        vim.g.netrw_last_dir = vim.fn.getcwd()
        vim.g.netrw_winheight = vim.api.nvim_win_get_height(0)
    end,
})

