return {
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        config = function()
            require("mason")
            require("mason-nvim-dap").setup({
                ensure_installed = { "codelldb" },
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
                    args = { "--port", "13000" },
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
                        return { vim.fn.input("Arguments: ") }
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }
            vim.keymap.set("n", "<leader>B", function() dap.toggle_breakpoint() end)
            vim.keymap.set("n", "<leader>gb", function() dap.run_to_cursor() end)
            vim.keymap.set("n", "<F1>", function() dap.continue() end)
            vim.keymap.set("n", "<F2>", function() dap.step_into() end)
            vim.keymap.set("n", "<F3>", function() dap.step_over() end)
            vim.keymap.set("n", "<F4>", function() dap.step_out() end)
            vim.keymap.set("n", "<F5>", function() dap.step_back() end)
            vim.keymap.set("n", "<F12>", function() dap.restart() end)
        end,
        dependencies = {
            { "theHamsta/nvim-dap-virtual-text", },
            {
                "jay-babu/mason-nvim-dap.nvim",
                lazy = true,
                opts = false,
            },
        },
    },
    --[[    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = {
            { "nvim-neotest/nvim-nio", lazy = true },
        },
        config = function()
            -- Setup Debug UI
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()

            -- Setup Key Mappings to control the debug ui.
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

            vim.keymap.set("n", "<leader>?", function() require("dapui").eval(nil, { enter = true }) end)
        end,
    },
--]]
}
