return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
        vim.cmd.colorscheme "gruvbox"
        vim.opt.background = "dark"

        vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none", bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { ctermbg = "none", bg = "none" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { ctermbg = "none", bg = "none" })
        vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    end,
    opts = ...
}
