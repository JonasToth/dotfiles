return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-path", -- Search in Paths
			"hrsh7th/cmp-buffer", -- Search in Buffer
			"hrsh7th/cmp-nvim-lsp-signature-help", -- Provide overload help
			-- Provide Completions for the search and command line of nvim
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-document-symbol", -- Search for LSP Symbols
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			my_sources = {
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
			}
			if not vim.loop.os_uname().sysname == "Windows_NT" then
				table.insert(my_sources, { name = "luasnip" })
			end
			table.insert(my_sources, { name = "path" })
			table.insert(my_sources, { name = "buffer" })
			table.insert(my_sources, { name = "neorg" })

			my_snippets = {}
			if not vim.loop.os_uname().sysname == "Windows_NT" then
				my_snippets = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				}
			end

			cmp.setup({
				sources = my_sources,
				mapping = {
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-h>"] = cmp.mapping(
						cmp.mapping.confirm({
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						}),
						{ "i", "c" }
					),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				},
				snippet = my_snippets,
				completion = { completeopt = "menu,menuone,noselect" },
			})
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "nvim_lsp_document_symbol" },
					{ name = "buffer" },
				}),
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		build = "make install_jsregexp",
		enabled = function()
			return vim.uv.os_uname().sysname == "Linux"
		end,
		config = function()
			local luasnip = require("luasnip")
			luasnip.config.set_config({
				history = false,
				updateevents = "TextChanged,TextChangedI",
			})

			vim.keymap.set({ "i", "s" }, "<C-j>", function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-k>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { silent = true })
		end,
	},
}
