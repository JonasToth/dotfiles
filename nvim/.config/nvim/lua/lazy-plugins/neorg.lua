local work_space_path
if vim.uv.os_uname().sysname == "Linux" then
    work_space_path = vim.fn.expand("~/Dokumente/neorg")
else
    work_space_path = "C:/Users/jto/OneDrive - IVU Traffic Technologies AG/Dokumente/norg"
end
return {
    "nvim-neorg/neorg",
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true, }
    },
    cmd = "Neorg",
    keys = {
        { "<leader>N",   ":Neorg<CR>",                    desc = "Open Neorg Menu" },
        { "<leader>ni",  ":Neorg index<CR>",              desc = "Open Index" },
        { "<leader>nl",  ":Neorg toc<CR>",                desc = "Open Table of Contents" },
        { "<leader>njl", ":Neorg journal toc<CR>",        desc = "Open Journal Table Of Contents" },
        { "<leader>njt", ":Neorg journal today<CR>",      desc = "Open Today Journal" },
        { "<leader>njc", ":Neorg journal custom<CR>",     desc = "Open Custom Journal" },
        { "<leader>njf", ":Neorg journal tomorrow<CR>",   desc = "Open Tomorrow's Journal" },
        { "<leader>njy", ":Neorg journal yesterday<CR>",  desc = "Open Yesterday's Journal" },
        { "<leader>nn",  "<Plug>(neorg.dirman.new-note)", desc = "Create a New Note" },
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
                ["core.esupports.metagen"] = {
                    config = {
                        author = "Jonas Toth",
                        type = "auto",
                    }
                },
                ["core.ui.calendar"] = {},
                ["core.journal"] = {},
                ["core.keybinds"] = {
                    config = {
                        default_keybinds = true,
                    }
                }
            },
        })
        vim.wo.foldlevel = 99
        vim.wo.conceallevel = 2
    end,
}
