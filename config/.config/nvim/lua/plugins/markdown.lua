return {
    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        build = "cd app && npm install",
        config = function()
            vim.g.mkdp_browser = "markdownBrowser" -- change to preferred browser here
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_open_to_the_world = 0
            vim.g.mkdp_theme = "dark"
        end,
    },
}
