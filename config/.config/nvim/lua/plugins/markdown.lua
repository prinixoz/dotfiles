return {
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        config = function()
            vim.opt_local.conceallevel = 2
            require("obsidian").setup({
                workspaces = {
                    {
                        name = "work",
                        path = "/mnt/PS/Notes/",
                    },
                },
                ui = {
                    enable = false
                },
            })
        end,


        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        config = function()
        end,
        ft = { "markdown" },
    },

}
