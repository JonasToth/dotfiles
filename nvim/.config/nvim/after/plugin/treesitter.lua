require("nvim-treesitter.configs").setup({
    modules = {},
    ignore_install = {},
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "disassembly",
        "dockerfile",
        "doxygen",
        "git_config",
        "git_rebase",
        "gnuplot",
        "html",
        "htmldjango",
        "lua",
        "markdown",
        "markdown_inline",
        "meson",
        "ninja",
        "python",
        "rust",
        "tmux",
        "toml",
        "vimdoc",
        "xml",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            node_incremental = "v",
            -- node_decremental = "<>",
            scope_incremental = "V",
            scope_decremental = "<C-V>",
        }
    }
})

-- Dimming of Code Segments
require("twilight").setup({
    dimming = { alpha = 0.5, },
    context = 15,
    expand = {
        "function",
        "method",
        "table"
    }
})
vim.keymap.set("n", "<leader>bt", ":Twilight<CR>")
