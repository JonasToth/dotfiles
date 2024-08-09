return {
    { "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "Issafalcon/lsp-overloads.nvim",
        "p00f/clangd_extensions.nvim",
        -- Sane defaults for LSP configuration and management of language servers.
        { "VonHeikemen/lsp-zero.nvim",  branch = "v3.x" },
    }
},
}
