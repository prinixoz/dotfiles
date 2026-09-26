return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    keys = {
        { "<leader>o", "<cmd>Obsidian<CR>", desc = "Open Obsidian Menu" },
    },
    ft = "markdown",
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
        legacy_commands = false,
        workspaces = {
            {
                name = "personal",
                path = "/mnt/PS/Notes/",
            },
            {
                name = "website",
                path = "/mnt/PS/Github/website/content/",
            },
        },
        daily_notes = {
            enabled = true,
            folder = "Personal/Daily Notes",
            date_format = "YYYY-MM-DD",
            default_tags = { "daily-note" },
        },
        ui = {
            enable = true, -- Enables Obsidian UI features
        },
    },
    config = function(_, opts)
        require("obsidian").setup(opts)

        -- Fixes the warning by setting conceal level for markdown files
        vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
            pattern = "/mnt/PS/Notes/*.md",
            callback = function()
                vim.opt_local.conceallevel = 1 -- Hides markdown syntax clutter (like bold/italic markers)
                vim.opt_local.wrap = true
                vim.opt_local.linebreak = true
                vim.opt_local.breakat = " "
                vim.opt_local.spell = true
            end,
        })
    end,
}
