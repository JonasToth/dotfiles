local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>g", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>4", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>5", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>6", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>7", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>e", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>r", function() harpoon:list():next() end)

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>ph", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
