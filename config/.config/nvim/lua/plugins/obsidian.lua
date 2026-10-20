vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
    end,
})

vim.keymap.set("n", "<leader>ow", ":Obsidian workspace<CR>")    -- Re-indent entire file and return cursor
vim.keymap.set("n", "<leader>op", ":Obsidian quick_switch<CR>") -- Re-indent entire file and return cursor
vim.keymap.set("n", "<leader>oo", ":Obsidian<CR>")              -- Re-indent entire file and return cursor

return {
    ---------------------------------------------------------------------------
    -- 1. OBSIDIAN.NVIM
    ---------------------------------------------------------------------------
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        cmd = { "Obsidian" },
        event = {
            "BufReadPre /mnt/PS/Notes/**",
            "BufNewFile /mnt/PS/Notes/**",
            "BufReadPre /mnt/PS/Github/website/content/**",
            "BufNewFile /mnt/PS/Github/website/content/**",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            legacy_commands = false,

            workspaces = {
                {
                    name = "personal",
                    path = "/mnt/PS/Notes",
                    overrides = {
                        daily_notes = {
                            folder = "Personal/Daily Notes",
                            date_format = "%Y-%m-%d",
                            default_tags = { "daily-note" },
                        },
                    },
                },
                {
                    name = "website",
                    path = "/mnt/PS/Github/website/content",
                    overrides = {
                        daily_notes = {
                            folder = "notes",
                            date_format = "%Y-%m-%d",
                            default_tags = { "post" },
                        },
                    },
                },
            },

            daily_notes = {
                folder = "Personal/Daily Notes",
                date_format = "%Y-%m-%d",
                default_tags = { "daily-note" },
            },

            note_id_func = function(title)
                local suffix = ""
                if title ~= nil then
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return suffix
            end,

            preferred_link_style = "wiki",

            completion = {
                nvim_cmp = true,
                min_chars = 2,
            },

            -- Set to false so render-markdown handles styling cleanly
            ui = {
                enable = false,
            },

            attachments = {
                img_folder = "assets/images",
            },

            mappings = {
                ["<cr>"] = {
                    action = function()
                        return require("obsidian").util.smart_action()
                    end,
                    opts = { expr = true, buffer = true },
                },
                ["<leader>od"] = {
                    action = "<cmd>Obsidian today<cr>",
                    opts = { buffer = true, desc = "Obsidian: Today's Note" },
                },
                ["<leader>os"] = {
                    action = "<cmd>Obsidian quick_switch<cr>",
                    opts = { buffer = true, desc = "Obsidian: Quick Switch" },
                },
                ["<leader>og"] = {
                    action = "<cmd>Obsidian search<cr>",
                    opts = { buffer = true, desc = "Obsidian: Search Vault" },
                },
                ["<leader>op"] = {
                    action = "<cmd>Obsidian paste_img<cr>",
                    opts = { buffer = true, desc = "Obsidian: Paste Clipboard Image" },
                },
                ["<leader>ow"] = {
                    action = "<cmd>Obsidian workspace<cr>",
                    opts = { buffer = true, desc = "Obsidian: Switch Workspace" },
                },
            },
        },
    },

    ---------------------------------------------------------------------------
    -- 2. RENDER-MARKDOWN.NVIM (Callouts, Tables, Formatting)
    ---------------------------------------------------------------------------
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
        ft = { "markdown" },
        opts = {
            heading = {
                enabled = true,
                sign = true,
                icons = { ">>>>>>>>>>  ", ">>>>> ", ">>> ", ">> ", "> ", "󰲫 " },
            },
            code = {
                enabled = true,
                sign = false,
                style = "full",
                width = "block",
            },
            checkbox = {
                enabled = true,
            },
            callout = {
                note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
                tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
                warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
                danger = { raw = "[!DANGER]", rendered = "󰳦 Danger", highlight = "RenderMarkdownError" },
            },
        },
    },

    ---------------------------------------------------------------------------
    -- 3. SNACKS.NVIM (Kitty Inline Image Previews - Zero LuaRocks Required)
    ---------------------------------------------------------------------------
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            image = {
                enabled = true,
                doc = {
                    inline = true, -- Displays the image inline right inside the markdown buffer
                    float = true,  -- Displays hover preview when the cursor sits on the image path
                    max_width = 80,
                    max_height = 20,
                },
            },
        },
    },
}
