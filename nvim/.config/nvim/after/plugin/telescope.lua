local builtin = require("telescope.builtin")

-- Project Files
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
-- Project Git Files
vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
-- Project Buffers
vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
-- Project Search
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
