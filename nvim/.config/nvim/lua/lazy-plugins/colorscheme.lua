return {
    -- {
    --     "sainnhe/sonokai",
    --     priority = 1000,
    --     lazy = false,
    --     config = function()
    --         vim.g.sonokai_enable_italic = true
    --         vim.g.sonokai_better_performance = false
    --         -- require('sonokai').setup({})
    --         vim.cmd("colorscheme sonokai")
    --     end,
    -- },
    {
        "dgox16/oldworld.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("oldworld").setup({
                integrations = { -- You can disable/enable integrations
                    alpha = true,
                    cmp = true,
                    flash = true,
                    gitsigns = true,
                    hop = true,
                    indent_blankline = true,
                    lazy = true,
                    lsp = true,
                    markdown = true,
                    mason = true,
                    navic = false,
                    neo_tree = true,
                    neogit = true,
                    neorg = true,
                    noice = false,
                    notify = true,
                    rainbow_delimiters = true,
                    telescope = true,
                    treesitter = true,
                },
            })
            vim.cmd("colorscheme oldworld")
        end,
    },
    -- {
    --     "vague2k/vague.nvim",
    --     config = function()
    --         -- NOTE: you do not need to call setup if you don't want to.
    --         require("vague").setup({
    --             -- optional configuration here
    --         })
    --         vim.cmd("colorscheme vague")
    --     end
    -- },
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
    {
    },
}
