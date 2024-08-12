return {
    "nvim-neorg/neorg",
    version = "*", -- Pin Neorg to the latest stable release
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    cmd = "Neorg",
    keys = {
        { "<leader>N", ":Neorg<CR>", desc = "Open Neorg Menu" },
    },
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            work = "C:/Users/jto/OneDrive - IVU Traffic Technologies AG/Dokumente/norg",
                        },
                        default_workspace = "work",
                        index = "index.norg",
                    },
                },
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },
            },
        })
    end,
}
