vim.g.mapleader = " "

-- Project View opens file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move lines around in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Append the next line to the current but keep the cursor in place.
vim.keymap.set("n", "J", "mzJ`z")

-- Page jumps, but staying in the middle. Keeps eyes focussed.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keeps search in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Don't overwrite the paste buffer when select + paste over a word.
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Quick-Fix navigation, diagnostics and keeping centered
vim.keymap.set("n", "<C-j>", ":lua vim.diagnostic.get_next({ count = 1 })<CR>zz")
vim.keymap.set("n", "<C-k>", ":lua vim.diagnostic.get_prev({ count = -1 })<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
