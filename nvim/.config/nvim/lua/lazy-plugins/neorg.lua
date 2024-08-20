local work_space_path
if vim.uv.os_uname().sysname == "Linux" then
    work_space_path = vim.fn.expand("~/Dokumente/neorg")
else
    work_space_path = "C:/Users/jto/OneDrive - IVU Traffic Technologies AG/Dokumente/norg"
end
return {
    "nvim-neorg/neorg",
    version = "*", -- Pin Neorg to the latest stable release
    lazy = false,
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true, }
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
                ["core.summary"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            work = vim.fn.expand("~/Dokumente/neorg"),
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
                ["core.todo-introspector"] = {},
                ["core.esupports.metagen"] = {},
            },
        })
    end,
}
