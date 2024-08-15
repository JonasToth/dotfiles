return {
    {
        "kristijanhusak/vim-dadbod-ui",
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        },
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dbout",
                callback = function()
                    vim.wo.foldenable = false
                end,
            })
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_win_position = "right"
            vim.g.db_ui_winwidth = 50
            vim.g.db_ui_save_position = vim.fn.stdpath('data') .. "/dbui"

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
