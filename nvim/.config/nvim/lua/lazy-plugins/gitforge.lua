local ia = "gitforge.issue_actions"
return {
    {
        enabled = function() return vim.fn.isdirectory("~/software/nvim") end,
        dir = "~/software/nvim/gitforge.nvim",
        dev = true,
        opts = {
            timeout = 2000,
            issue_keys = {
                description = "d",
            },
        },
        cmd = { "GForgeListIssues", "GForgeCachedIssues", "GForgeCreateIssue" },
        keys = {
            { "<leader>gn", "<cmd>GForgeCreateIssue<CR>",  desc = "Create a new issue" },
            { "<leader>gg", "<cmd>GForgeOpenedIssues<CR>", desc = "List opened issue" },
            { "<leader>gh", "<cmd>GForgeListIssues<CR>", desc = "List all issue" },
            {
                "<leader>gio", function() require(ia).list_issues({ state = "open", limit = 100, }) end,
                desc = "List All Open Issues"
            },
            {
                "<leader>giB", function() require(ia).list_issues({ state = "open", labels = "bug", limit = 100, }) end,
                desc = "List All Open Bugs"
            },
            {
                "<leader>gim", function() require(ia).list_issues({ state = "open", assignee = "@me", }) end,
                desc = "List My Issues"
            },
            {
                "<leader>gib", function() require(ia).list_issues({ state = "open", assignee = "@me", labels = "bug", }) end,
                desc = "List My Bugs"
            },
        }
    },
}
