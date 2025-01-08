return {
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		config = function()
			vim.opt.background = "dark"
			vim.g.gruvbox_material_background = "soft"
			vim.g.gruvbox_material_better_performance = 1
			vim.g.gruvbox_material_disable_italic_comment = true
			vim.cmd("silent! colorscheme gruvbox-material")
		end,
		-- "NLKNguyen/papercolor-theme"
		-- "dikiaap/minimalist"
		-- "morhetz/gruvbox"
		-- "catppuccin/nvim", { ["as"] = "catppuccin" },
	},
	-- Dimming inactive parts of the code to get higher focus.
	{
		"folke/twilight.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			dimming = { alpha = 0.5 },
			context = 15,
			expand = {
				"function",
				"method",
				"table",
			},
		},
		keys = {
			{ "<leader>bt", ":Twilight<CR>", desc = "Highlight only Context" },
		},
	},
	-- Highlight Parentheses in different colors to disambiguate them.
	{
		"hiphish/rainbow-delimiters.nvim",
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")
			require("rainbow-delimiters.setup").setup({
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			})
		end,
	},
}
