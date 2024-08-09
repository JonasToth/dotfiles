return {
    "nvim-telescope/telescope.nvim", branch = "0.1.x",
     dependencies = {
         "nvim-lua/plenary.nvim",
         "nvim-telescope/telescope-smart-history.nvim",
         "nvim-telescope/telescope-ui-select.nvim",
         "kkharji/sqlite.lua",
         "BurntSushi/ripgrep",
         "sharkdp/fd",
         { "junegunn/fzf", { dir = "~/.fzf", build = "./install --all"} },
         "junegunn/fzf.vim",
     },
}
