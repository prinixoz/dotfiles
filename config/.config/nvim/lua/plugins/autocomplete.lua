return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',

    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        'neovim/nvim-lspconfig',

        -- Completion
        {
            'saghen/blink.cmp',
            version = '1.*',

            dependencies = {
                'rafamadriz/friendly-snippets',
            },

            opts = {
                keymap = {
                    preset = 'none',

                    ['<Tab>'] = {
                        'select_next',
                        'fallback',
                    },

                    ['<S-Tab>'] = {
                        'select_prev',
                        'fallback',
                    },

                    ['<CR>'] = {
                        'accept',
                        'fallback',
                    },

                    ['<C-Space>'] = {
                        'show',
                        'show_documentation',
                        'hide_documentation',
                    },

                    ['<C-e>'] = {
                        'hide',
                        'fallback',
                    },
                },

                appearance = {
                    nerd_font_variant = 'mono',
                },

                completion = {
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 500,
                    },

                    list = {
                        selection = {
                            preselect = true,
                            auto_insert = true,
                        },
                    },
                },

                sources = {
                    default = {
                        'lsp',
                        'path',
                        'snippets',
                        'buffer',
                    },
                },

                fuzzy = {
                    implementation = 'prefer_rust_with_warning',
                },
            },
        }

    },

    config = function()
        local lsp_zero = require('lsp-zero')

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
        })

        require('mason-lspconfig').setup({
            ensure_installed = {
                'lua_ls',
                'ts_ls',
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

        vim.diagnostic.config({
            virtual_text = {
                prefix = '●',
            },

            signs = true,
            underline = true,
            update_in_insert = false,
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
