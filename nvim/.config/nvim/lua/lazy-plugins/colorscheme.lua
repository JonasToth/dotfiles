return {
    {
        "sainnhe/gruvbox-material",
        priority = 1000,
        config = function()
            vim.opt.background = "dark"
            vim.g.gruvbox_material_background = "soft"
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_disable_italic_comment = true
            vim.cmd("silent! colorscheme gruvbox-material")
        end,
        -- "NLKNguyen/papercolor-theme"
        -- "dikiaap/minimalist"
        -- "morhetz/gruvbox"
        -- "catppuccin/nvim", { ["as"] = "catppuccin" },
    },
    -- Dimming inactive parts of the code to get higher focus.
    {
        "folke/twilight.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            dimming = { alpha = 0.5, },
            context = 15,
            expand = {
                "function",
                "method",
                "table"
            }
        },
        keys = {
            { "<leader>bt", ":Twilight<CR>", desc = "Highlight only Context" },
        }
    },
}
