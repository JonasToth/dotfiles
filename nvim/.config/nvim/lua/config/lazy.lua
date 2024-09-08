-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Print line numbers relative to the current line. Only the current line is the absolute number.
vim.opt.nu = true
vim.opt.relativenumber = true

-- Consistent tabulator and indendation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Folding based on treesitter syntax.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

-- Highlight the current line.
vim.opt.cursorline = true

-- Keep a distance to the top/bottom boundary by 4 lines.
vim.opt.scrolloff = 8

-- Highlight matching parentheses
vim.opt.showmatch = true

-- Searching within a file, incremental and highlight the match.
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- Set the file format to unix all the time
vim.opt.fileformat = "unix"
vim.opt.encoding = "utf-8"

-- No swap files and backups.
vim.opt.swapfile = false
vim.opt.backup = false

-- good colors
vim.opt.termguicolors = true

-- Enable mode lines at the end of a file to configure vim display settings.
vim.opt.modelines = 1

-- Not exactly sure tbh.
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = false
vim.opt.colorcolumn = "100"

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

-- Close the current tab
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>")
vim.keymap.set("n", "<leader>tn", ":tabnext<CR>")
vim.keymap.set("n", "<leader>tp", ":tabprev<CR>")

-- Open Lazy View
vim.keymap.set("n", "<leader>L", ":Lazy<CR>")

-- Re-Source vim-rc
vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<CR>")

P = function (v)
    print(vim.inspect(v))
    return v
end

vim.keymap.set("n", "<leader>x", ":w<CR>:source %<CR>")

-- Re-Source vim-rc
vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<CR>")

P = function (v)
    print(vim.inspect(v))
    return v
end

vim.keymap.set("n", "<leader>x", ":w<CR>:source %<CR>")

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "lazy-plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
})
