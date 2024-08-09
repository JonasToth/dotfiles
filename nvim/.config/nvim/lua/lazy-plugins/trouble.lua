return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    { "<leader>dt", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics" },
    { "<leader>dT", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics" },
  }
}
