local lsp_zero = require("lsp-zero")

lsp_zero.preset("recommend")

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "cmake", "gopls", "lua_ls", "pylsp", },
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({})
    end,
  }
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp_zero.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-b>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-Space>"] = cmp.mapping.complete(),
})

lsp_zero.set_preferences({
	sign_icons = {}
});
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)
  vim.keymap.set("n", "<leader>le", function() vim.lsp.buf.code_action({ apply = true }) end, opts)
  vim.keymap.set("n", "<leader>ld", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "<leader>lt", function() vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set("n", "<leader>li", function() vim.cmd.ClangdSwitchSourceHeader() end, opts)
  vim.keymap.set("n", "<leader>lx", function() vim.lsp.buf.references() end, opts)

  vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.document_highlight() end, opts)
  vim.keymap.set("n", "<leader>lg", function() vim.lsp.buf.clear_references() end, opts)

  vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>lc", function() vim.lsp.buf.incoming_calls() end, opts)
end)
