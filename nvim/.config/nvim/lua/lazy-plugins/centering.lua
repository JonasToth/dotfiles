return {
    {
        "shortcuts/no-neck-pain.nvim",
        version = "*",
        cmd = "NoNeckPain",
        modules = "no-neck-pain",
        opts = {
            width = 110,
            buffers = {
                colors = { blend = -1, },
                right = {
                    enabled = false
                },
                left = {
                    enabled = true,
                },
            },
            integrations = {
                NeoTree = {
                    position = "right",
                    -- When `true`, if the tree was opened before enabling the plugin, we will reopen it.
                    reopen = true,
                },
            },
        },
        keys = {
            { "<leader>bc", ":NoNeckPain<CR>", desc = "Center current buffer" },
        }
    },
}
