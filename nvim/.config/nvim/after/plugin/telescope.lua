local actions = require("telescope.actions")
local open_with_trouble = require("trouble.sources.telescope").open

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add

local telescope = require("telescope")

telescope.setup({
  defaults = {
    mappings = {
      i = { ["<c-t>"] = open_with_trouble },
      n = { ["<c-t>"] = open_with_trouble },
    },
  },
})

local builtin = require("telescope.builtin")

-- Project Files
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
-- Project Git Files
vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
-- Project Diagnostics
vim.keymap.set("n", "<leader>pd", builtin.diagnostics, {})
-- Project Buffers
vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
-- Project Search
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
