return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        keys = {
            { "<leader>pv", "<cmd>Neotree position=current<CR>",                             desc = "Explorer" },
            { "<leader>pt", "<cmd>Neotree source=filesystem reveal=true position=right<CR>", desc = "FS Tree" },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {
            sources = { "filesystem", "document_symbols" },
            -- netrw disabled, opening a directory opens neo-tree
            -- whatever position is specified in window.position
            hijack_netrw_behavior = "open_default",
            window = {
                position = "right",
                width = 60,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ["<space>"] = {
                        "toggle_node",
                        nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use
                    },
                },
            }
        }
    },
}
