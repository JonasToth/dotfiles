return {
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            local presets = require("markview.presets")
            require("markview").setup({
                checkboxes = presets.checkboxes.nerd,
                preview = {
                    filetypes = { "markdown", "typst", },
                    hybrid_mode = false,
                    linewise_hybrid_mode = false,
                },
                markdown = {
                    -- headings = presets.headings.marker,
                    horizontal_rules = presets.arrowed,
                    tables = presets.double,
                },
                experimental = {
                    check_rtp = false,
                }
            })
            require("markview.extras.checkboxes").setup()
        end,
    },
    {
        "OXY2DEV/foldtext.nvim",
        lazy = false
    }
}
