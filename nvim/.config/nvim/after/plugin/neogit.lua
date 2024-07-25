local neogit = require('neogit')
neogit.setup({
    graph_style = "ascii",
    commit_editor = {
        kind = "replace",
    }
})
-- kind = "floating" makes a floating pane, but fails to properly commit.
vim.keymap.set("n", "<leader>gs", function() neogit.open({ kind = "tab" }) end)
vim.keymap.set("n", "<leader>gw", ":Gwrite<CR>")
vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>")
vim.keymap.set("n", "<leader>gp", ":Neogit push<CR>")
vim.keymap.set("n", "<leader>gl", ":Neogit pull<CR>")
vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory<CR>")
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>")
vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<CR>")
