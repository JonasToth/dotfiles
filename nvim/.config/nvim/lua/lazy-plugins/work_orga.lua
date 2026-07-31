return {
    {
        "letieu/jira.nvim",
        opts = {
            -- Your setup options...
            jira = {
                limit = 200, -- Global limit of tasks per view (default: 200)
            },
            active_sprint_query = [[
project = "E24 Build"
AND status IN (Blocked, "Documentation passed", "In  Test", "In development", "In Documentation", "In Documentation Review", "In Review", "Ready For Documentation", "Ready For Documentation Review", "Ready for Review", "Ready for test", "Test passed", "Review passed")
AND assignee = currentUser()
]],
        },
        cmd = { "Jira" },
        keys = {
            { "<leader>J", "<cmd>Jira \"E24 Build\"<cr>" },
        },
    },
    {
        "emrearmagan/atlas.nvim",
        dependencies = {
            "sindrets/diffview.nvim", -- optional (PullRequest diff)
        },
        keys = {
            { "<leader>A", "<cmd>AtlasIssues<cr>" },
        },
        opts = {
            max_results = 100,
            fetch_parent_issues = true,
            pulls = {},
            issues = {
                providers = {
                    jira = {
                        base_url = "https://ivutraffic.atlassian.net/",
                        email = vim.env.JIRA_EMAIL,
                        token = vim.env.JIRA_TOKEN,
                        cache_ttl = 300,

                        views = {
                            {
                                name = "My Issues",
                                key = "Mine",
                                jql = [[
project = "E24 Build"
AND status IN (Blocked, "Documentation passed", "In  Test", "In development", "In Documentation", "In Documentation Review", "In Review", "Ready For Documentation", "Ready For Documentation Review", "Ready for Review", "Ready for test", "Test passed", "Review passed")
AND assignee = currentUser()
]]
                            },
                            {
                                name = "Pipeline Refinement",
                                key = "Refine",
                                jql = [[
    project = "E24 Build"
    AND status IN (Open, "In Refinement (as To Do)")
    AND "BUILD: Stream[Radio Buttons]" = "Pipeline Evolution"
    ]]
                            },
                            {
                                name = "Written by Me",
                                key = "Authored",
                                jql = "project = \"E24 Build\" AND creator = currentUser()"
                            }
                        }
                    },
                },
            },
        }
    },
}
