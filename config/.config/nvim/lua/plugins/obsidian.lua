return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    -- Register commands immediately so they appear even before opening a markdown file:
    cmd = { "Obsidian" },
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

        ui = {
            enable = false,
        },

        attachments = {
            img_folder = "assets/images",
        },

        -- Updated to use space-separated subcommands instead of legacy CamelCase commands:
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
        },
    },
}
