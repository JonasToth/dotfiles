return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            render_modes = true,
            anti_conceal = { enabled = false },
        },
        ft = {"md", "markdown"},
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "echasnovski/mini.nvim"
        },
    },
}
