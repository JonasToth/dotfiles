require("hop").setup({
    keys = 'etovxqpdygfblzhckisuran'
})

vim.keymap.set("n", "<leader>h", "<cmd>HopChar1<CR>")
vim.keymap.set("n", "<leader>H", "<cmd>HopChar2<CR>")
vim.keymap.set("n", "<leader>w", "<cmd>HopWord<CR>")
