-- Print line numbers relative to the current line. Only the current line is the absolute number.
vim.opt.nu = true
vim.opt.relativenumber = true

-- Consistent tabulator and indendation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

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
vim.opt.colorcolumn="100"
