local remove_sos = function(exec)
    -- Filter out shared libraries
    return not exec:match('%.so([.0-9]*)')
end

---Appends environment variables to @c envTable if they are present in envFile but aren't
---in envTable.
---@param envFile string Path to a file containing environment variables.
---@param envTable table Mapping of environment variable name and its values.
---@return table enrichedEnvironment
local appendEnvFileToEnv = function(envFile, envTable)
    if envFile == nil then
        return envTable
    end
    local file = io.open(envFile, "rb")
    if not file then return envTable end
    local content = file:read("*a")
    file:close()
    local lines = vim.split(content, "\n")
    for _, line in ipairs(lines) do
        local assignment_idx = string.find(line, "=", 1, true)
        if assignment_idx ~= nil then
            local key = string.sub(line, 1, assignment_idx - 1)
            local value = string.sub(line, assignment_idx + 1)
            if envTable.key == nil then
                envTable[key] = value
            end
        end
    end
    return envTable
end

return {
    {
        "mfussenegger/nvim-dap",
        ft = "cpp",
        config = function()
            require("mason")
            require("mason-nvim-dap").setup({
                automatic_installation = true,
                ensure_installed = { "codelldb", "debugpy" },
            })
            local dap = require("dap")
            local mason_registry = require('mason-registry')
            -- note that this will error if you provide a non-existent package name
            dap.adapters.codelldb = {
                type = "server",
                port = "13000",
                executable = {
                    command = "codelldb",
                    args = { "--port", "13000" },
                },
                -- enrich_config = function(config, on_config)
                --     local final_config = vim.deepcopy(config)
                --     local env = final_config.env or {}
                --     if string.find(final_config.program, "intf_worker") ~= nil then
                --         env["DATABASE_BENUTZER_SCHEMA_PASSWORD"] = "mb$admin"
                --         env["APPLICATION_SERVER_URL_BASE"] = "https://qsfarm14-qs250b-rail.qs.ep.ivu.systems:443"
                --         env["OTEL_RESOURCE_ATTRIBUTES"] = "service.name=intf-worker"
                --     end
                --     final_config.env = env
                --     on_config(final_config)
                -- end,
            }
            dap.adapters.gdb = {
                id = 'gdb',
                type = 'executable',
                command = '/mnt/code/repos/gdb-static/gdb',
                args = { '--quiet', '--interpreter=dap' },
                enrich_config = function(config, on_config)
                    local final_config = vim.deepcopy(config)
                    local env = appendEnvFileToEnv(final_config.envFile, final_config.env or {})
                    final_config.env = env
                    on_config(final_config)
                end,
            }
            require("dap-python").setup("python3")
            table.insert(dap.configurations.python, {
                type = "python",
                request = "launch",
                name = "Debug Test for Macro Transformation",
                cwd = "/mnt/code/repos/ivu-plan-source/mb2cpp/tools/cmake/",
                program = "test_self_registration_to_functions.py",
                args = { "TestContextInsertionPoints.test_file_with_simple_registerServices" },
                stopOnEntry = true,
            })
            dap.configurations.cpp = {
                {
                    name = "Debug DC Visualizer",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.getcwd() .. "/.bin/clang/Debug/bin64/vd_comp_DepotManagement_testserver_IntegrationTests"
                        -- return vim.fn.getcwd() .. "/.bin/clang/Debug/bin64/common_lib_util_UnitTests"
                    end,
                    args = function()
                        return { "--gtest_filter=TestVehicleChargingDataHandling.*", "--gtest_brief=1", "--private" }
                    end,
                    envFile = "${workspaceFolder}/.bin/clang/Debug/generators/conanrunenv.env",
                    initCommands = {
                        "command source '${workspaceFolder}/tools/lldb/debug_config.lldb'",
                        "command script import '${workspaceFolder}/tools/lldb/complex_visualizers.py'",
                        "command source '${workspaceFolder}/tools/lldb/visualizers.lldb'",
                    },
                    preRunCommands = {
                        "breakpoint name configure --disable cpp_exception",
                        "breakpoint set -f VCTestVehicleChargingDataHandling.cpp -l 354",
                    },
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
                {
                    name = "Debug Depot Tests",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.getcwd() .. "/.bin/clang/Debug/bin64/ttp_comp_OperationalTripEditing_testserver_IntegrationTests"
                    end,
                    args = function()
                        return { "--gtest_filter=*testNotTrainIntegratedEditingOfTripWithLoopAndSameEndTimesAfterLoop*", "--gtest_brief=0", "--private" }
                    end,
                    envFile = "${workspaceFolder}/.bin/clang/Debug/generators/conanrunenv.env",
                    initCommands = {
                        "command source '${workspaceFolder}/tools/lldb/debug_config.lldb'",
                        "command script import '${workspaceFolder}/tools/lldb/complex_visualizers.py'",
                        "command source '${workspaceFolder}/tools/lldb/visualizers.lldb'",
                    },
                    preRunCommands = {
                        "breakpoint name configure --disable cpp_exception",
                    },
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
                {
                    name = "Debug UtcTimepoint (gdb)",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return "common_lib_util_UnitTests"
                    end,
                    args = function()
                        return { "--gtest_filter=TestUtcTimepoint.*", "--gtest_brief=1" }
                    end,
                    envFile = "${workspaceFolder}/.bin/gcc/Debug/generators/conanrunenv.env",
                    cwd = "${workspaceFolder}/.bin/gcc/Debug/bin64",
                    stopAtBeginningOfMainSubprogram = true,
                    stopOnEntry = true,
                },
                {
                    name = "Launch Test Debug",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        local path = vim.fn.getcwd() .. "/.bin/gcc/Debug/bin64"
                        local exec_opts = {
                            path = path,
                            executables = true,
                            filter = remove_sos,
                        }
                        return require('dap.utils').pick_file(exec_opts)
                    end,
                    args = function()
                        local arguments = vim.split(vim.fn.input("Arguments: "), " ")
                        return arguments
                    end,
                    envFile = "${workspaceFolder}/.bin/clang/Debug/generators/conanrunenv.env",
                    initCommands = { "command source '${workspaceFolder}/tools/lldb/visualizers.lldb'" },
                    preRunCommands = { "breakpoint name configure --disable cpp_exception" },
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
                {
                    name = "Launch Test RelWithDebInfo",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/.bin/gcc/RelWithDebInfo/bin64/",
                            "file")
                    end,
                    args = function()
                        local arguments = vim.split(vim.fn.input("Arguments: "), " ")
                        return arguments
                    end,
                    envFile = "${workspaceFolder}/.bin/clang/RelWithDebInfo/generators/conanrunenv.env",
                    initCommands = { "command source '${workspaceFolder}/tools/lldb/visualizers.lldb'" },
                    preRunCommands = { "breakpoint name configure --disable cpp_exception" },
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
                {
                    name = "Launch intf-worker",
                    type = "codelldb",
                    request = "launch",
                    program = "${workspaceFolder}/.bin/clang/Debug/bin64/intf_worker",
                    args = {
                        "--database", "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=D1PSE20QSDB14.ivu-ag.com)(PORT=1521)))(CONNECT_DATA=(SID=qs250b)))",
                        "--company", "rail",
                        "--schema", "rail",
                        "--IvuPlanConfigFile", "/home/jto@ivu-ag.com/connection_setup/mb.ini"
                    },
                    envFile = "${workspaceFolder}/.bin/clang/Debug/generators/conanrunenv.env",
                    initCommands = {
                        "command source '${workspaceFolder}/tools/lldb/visualizers.lldb'"
                    },
                    -- preRunCommands = { "breakpoint name configure --disable cpp_exception" },
                    cwd = "${workspaceFolder}",
                    stopOnEntry = true,
                },
                {
                    name = 'Attach to process (lldb)',
                    type = 'codelldb',
                    request = 'attach',
                    pid = require('dap.utils').pick_process,
                },
                {
                    name = 'Attach to process (gdb)',
                    type = 'gdb',
                    request = 'attach',
                    pid = require('dap.utils').pick_process,
                },
            }
            vim.keymap.set("n", "<leader>Bb", function() dap.toggle_breakpoint() end)
            vim.keymap.set("n", "<leader>Bc", function()
                vim.ui.input({ prompt = "Condition: " }, function(input)
                    if input ~= nil then
                        dap.toggle_breakpoint(input)
                    end
                end)
            end)
            vim.keymap.set("n", "<leader>Br", function() dap.run_to_cursor() end)
            vim.keymap.set("n", "<F1>", function() dap.continue() end)
            vim.keymap.set("n", "<F2>", function() dap.step_into() end)
            vim.keymap.set("n", "<F3>", function() dap.step_over() end)
            vim.keymap.set("n", "<F4>", function() dap.step_out() end)
            vim.keymap.set("n", "<F5>", function() dap.step_back() end)
            vim.keymap.set("n", "<F9>", function() dap.run_last() end)
            vim.keymap.set("n", "<F10>", function() dap.terminate() end)
            vim.keymap.set("n", "<F12>", function() dap.restart() end)
            vim.keymap.set("n", "<leader><leader>u", function() dap.up() end)
            vim.keymap.set("n", "<leader><leader>d", function() dap.down() end)
        end,
        dependencies = {
            { "theHamsta/nvim-dap-virtual-text", },
            {
                "jay-babu/mason-nvim-dap.nvim",
                lazy = true,
                opts = false,
            },
            { "mfussenegger/nvim-dap-python" },
        },
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        ft = { "cpp", "python" },
        opts = {
            virt_text_pos = "eol",
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        ft = { "cpp", "python" },
        dependencies = {
            { "nvim-neotest/nvim-nio", lazy = true },
        },
        config = function()
            -- Setup Debug UI
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup(
                {
                    controls = {
                        element = "repl",
                        enabled = true,
                        icons = {
                            disconnect = "",
                            pause = "",
                            play = "",
                            run_last = "",
                            step_back = "",
                            step_into = "",
                            step_out = "",
                            step_over = "",
                            terminate = ""
                        }
                    },
                    element_mappings = {},
                    expand_lines = true,
                    floating = {
                        border = "single",
                        mappings = {
                            close = { "q", "<Esc>" }
                        }
                    },
                    force_buffers = true,
                    icons = {
                        collapsed = "",
                        current_frame = "",
                        expanded = ""
                    },
                    layouts = { {
                        elements = {
                            {
                                id = "watches",
                                size = 0.05
                            },
                            {
                                id = "breakpoints",
                                size = 0.1
                            },
                            {
                                id = "stacks",
                                size = 0.3
                            },
                            {
                                id = "scopes",
                                size = 0.55
                            },
                        },
                        position = "left",
                        size = 65
                    }, {
                        elements = { {
                            id = "repl",
                            size = 0.5
                        }, {
                            id = "console",
                            size = 0.5
                        } },
                        position = "bottom",
                        size = 17
                    } },
                    mappings = {
                        edit = "e",
                        expand = { "x", "<2-LeftMouse>" },
                        open = "o",
                        remove = "d",
                        repl = "r",
                        toggle = "t"
                    },
                    render = {
                        indent = 1,
                        max_value_lines = 100
                    }
                }
            )

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
    {
        "CLRN/gdb-disasm.nvim",
        ft = { "c", "cpp" },
        event = "VeryLazy",
        enabled = true,
        config = function()
            local status, cmake = pcall(require, "cmake-tools")
            if not status then
                return
            end
            local disasm = require "gdbdisasm"
            disasm.setup {}

            -- local target = cmake.get_build_target()
            -- if target then
            --     disasm.set_binary_path(cmake.get_build_target_path(target))
            -- end

            vim.keymap.set("n", "<leader>dai", disasm.toggle_inline_disasm, { desc = "Toggle disassembly" })
            vim.keymap.set("n", "<leader>das", disasm.save_current_state, { desc = "Save current session state" })
            vim.keymap.set("n", "<leader>dal", disasm.load_saved_state, { desc = "Load saved session" })
            vim.keymap.set("n", "<leader>dar", disasm.remove_saved_state, { desc = "Remove saved session" })
            vim.keymap.set("n", "<leader>dac", disasm.resolve_calls_under_the_cursor, { desc = "Jump to a call" })
            vim.keymap.set("n", "<leader>daw", disasm.new_window_disasm, { desc = "Disassemble to new window" })
            vim.keymap.set("n", "<leader>daq", disasm.stop, { desc = "Clean disassembly and quit GDB" })
        end,
    },
}
