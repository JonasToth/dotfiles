return {
    {
        -- Sane defaults for LSP configuration and management of language servers.
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        lazy = true,
        config = false,
    },
    {
        "williamboman/mason.nvim", cmd = "Mason", lazy = true,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        opts = {
            ensure_installed = { "clangd", "lua_ls", "neocmake", "pylsp", },
        }
    },
    {
        "neovim/nvim-lspconfig",
        cmd = 'LspInfo',
        event = "VeryLazy",
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig")
            local lsp_zero = require("lsp-zero")
            local lsp_attach = function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                local opts = { buffer = bufnr, remap = false }
                local builtin = require("telescope.builtin")

                vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)
                vim.keymap.set("n", "<leader>le", function() vim.lsp.buf.code_action({ apply = true }) end, opts)
                vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, opts)
                vim.keymap.set("n", "<leader>li", builtin.lsp_implementations, opts)
                vim.keymap.set("n", "<leader>lt", builtin.lsp_type_definitions, opts)
                vim.keymap.set("n", "<leader>ls", function() vim.cmd.ClangdSwitchSourceHeader() end, opts)
                vim.keymap.set("n", "<leader>lx", builtin.lsp_references, opts)
                vim.keymap.set("n", "<leader>lo", builtin.lsp_outgoing_calls, opts)
                vim.keymap.set("n", "<leader>lc", builtin.lsp_incoming_calls, opts)
                vim.keymap.set("n", "<leader>lp", "<cmd>Neotree source=document_symbols position=right<CR>", opts)

                vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.document_highlight() end, opts)
                vim.keymap.set("n", "<leader>lg", function() vim.lsp.buf.clear_references() end, opts)

                vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.hover() end, opts)

                -- Configure signature help when multiple overloads are present.
                -- Guard against servers without the signatureHelper capability
                --[[
                if client.server_capabilities and client.server_capabilities.signatureHelpProvider then
                    require("lsp-overloads").setup({
                        display_automatically = false,
                    })
                    vim.keymap.set("n", "<A-s>", "<cmd>LspOverloadsSignature<CR>",
                        { noremap = true, silent = true, buffer = bufnr })
                    vim.keymap.set("i", "<A-s>", "<cmd>LspOverloadsSignature<CR>",
                        { noremap = true, silent = true, buffer = bufnr })
                end
                --]]
            end

            lsp_zero.extend_lspconfig({
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                lsp_attach = lsp_attach,
                float_borders = "rounded",
                sign_text = true,
            })


            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {
                                'vim',
                                'require'
                            },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    }
                }
            }
            lspconfig.clangd.setup {}
            lspconfig.neocmake.setup {}
            lspconfig.pylsp.setup {}
        end,
    },
    {
        "Issafalcon/lsp-overloads.nvim",
        lazy = true,
    },
    {
        "p00f/clangd_extensions.nvim",
        cmd = { "ClangdSwitchSourceHeader" },
    },
}
