return {
    {
        "tpope/vim-dadbod",
        cmd = "DB",
        dependencies = {
            "kristijanhusak/vim-dadbod-ui",
            "kristijanhusak/vim-dadbod-completion",
        },
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dbout",
                callback = function()
                    vim.wo.foldenable = false
                end,
            })

            require("cmp").setup.filetype(
                { "sql" }, {
                    sources = {
                        { name = "vim-dadbod-completion" },
                        { name = "buffer" },
                    },
                })
        end,
    },
}
