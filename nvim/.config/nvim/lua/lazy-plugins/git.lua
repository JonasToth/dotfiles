return {
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gw", ":Gwrite<CR>", desc = "Stage File" },
		},
	},
	{
		"NeogitOrg/neogit",
		keys = {
			{
				"<leader>gs",
				function()
					require("neogit").open({ kind = "tab" })
				end,
				desc = "Open Neogit Tab",
			},
			{ "<leader>gc", ":Neogit commit<CR>", desc = "Neogit commit" },
			{ "<leader>gp", ":Neogit push<CR>", desc = "Neogit push" },
			{ "<leader>gl", ":Neogit pull<CR>", desc = "Neogit pull" },
		},
		config = function()
			require("neogit").setup({
				graph_style = "ascii",
				commit_editor = { kind = "replace" },
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		keys = {
			{ "<leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "FileHistory Diff" },
			{ "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "DiffView Open" },
			{ "<leader>gq", "<cmd>DiffviewClose<CR>", desc = "DiffView Close" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup()
		end,
	},
}
