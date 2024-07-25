require("trouble").setup({})

vim.keymap.set("n", "<leader>dt", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>")
vim.keymap.set("n", "<leader>dT", "<cmd>Trouble diagnostics toggle<CR>")
