return {
	{
		"folke/todo-comments.nvim",
		event = { "VeryLazy" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
			vim.keymap.set("n", "]t", function()
				require("todo-comments").jump_next()
			end, { desc = "Next todo comment" })
			vim.keymap.set("n", "[t", function()
				require("todo-comments").jump_prev()
			end, { desc = "Previous todo comment" })
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { theme = "sonokai" },
	},
	{
		-- Better UI Experience.
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
	{
		-- Surrounding Text with delimiters.
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			local surround = require("nvim-surround")
			local surround_config = require("nvim-surround.config")
			surround.setup({
				surrounds = {
					["f"] = {
						add = function()
							local result = surround_config.get_input("Enter the function name: ")
							if result then
								return { { result .. "(" }, { ")" } }
							end
						end,
						find = function()
							if vim.g.loaded_nvim_treesitter then
								local selection = surround_config.get_selection({
									query = {
										capture = "@call.outer",
										type = "textobjects",
									},
								})
								if selection then
									return selection
								end
							end
							return surround_config.get_selection({ pattern = "[^=%s%(%){}]+%b()" })
						end,
						delete = "^(.-%()().-(%))()$",
						change = {
							target = "^.-([%w_%:]+)()%(.-%)()()$",
							replacement = function()
								local result = surround_config.get_input("Enter the function name: ")
								if result then
									return { { result }, { "" } }
								end
							end,
						},
					},
					["F"] = {
						add = function()
							local result = surround_config.get_input("Enter the constructor name: ")

							if result then
								return { { result .. "{" }, { "}" } }
							end
						end,
						find = function()
							-- TODO: I don't know enough about treesitter to properly query
							--       here.
							-- if vim.g.loaded_nvim_treesitter then
							--     local selection = surround_config.get_selection({
							--         query = {
							--             capture = "@call.outer",
							--             type = "textobjects",
							--         },
							--     })
							--     if selection then
							--         return selection
							--     end
							-- end
							return surround_config.get_selection({ pattern = "[^=%s{}]+%b{}" })
						end,
						delete = "^(.-%{)().-(%})()$",
						change = {
							target = "^.-([%w_]+)()%{.-%}()()$",
							replacement = function()
								local result = surround_config.get_input("Enter the constructor name: ")
								if result then
									return { { result }, { "" } }
								end
							end,
						},
					},
				},
			})
		end,
	},
	{
		-- Improved UI-input widget.
		"folke/snacks.nvim",
		event = "VeryLazy",
		version = "*",
		---@type snacks.Config
		opts = {
			notifier = { enabled = true },
			quickfile = { enabled = true },
			bigfile = { enabled = true },
			input = {
				enabled = true,
				backdrop = false,
				position = "float",
				border = "rounded",
				title_pos = "center",
				height = 1,
				width = 60,
				relative = "editor",
				noautocmd = true,
				row = 2,
				-- relative = "cursor",
				-- row = -3,
				-- col = 0,
				wo = {
					winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
					cursorline = false,
				},
				bo = {
					filetype = "snacks_input",
					buftype = "prompt",
				},
				--- buffer local variables
				b = {
					completion = false, -- disable blink completions in input
				},
				keys = {
					n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n" },
					i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i" },
					i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = "i" },
					i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i" },
					q = "cancel",
				},
			},
		},
	},
    {
        "danymat/neogen",
        config = true,
        version = "*",
        opts = {
            snippet_engine = "luasnip",
        },
    },
    {
        -- Improve vim command hygiene.
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        version = "*",
        event = "VeryLazy",
    }
}
