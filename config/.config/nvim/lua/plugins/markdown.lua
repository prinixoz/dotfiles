return {
    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        build = "cd app && npm install",
        config = function()
            vim.g.mkdp_browser = "librewolf-default" -- change to preferred browser here
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_open_to_the_world = 0
            vim.g.mkdp_theme = "dark"
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        opts = {},
        config = function()
            require('render-markdown').setup({
                completions = { lsp = { enabled = true } },
            })
        end,
    },
}
