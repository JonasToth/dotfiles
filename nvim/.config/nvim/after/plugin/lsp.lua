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
require("clangd_extensions").setup({})

local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "luasnip" },
    },
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-z>"] = cmp.mapping(
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

cmp.setup.filetype(
    { "sql" }, {
        sources = {
            { name = "vim-dadbod-completion" },
            { name = "buffer" },
        },
    })
luasnip.config.set_config({
    history = false,
    updateevents = "TextChanged,TextChangedI",
})
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true })

lsp_zero.set_preferences({
    sign_icons = {}
});
lsp_zero.on_attach(function(client, bufnr)
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
    if client.server_capabilities.signatureHelpProvider then
        require('lsp-overloads').setup(client, {})
        vim.keymap.set("n", "<A-s>", ":LspOverloadsSignature<CR>", opts)
        vim.keymap.set("i", "<A-s>", "<cmd>LspOverloadsSignature<CR>", opts)
    end
end)
