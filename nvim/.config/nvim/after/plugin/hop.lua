require("hop").setup({
    keys = 'etovxqpdygfblzhckisuran'
})

vim.keymap.set({ "n", "v" }, "<leader>h", "<cmd>HopChar1<CR>")
vim.keymap.set({ "n", "v" }, "<leader>H", "<cmd>HopChar2<CR>")
vim.keymap.set({ "n", "v" }, "<leader>w", "<cmd>HopWord<CR>")
