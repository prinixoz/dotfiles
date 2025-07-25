-- === Appearance ===
vim.opt.termguicolors = true                     -- Enable 24-bit RGB colors
vim.opt.colorcolumn = "100"                      -- Highlight column 100
vim.opt.cursorline = true                        -- Highlight the current line
vim.opt.guicursor = ""                           -- Use block cursor in all modes

-- Transparent background settings
vim.api.nvim_set_hl(0, "Normal",      { ctermbg = "none",  bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC",    { ctermbg = "none",  bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { ctermbg = "none",  bg = "none" })

-- === Line Numbers & Layout ===
vim.opt.nu = true                                -- Show absolute line numbers
vim.opt.relativenumber = true                    -- Show relative line numbers
vim.opt.signcolumn = "yes"                       -- Always show the sign column
vim.opt.scrolloff = 8                            -- Keep 8 lines above/below cursor

-- === Indentation & Tabs ===
vim.opt.tabstop = 4                              -- Number of spaces for a tab
vim.opt.softtabstop = 4                          -- Number of spaces for <Tab> in insert mode
vim.opt.shiftwidth = 4                           -- Number of spaces for autoindent
vim.opt.expandtab = true                         -- Convert tabs to spaces
vim.opt.smartindent = true                       -- Smarter autoindenting

-- === Wrapping ===
vim.opt.wrap = false                             -- Don't wrap long lines

-- === File Management ===
vim.opt.swapfile = false                         -- Disable swap files
vim.opt.backup = false                           -- Disable backup files
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/" -- Set undo directory
vim.opt.undofile = true                          -- Enable persistent undo

-- === Search ===
vim.opt.hlsearch = false                         -- Disable highlight on search
vim.opt.incsearch = true                         -- Show matches while typing
vim.opt.ignorecase = true                        -- Ignore case in search patterns
vim.opt.smartcase = true                         -- Override ignorecase if search contains uppercase

-- === Performance & Files ===
vim.opt.updatetime = 50                          -- Faster update time for CursorHold events
vim.opt.isfname:append("@-@")                    -- Allow `@` in file names
