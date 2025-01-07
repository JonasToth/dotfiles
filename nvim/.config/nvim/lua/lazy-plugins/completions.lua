return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                    { name = "neorg" },
                },
                mapping = {
                    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-h>"] = cmp.mapping(
                        cmp.mapping.confirm {
                            behavior = cmp.ConfirmBehavior.Insert,
                            select = true,
                        },
                        { "i", "c" }),
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noselect", },
            })
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        build = "make install_jsregexp",
        enabled = function() return not vim.loop.os_uname().sysname == "Windows_NT" end,
        config = function()
            local luasnip = require("luasnip")
            luasnip.config.set_config({
                history = false,
                updateevents = "TextChanged,TextChangedI",
            })

            vim.keymap.set({ "i", "s" },
                "<C-j>",
                function()
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end,
                { silent = true, })
            vim.keymap.set({ "i", "s" },
                "<C-k>",
                function()
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end,
                { silent = true })
        end,
    },
}
