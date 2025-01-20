local ia = "gitforge.issue_actions"
return {
    {
        enabled = function() return vim.fn.isdirectory("~/software/nvim") end,
        dir = "~/software/nvim/gitforge.nvim",
        dev = true,
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
            { "pysan3/pathlib.nvim" },
        },
        cmd = { "GForgeViewIssue", "GForgeListIssues", "GForgeOpenedIssues", "GForgePinnedIssues", "GForgeCreateIssue" },
        keys = {
            { "<leader>gv",  "<cmd>GForgeViewIssue<CR>",    desc = "View an issue" },
            { "<leader>gn",  "<cmd>GForgeCreateIssue<CR>",  desc = "Create a new issue" },
            { "<leader>ggo", "<cmd>GForgeOpenedIssues<CR>", desc = "List opened issues" },
            { "<leader>gh",  "<cmd>GForgeListIssues<CR>",   desc = "List all issues" },
            { "<leader>ggp", "<cmd>GForgePinnedIssues<CR>", desc = "List pinned issues" },
            {
                "<leader>gio",
                function() require(ia).list_issues({ state = "open", limit = 100, }) end,
                desc = "List All Open Issues"
            },
            {
                "<leader>giB",
                function() require(ia).list_issues({ state = "open", labels = "bug", limit = 100, }) end,
                desc = "List All Open Bugs"
            },
            {
                "<leader>gim",
                function() require(ia).list_issues({ state = "open", assignee = "@me", }) end,
                desc = "List My Issues"
            },
            {
                "<leader>gib",
                function() require(ia).list_issues({ state = "open", assignee = "@me", labels = "bug", }) end,
                desc = "List My Bugs"
            },
        },
        opts = {
            timeout = 3000,
            list_max_title_length = 90,
            projects = {
                { path = "~/software/drone-observer",     issue_provider = "glab", project = "gitlab.lan/basedness/drone-observer" },
                { path = "~/software/glab",               issue_provider = "glab", project = "gitlab.com/gitlab-org/cli" },
                { path = "~/software/nvim/gitforge.nvim", issue_provider = "gh" },
                { path = "~/software/llvm-project",       issue_provider = "gh",   project = "github.com/JonasToth/llvm-project" },
            },
            default_issue_provider = "gh",
        },
    },
}
