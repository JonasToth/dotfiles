local lsp_zero = require("lsp-zero")

lsp_zero.preset("recommend")

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "lua_ls", "neocmake", "pylsp", },
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({ capabilities = capabilities })
        end,
    }
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select, select = true, }
local luasnip = require("luasnip")
cmp.setup({
    sources = { { name = "nvim_lsp" }, { name = 'luasnip' }, { name = "vim-dadbod-completion" } },
    mapping = {
        ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if luasnip.expandable() then
                    luasnip.expand()
                else
                    cmp.confirm(cmp_select)
                end
            else
                fallback()
            end
        end),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = "menu,menuone,noselect",
    },
    filetype = {
        "sql"
    }
})

lsp_zero.set_preferences({
    sign_icons = {}
});
lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "<leader>le", function() vim.lsp.buf.code_action({ apply = true }) end, opts)
    vim.keymap.set("n", "<leader>ld", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>li", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "<leader>lt", function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set("n", "<leader>ls", function() vim.cmd.ClangdSwitchSourceHeader() end, opts)
    vim.keymap.set("n", "<leader>lx", function() vim.lsp.buf.references() end, opts)

    vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.document_highlight() end, opts)
    vim.keymap.set("n", "<leader>lg", function() vim.lsp.buf.clear_references() end, opts)

    vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>lc", function() vim.lsp.buf.incoming_calls() end, opts)

    -- Configure signature help when multiple overloads are present.
    -- Guard against servers without the signatureHelper capability
    if client.server_capabilities.signatureHelpProvider then
        require('lsp-overloads').setup(client, {})
        vim.keymap.set("n", "<A-s>", ":LspOverloadsSignature<CR>", opts)
        vim.keymap.set("i", "<A-s>", "<cmd>LspOverloadsSignature<CR>", opts)
    end
end)
