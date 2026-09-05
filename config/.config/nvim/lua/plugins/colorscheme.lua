return {
    {
        "vague-theme/vague.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("vague").setup()
            vim.cmd("colorscheme vague")
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
            vim.api.nvim_set_hl(0, "EndOfBuffer", { ctermbg = "none", bg = "none" })
            vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
            vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
            vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
            vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
            vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
        end
    },
    {
        "sphamba/smear-cursor.nvim",
        opts = {},
    }
}
