local vim = vim
local Plug = vim.fn["plug#"]

vim.call("plug#begin")

-- Colorscheme
Plug("NLKNguyen/papercolor-theme")
Plug("dikiaap/minimalist")
Plug("morhetz/gruvbox")

-- Fuzzy Finding and Searching
Plug("nvim-telescope/telescope.nvim", { ["tag"] = "0.1.8" })
Plug("BurntSushi/ripgrep")
Plug("sharkdp/fd")
Plug("junegunn/fzf", { ["dir"] = "~/.fzf", ["do"] = "./install --all" })
Plug("junegunn/fzf.vim")
-- Quick Navigation between often used files
Plug("ThePrimeagen/harpoon", { ["branch"] = "harpoon2", })

-- Treesitter for Parsing languages
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug("nvim-treesitter/playground")

-- File editing and undo-history
Plug("mbbill/undotree")

-- Git Integration
Plug("tpope/vim-fugitive")

-- LSP Plugins and Configuration
Plug("nvim-lua/plenary.nvim")
Plug("neovim/nvim-lspconfig")
Plug("Issafalcon/lsp-overloads.nvim")
-- Snippets and Autocompletion
Plug("saadparwaiz1/cmp_luasnip")
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("L3MON4D3/LuaSnip")
-- Sane defaults for LSP configuration and management of language servers.
Plug("VonHeikemen/lsp-zero.nvim", {["branch"] = "v3.x"})
Plug("williamboman/mason.nvim")
Plug("williamboman/mason-lspconfig.nvim")
-- Diagnostics Handling
Plug("folke/trouble.nvim")

-- DAP Configuration
Plug("mfussenegger/nvim-dap")
Plug("jay-babu/mason-nvim-dap.nvim")
Plug("theHamsta/nvim-dap-virtual-text")
Plug("nvim-neotest/nvim-nio")
Plug("rcarriga/nvim-dap-ui")

-- DAP Settings
Plug("mfussenegger/nvim-dap")
Plug("jay-babu/mason-nvim-dap.nvim")
Plug("nvim-neotest/nvim-nio")
Plug("rcarriga/nvim-dap-ui")
Plug("theHamsta/nvim-dap-virtual-text")

-- Status line at bottom of screen, show buffers in the status line as well.
Plug("vim-airline/vim-airline")
Plug("vim-airline/vim-airline-themes")
Plug("ryanoasis/vim-devicons")

-- Database UI
Plug("tpope/vim-dadbod")
Plug("kristijanhusak/vim-dadbod-ui")
Plug("kristijanhusak/vim-dadbod-completion")

vim.call("plug#end")
