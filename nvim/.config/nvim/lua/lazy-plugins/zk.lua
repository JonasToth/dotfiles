return {
    "zk-org/zk-nvim",
    enabled = true,
    events = "VeryLazy",
    config = function()
        require("zk").setup({
            -- can be "telescope", "fzf", "fzf_lua", "minipick", or "select" (`vim.ui.select`)
            -- it's recommended to use "telescope", "fzf", "fzf_lua", or "minipick"
            picker = "telescope",
            lsp = {
                -- `config` is passed to `vim.lsp.start_client(config)`
                config = {
                    cmd = { "zk", "lsp" },
                    name = "zk",
                },

                -- automatically attach buffers in a zk notebook that match the given filetypes
                auto_attach = {
                    enabled = true,
                    filetypes = { "markdown" },
                },
            },
        })
        vim.keymap.set("n", "<leader>zn",
            function()
                vim.ui.input({}, function(input)
                    if input == nil or #input == 0 then
                        return
                    end
                    require("zk").new({ title = input })
                end)
            end, { desc = "Create a new Zettelkasten Note" })
        vim.keymap.set("n", "<leader>zt", "<cmd>ZkTags<cr>", { desc = "Show Tag of Zettelkasten" })
        vim.keymap.set("n", "<leader>zl", "<cmd>ZkNotes<cr>", { desc = "Show Notes-Picker of Zettelkasten" })
    end,
}
