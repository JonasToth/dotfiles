return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        keys = {
            { "<leader>g", function() require("harpoon").list():add() end,                                    desc = "Add File to Harpoon" },
            { "<leader>u", function() require("harpoon").ui:toggle_quick_menu(require("harpoon").list()) end, desc = "Harpoon Quickmenu" },

            { "<leader>4", function() require("harpoon").list().select(1) end,                                desc = "Select File 1" },
            { "<leader>5", function() require("harpoon").list().select(2) end,                                desc = "Select File 2" },
            { "<leader>6", function() require("harpoon").list().select(3) end,                                desc = "Select File 3" },
            { "<leader>7", function() require("harpoon").list().select(4) end,                                desc = "Select File 4" },

            -- Toggle previous & next buffers stored within Harpoon list
            { "<leader>e", function() require("harpoon").list():prev() end,                                   desc = "Prev Harpoon" },
            { "<leader>r", function() require("harpoon").list():next() end,                                   desc = "Next Harpoon" },
        },
    },
    {
        "smoka7/hop.nvim",
        keys = {
            { "<leader>h", "<cmd>HopChar1<CR>", mode = { "n", "v" }, desc = "Jump 1 Char" },
            { "<leader>H", "<cmd>HopChar2<CR>", mode = { "n", "v" }, desc = "Jump 2 Char" },
            { "<leader>w", "<cmd>HopWord<CR>",  mode = { "n", "v" }, desc = "Jump Word" },
        },
        opts = {
            keys = 'etovxqpdygfblzhckisuran'
        },
    },
    {
        "itchyny/vim-qfedit",
        event = "VeryLazy",
    }
}
