return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',

    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        'neovim/nvim-lspconfig',

        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',

        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',

        'onsails/lspkind.nvim',
    },

    config = function()
        local lsp_zero = require('lsp-zero')
        local cmp = require('cmp')

        require('mason').setup()

        lsp_zero.extend_lspconfig({
            sign_text = true,

            lsp_attach = function(client, bufnr)
                lsp_zero.default_keymaps({
                    buffer = bufnr,
                })

                vim.keymap.set(
                    'n',
                    ']d',
                    vim.diagnostic.goto_next,
                    { buffer = bufnr }
                )

                vim.keymap.set(
                    'n',
                    '[d',
                    vim.diagnostic.goto_prev,
                    { buffer = bufnr }
                )

                vim.keymap.set(
                    'n',
                    '<leader>lf',
                    vim.lsp.buf.format,
                    { buffer = bufnr }
                )

                client.server_capabilities.documentFormattingProvider = true
            end,

            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })

        require('mason-lspconfig').setup({
            ensure_installed = {
                'ts_ls',
                'lua_ls',
            },

            handlers = {
                lsp_zero.default_setup,

                lua_ls = function()
                    require('lspconfig').lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { 'vim' },
                                },
                            },
                        },
                    })
                end,

                ts_ls = function()
                    require('lspconfig').ts_ls.setup({
                        single_file_support = false,

                        settings = {
                            javascript = {
                                suggest = {
                                    completeFunctionCalls = true,
                                },
                            },

                            typescript = {
                                suggest = {
                                    completeFunctionCalls = true,
                                },
                            },
                        },

                        flags = {
                            debounce_text_changes = 150,
                        },
                    })
                end,
            },
        })

        require('luasnip.loaders.from_vscode').lazy_load()

        vim.diagnostic.config({
            virtual_text = {
                prefix = '●',
            },

            signs = true,
            underline = true,
            update_in_insert = false,
        })

        local cmp_action = lsp_zero.cmp_action()

        cmp.setup({
            formatting = {
                fields = { 'abbr', 'kind', 'menu' },

                format = require('lspkind').cmp_format({
                    mode = 'symbol',
                    maxwidth = 50,
                    ellipsis_char = '...',
                }),
            },

            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },

            sources = {
                { name = 'nvim_lsp' },

                { name = 'luasnip' },

                { name = 'path' },

                {
                    name = 'buffer',
                    option = {
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end,
                    },
                },
            },

            mapping = {
                ['<C-Space>'] = cmp.mapping.complete(),

                ['<Tab>'] = cmp_action.tab_complete(),

                ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),

                ['<CR>'] = cmp.mapping.confirm({
                    select = true,
                }),

                ['<C-e>'] = cmp.mapping.abort(),

                ['<Up>'] = cmp.mapping.select_prev_item({
                    behavior = cmp.SelectBehavior.Select,
                }),

                ['<Down>'] = cmp.mapping.select_next_item({
                    behavior = cmp.SelectBehavior.Select,
                }),
            },
        })

        vim.api.nvim_create_autocmd('BufWritePre', {
            callback = function()
                vim.lsp.buf.format({
                    async = false,
                })
            end,
        })
    end,
}
