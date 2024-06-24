return {
    'VonHeikemen/lsp-zero.nvim', branch = 'v3.x',
    dependencies ={
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/nvim-cmp',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        "onsails/lspkind.nvim", -- adds vscode-like pictograms to neovim built-in lsp
        "rafamadriz/friendly-snippets",
    },

    config = function()
        local lsp_zero = require('lsp-zero')
        require('luasnip.loaders.from_vscode').lazy_load()
        vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)

        lsp_zero.on_attach(function(client, bufnr)
            lsp_zero.default_keymaps({buffer = bufnr})
        end)
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {},
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
            },
        })

        local cmp = require('cmp')
        local cmp_action = require('lsp-zero').cmp_action()

        cmp.setup({
            formatting = {
                fields = {'abbr', 'kind', 'menu'},
                format = require('lspkind').cmp_format({
                    mode = 'symbol', -- show only symbol annotations
                    maxwidth = 50, -- prevent the popup from showing more than provided characters
                    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
                })
            },
            sources = {
                {name = 'luasnip'},
                {name = 'path'},
                { name = 'buffer' },
                {name = 'nvim_lsp'},
            },

            mapping = {
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<Tab>'] = cmp_action.tab_complete(),
                ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
                ['<CR>'] = cmp.mapping.confirm({select = true}),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
                ['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
        })

    end
}
