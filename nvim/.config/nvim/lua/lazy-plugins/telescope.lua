return {
	{
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-smart-history.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "kkharji/sqlite.lua",
        "BurntSushi/ripgrep",
        "sharkdp/fd",
        { "junegunn/fzf", { dir = "~/.fzf", build = "./install --all" } },
        "junegunn/fzf.vim",
        "nvim-telescope/telescope-dap.nvim",
    },
    event = "VeryLazy",
    keys = {
        { "<leader>pf", function() require("telescope.builtin").find_files() end,                desc = "Project Files" },
        { "<leader>ph", function() require("telescope.builtin").help_tags() end,                 desc = "Nvim Help Tags" },
        { "<leader>pg", function() require("telescope.builtin").git_files() end,                 desc = "Project Git Files" },
        { "<leader>bg", function() require("telescope.builtin").git_bcommits() end,              desc = "Buffer Git Commits" },
        { "<leader>pd", function() require("telescope.builtin").diagnostics() end,               desc = "Project Diagnostics" },
        { "<leader>ps", function() require("telescope.builtin").live_grep() end,                 desc = "Project Search" },
        { "<leader>gb", function() require("telescope.builtin").git_branches() end,              desc = "Git Branches" },
        { "<leader>bm", function() require("telescope.builtin").marks() end,                     desc = "Buffer Marks" },
        { "<leader>bl", function() require("telescope.builtin").buffers() end,                   desc = "Buffers" },
        { "<space>/",   function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Buffer Fuzzy Find" },
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                layout_strategy = 'vertical',
                layout_config = {
                    vertical = {
                        width = 0.9,
                        height = 0.95,
                        prompt_position = 'bottom',
                        preview_cutoff = 0,
                    },
                },
            },
            extensions = {
                -- ["ui-select"] = { require("telescope.themes").get_dropdown {} }
            },
            pickers = {
                buffers = {
                    ignore_current_buffer = true,
                    sort_lastused = true,
                },
            },
        })
        -- telescope.load_extension("ui-select")
        telescope.load_extension('dap')

        -- Show line numbers in file preview
        vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
		end,
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		-- install the latest stable version
		version = "*",
        event = "VeryLazy",
		config = function()
			require("telescope").load_extension("frecency")
		end,
	},
}
