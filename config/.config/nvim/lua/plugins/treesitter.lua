return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "OXY2DEV/markview.nvim" },
    lazy = false,
    opts = {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
        highlight = { enable = true },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
        vim.opt_local.conceallevel = 2
    end,
}
