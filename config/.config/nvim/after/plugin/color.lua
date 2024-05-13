vim.opt.background = "dark"
require("tokyonight").setup({
    transparent = true,
    terminal_colors = true,
     styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "transparent", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
})

-- Load the colorscheme
vim.cmd[[colorscheme tokyonight]]

