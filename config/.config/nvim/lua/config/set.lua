-- === Appearance ===
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.colorcolumn = "100"  -- Highlight column 100
vim.opt.cursorline = true    -- Highlight the current line
vim.opt.guicursor = ""       -- Use block cursor in all modes
-- vim.opt.laststatus = 0;
vim.opt.cmdheight = 0;

-- Transparent background settings
vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none", bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { ctermbg = "none", bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { ctermbg = "none", bg = "none" })

-- === Line Numbers & Layout ===
vim.opt.nu = true             -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.signcolumn = "yes"    -- Always show the sign column
vim.opt.scrolloff = 8         -- Keep 8 lines above/below cursor

-- === Indentation & Tabs ===
vim.opt.tabstop = 4        -- Number of spaces for a tab
vim.opt.softtabstop = 4    -- Number of spaces for <Tab> in insert mode
vim.opt.shiftwidth = 4     -- Number of spaces for autoindent
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.smartindent = true -- Smarter autoindenting

-- === Wrapping ===
vim.opt.wrap = false -- Don't wrap long lines

-- === File Management ===
vim.opt.swapfile = false                                     -- Disable swap files
vim.opt.backup = false                                       -- Disable backup files
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/" -- Set undo directory
vim.opt.undofile = true                                      -- Enable persistent undo

-- === Search ===
vim.opt.hlsearch = false  -- Disable highlight on search
vim.opt.incsearch = true  -- Show matches while typing
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true  -- Override ignorecase if search contains uppercase

-- === Performance & Files ===
vim.opt.updatetime = 50       -- Faster update time for CursorHold events
vim.opt.isfname:append("@-@") -- Allow `@` in file names

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Diagnostic list" })


-- Autocmd to set makeprg based on filetype
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        local ft = vim.bo.filetype
        if ft == "c" then
            vim.bo.makeprg = "gcc -Wall -Wextra -g -lm -o \"%<\" \"%\" && \"./%<\""
        elseif ft == "cpp" then
            vim.bo.makeprg = "g++ -Wall -Wextra -std=c++17 -g -o \"%<\" \"%\" && \"%<\""
        elseif ft == "python" then
            vim.bo.makeprg = 'python3 "%"'
        elseif ft == "java" then
            vim.bo.makeprg = 'java "%"'
        elseif ft == "lua" then
            vim.bo.makeprg = 'lua "%"'
        elseif ft == "rust" then
            vim.bo.makeprg = 'cargo build'
        elseif ft == "js" then
            vim.bo.makeprg = 'node "%"'
        elseif ft == "go" then
            vim.bo.makeprg = 'go build'
        end
    end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = "make",
    command = "cclose"
})


function themes(theme)
    vim.cmd("colorscheme " .. theme)
    vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none", bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { ctermbg = "none", bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { ctermbg = "none", bg = "none" })
end

-- 🧩 Remove underline from C syntax (cBlock keeps resetting)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "c",
    callback = function()
        vim.api.nvim_set_hl(0, "cBlock", { underline = false, undercurl = false })
    end,
})
