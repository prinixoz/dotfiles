-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim' 
    use 'sbdchd/neoformat'
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} } }
    use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
    use 'ThePrimeagen/vim-be-good'
    use { "williamboman/mason.nvim" }
    use {'iamcco/markdown-preview.nvim'}
end)

