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
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = { theme = 'codedark' }
    },
    {
        -- Better UI Experience.
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },
    {
        -- Surrounding Text with delimiters.
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        -- Improved UI-input widget.
        "folke/snacks.nvim",
        event = "VeryLazy",
        ---@type snacks.Config
        opts = {
            input = {
                backdrop = false,
                position = "float",
                border = "rounded",
                title_pos = "center",
                height = 1,
                width = 60,
                relative = "editor",
                noautocmd = true,
                row = 2,
                -- relative = "cursor",
                -- row = -3,
                -- col = 0,
                wo = {
                    winhighlight =
                    "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
                    cursorline = false,
                },
                bo = {
                    filetype = "snacks_input",
                    buftype = "prompt",
                },
                --- buffer local variables
                b = {
                    completion = false, -- disable blink completions in input
                },
                keys = {
                    n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n" },
                    i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i" },
                    i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = "i" },
                    i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i" },
                    q = "cancel",
                },
            }
        }
    }
}
