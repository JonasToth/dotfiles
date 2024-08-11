return {
    {
        "folke/todo-comments.nvim",
        event = { "VeryLazy" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        -- Status line at bottom of screen, show buffers in the status line as well.
        "vim-airline/vim-airline",
        dependencies = {
            "vim-airline/vim-airline-themes",
            { "ryanoasis/vim-devicons", lazy = true }
        },
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        config = function()
            require("mini.surround").setup({})
            require('mini.pairs').setup({})
        end,
    },
}
