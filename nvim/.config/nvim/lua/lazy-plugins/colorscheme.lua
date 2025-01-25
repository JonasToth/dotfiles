return {
    {
        "sainnhe/sonokai",
        priority = 1000,
        lazy = false,
        config = function()
            vim.g.sonokai_enable_italic = true
            vim.g.sonokai_better_performance = false
            -- require('sonokai').setup({})
            vim.cmd("colorscheme sonokai")
        end,
    },
    {
        -- Dimming inactive parts of the code to get higher focus.
        "folke/twilight.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            dimming = { alpha = 0.5 },
            context = 15,
            expand = {
                "function",
                "method",
                "table",
            },
        },
        keys = {
            { "<leader>bt", ":Twilight<CR>", desc = "Highlight only Context" },
        },
    },
    {
        -- Highlight Parentheses in different colors to disambiguate them.
        "hiphish/rainbow-delimiters.nvim",
        event = "BufEnter",
        config = function()
            local rainbow_delimiters = require("rainbow-delimiters")
            require("rainbow-delimiters.setup").setup({
                strategy = {
                    [""] = rainbow_delimiters.strategy["global"],
                    vim = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                priority = {
                    [""] = 110,
                    lua = 210,
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            })
        end,
    },
    {
        -- Current line changes color for modes and modifiers.
        "rasulomaroff/reactive.nvim",
        event = "VeryLazy",
        opts = {
            builtin = {
                cursorline = true,
                cursor = false,
                modemsg = false,
            },
        },
    },
}
