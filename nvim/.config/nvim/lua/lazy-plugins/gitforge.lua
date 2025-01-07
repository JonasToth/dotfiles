return {
    enabled = function() vim.fn.isdirectory("~/software/nvim") end,
    dir = "~/software/nvim/gitforge.nvim",
    dev = true,
    event = "VeryLazy",
    opts = {
        timeout = 2000
    },
}
