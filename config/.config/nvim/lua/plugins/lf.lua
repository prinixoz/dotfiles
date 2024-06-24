return {
    "lmburns/lf.nvim",
    dependencies = {"akinsho/toggleterm.nvim"},
    config = function()
        -- This feature will not work if the plugin is lazy-loaded
        vim.g.lf_netrw = 1

        require("lf").setup({
            escape_quit = false,
            border = "rounded",
            default_file_manager = true, -- make lf default file manager
            disable_netrw_warning = true, -- don't display a message when opening a directory with `default_file_manager` as true
            mappings = false, -- whether terminal buffer mapping is enabled
            winblend = 0, -- psuedotransparency level
            default_file_manager = false, -- make lf default file manager
            disable_netrw_warning = true, -- don't display a message when opening a directory with `default_file_manager` as true
        })

        vim.keymap.set("n", "<C-e>", "<Cmd>Lf<CR>")
    end
}
