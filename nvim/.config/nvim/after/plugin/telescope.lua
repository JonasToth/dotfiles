local telescope = require("telescope")
telescope.setup({
    extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown {} }
    },
    pickers = {
        buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
        },
    },
    defaults = {
        mappings = {
            i = { ["<c-t>"] = open_with_trouble },
            n = { ["<c-t>"] = open_with_trouble },
        },
    },
})
telescope.load_extension("ui-select")

-- Show line numbers in file preview
vim.cmd "autocmd User TelescopePreviewerLoaded setlocal number"

local builtin = require("telescope.builtin")

-- Project Files
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
-- Project Git Files
vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
-- Project Diagnostics
vim.keymap.set("n", "<leader>pd", builtin.diagnostics, {})
-- Project Search
vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})

-- Show git branches
vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})

-- Show file markers
vim.keymap.set("n", "<leader>bm", builtin.marks, {})
-- List Open Buffers
vim.keymap.set("n", "<leader>bl", builtin.buffers, {})
-- Search in the current buffer with fuzzy find.
vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)
