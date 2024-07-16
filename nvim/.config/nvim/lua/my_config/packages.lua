local vim = vim
local Plug = vim.fn["plug#"]

vim.call("plug#begin")

-- Colorscheme
Plug("NLKNguyen/papercolor-theme")
Plug("dikiaap/minimalist")
Plug("morhetz/gruvbox")

-- Fuzzy Finding and Searching
Plug("nvim-telescope/telescope.nvim", { ["tag"]= "0.1.8" })
Plug("BurntSushi/ripgrep")
Plug("sharkdp/fd")
Plug("junegunn/fzf", { ["dir"] = "~/.fzf", ["do"] = "./install --all" })
Plug("junegunn/fzf.vim")

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
-- Snippets and Autocompletion
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("L3MON4D3/LuaSnip")
-- Sane defaults for LSP configuration and management of language servers.
Plug("VonHeikemen/lsp-zero.nvim", {["branch"] = "v3.x"})
Plug("williamboman/mason.nvim")
Plug("williamboman/mason-lspconfig.nvim")

-- DAP Settings
Plug("mfussenegger/nvim-dap")
Plug("jay-babu/mason-nvim-dap.nvim")
Plug("nvim-neotest/nvim-nio")
Plug("rcarriga/nvim-dap-ui")
Plug("theHamsta/nvim-dap-virtual-text")

-- Status line at bottom of screen, show buffers in the status line as well.
Plug("vim-airline/vim-airline")
Plug("vim-airline/vim-airline-themes")
Plug("bling/vim-bufferline")
Plug("ryanoasis/vim-devicons")

vim.call("plug#end")
