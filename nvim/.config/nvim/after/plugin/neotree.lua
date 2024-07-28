require("neo-tree").setup({
    sources = { "filesystem", "document_symbols" },
    -- netrw disabled, opening a directory opens neo-tree
    -- whatever position is specified in window.position
    hijack_netrw_behavior = "open_default",
    window = {
        position = "right",
        width = 80,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
    }
})
