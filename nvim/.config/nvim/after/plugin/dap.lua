require("mason").setup()
require("mason-nvim-dap").setup({
    ensure_installed = {"codelldb"},
})
local dap = require("dap")
dap.adapters.codelldb = {
  type = "server",
  host = "127.0.0.1",
  port = 13000 -- defines the port codelldb binds to.
}
dap.adapters.codelldb = {
  type = "server",
  port = "13000",
  executable = {
    command = "/home/jonas/.local/share/nvim/mason/packages/codelldb/codelldb",
    args = {"--port", "13000"},
  }
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    args = function()
        return {vim.fn.input("Arguments: ")}
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

-- Setup Debug UI
require("nvim-dap-virtual-text").setup()
local dapui = require("dapui")
dapui.setup()

-- Setup Key Mappings to control the debug ui.
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)
vim.keymap.set("n", "<leader>?", function()
    require("dapui").eval(nil, { enter = true })
end)
vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F12>", dap.restart)

-- Configure to show the dapui during debugging
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
