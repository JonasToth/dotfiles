return {
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>gw", ":Gwrite<CR>", desc = "Stage File" },
        },
    },
    {
        "NeogitOrg/neogit",
        keys = {
            {
                "<leader>gs",
                function()
                    require("neogit").open({ kind = "tab" })
                end,
                desc = "Open Neogit Tab",
            },
            { "<leader>gc", ":Neogit commit<CR>", desc = "Neogit commit" },
            { "<leader>gp", ":Neogit push<CR>",   desc = "Neogit push" },
            { "<leader>gl", ":Neogit pull<CR>",   desc = "Neogit pull" },
        },
        config = function()
            require("neogit").setup({
                graph_style = "ascii",
                commit_editor = { kind = "replace" },
            })
        end,
    },
    {
        "sindrets/diffview.nvim",
        cmd = {"DiffviewOpen", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh", "DiffviewFileHistory", },
        keys = {
            { "<leader>gh", "<cmd>DiffviewFileHistory<CR>",   desc = "FileHistory Diff" },
            { "<leader>gH", "<cmd>DiffviewFileHistory %<CR>", desc = "FileHistory Diff Current File" },
            { "<leader>gd", "<cmd>DiffviewOpen<CR>",          desc = "DiffView Open" },
            { "<leader>gq", "<cmd>DiffviewClose<CR>",         desc = "DiffView Close" },
        },
        opts = {
            view = {
                default = {
                    layout = "diff2_vertical",
                    disable_diagnostics = true,
                },
                merge_tool = {
                    layout = "diff3_mixed",
                    disable_diagnostics = false,
                },
            },
            file_panel = {
                win_config = {
                    position = "left",
                    width = 60,
                },
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        keys = {
            { "]c", function() require("gitsigns").nav_hunk("next") end,      desc = "Jump to next git hunk" },
            { "[c", function() require("gitsigns").nav_hunk("prev") end,  desc = "Jump to previous git hunk" },
        },
        config = function()
            require("gitsigns").setup()
        end,
    },
}
