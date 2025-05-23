return {
    {
        -- Allow a terminal floating window to be toggled.
        "akinsho/toggleterm.nvim",
        keys = {
            { "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", desc = "ToggleTerm" }
        },
        config = function()
            require 'toggleterm'.setup({
                shade_terminals = false
            })
            function _G.set_terminal_keymaps()
                local opts = { buffer = 0 }
                vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
                vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
            end

            -- Configure better keymaps for the opened terminal.
            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
        end,
    },
    -- Provide CMake Integration.
    {
        "stevearc/overseer.nvim",
    },
    {
        "JonasToth/cmake-tools.nvim",
        branch = "feature/test-presets",
        dependencies = {
            "akinsho/toggleterm.nvim",
            "stevearc/overseer.nvim",
            "rcarriga/nvim-dap-ui",
        },
        keys = {
            { "<leader>cC", ":CMakeSelectConfigurePreset<CR>", desc = "Select Configure Preset" },
            { "<leader>cB", ":CMakeSelectBuildPreset<CR>",     desc = "Select Build Preset" },
            { "<leader>cT", ":CMakeSelectTestPreset<CR>",      desc = "Select Test Preset" },
            { "<leader>cb", ":CMakeBuild<CR>",                 desc = "Perform Build" },
            { "<leader>ct", ":CMakeRunTest<CR>",               desc = "Execute Tests" },
            { "<leader>cS", ":CMakeStopExecutor<CR>",          desc = "Stop Build" },
            { "<leader>cA", ":CMakeStopRunner<CR>",            desc = "Stop Tests" },
        },
        cmd = {
            "CMakeGenerate",
            "CMakeBuild",
            "CMakeBuildCurrentFile",
            "CMakeRun",
            "CMakeRunCurrentFile",
            "CMakeDebug",            -- does not work as expected
            "CMakeDebugCurrentFile", -- does not work as expected
            "CMakeRunTest",
            "CMakeLaunchArgs",
            "CMakeSelectBuildTarget",
            "CMakeSelectLaunchTarget",
            "CMakeSelectConfigurePreset",
            "CMakeSelectBuildPreset",
            "CMakeSelectTestPreset",
            "CMakeOpen",
            "CMakeClose",
            "CMakeInstall",
            "CMakeClean",
            "CMakeQuickBuild",
            "CMakeQuickRun",
            "CMakeQuickDebug",
            "CMakeShowTargetFiles",
            "CMakeQuickStart",
        },
        opts = {
            cmake_command = "cmake",                                                     -- this is used to specify cmake command path
            ctest_command = "ctest",
            cmake_regenerate_on_save = false,                                            -- auto generate when save CMakeLists.txt
            cmake_generate_options = { "-GNinja", "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
            cmake_build_options = {},                                                    -- this will be passed when invoke `CMakeBuild`
            cmake_build_directory = "out/${variant:buildType}",                          -- this is used to specify generate directory for cmake
            cmake_soft_link_compile_commands = true,                                     -- this will automatically make a soft link from compile commands file to project root dir
            cmake_compile_commands_from_lsp = false,                                     -- this will automatically set compile commands file location using lsp,
            -- to use it, please set `cmake_soft_link_compile_commands` to false
            cmake_variants_message = {
                short = { show = true },                 -- whether to show short message
                long = { show = true, max_length = 40 }, -- whether to show long message
            },
            cmake_dap_configuration = {                  -- debug settings for cmake
                name = "cpp",
                type = "codelldb",
                request = "launch",
                stopOnEntry = true,
                runInTerminal = true,
                console = "integratedTerminal",
                envFile = "${workspaceFolder}/.bin/clang/Debug/generators/conanrunenv.env",
            },
            cmake_executor = {                   -- executor to use
                name = "quickfix",               -- name of the executor
                opts = {},                       -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
                default_opts = {                 -- a list of default and possible values for executors
                    quickfix = {
                        show = "always",         -- "always", "only_on_error"
                        position = "belowright", -- "bottom", "top"
                        size = 10,
                    },
                    toggleterm = {
                        direction = "float",   -- 'vertical' | 'horizontal' | 'tab' | 'float'
                        close_on_exit = false, -- whether close the terminal when exit
                        auto_scroll = true,    -- whether auto scroll to the bottom
                    },
                    overseer = {
                        new_task_opts = {
                            strategy = {
                                "toggleterm",
                                direction = "horizontal",
                                autos_croll = true,
                                quit_on_exit = "success"
                            }
                        },   -- options to pass into the `overseer.new_task` command
                        on_new_task = function(_)
                        end, -- a function that gets overseer.Task when it is created, before calling `task:start`
                    },
                    terminal = {
                        name = "Main Terminal",
                        prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
                        split_direction = "horizontal", -- "horizontal", "vertical"
                        split_size = 11,

                        -- Window handling
                        single_terminal_per_instance = true,  -- Single instance, multiple windows
                        single_terminal_per_tab = true,       -- Single instance per tab
                        keep_terminal_static_location = true, -- Static location of the viewport if avialable

                        -- Running Tasks
                        start_insert = false,       -- If you want to enter terminal with :startinsert
                        focus = false,              -- Focus on cmake terminal when cmake task is launched.
                        do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
                    },                              -- terminal executor uses the values in cmake_terminal
                },
            },
            cmake_runner = {                     -- runner to use
                name = "overseer",               -- name of the runner
                opts = {},                       -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
                default_opts = {                 -- a list of default and possible values for runners
                    quickfix = {
                        show = "always",         -- "always", "only_on_error"
                        position = "belowright", -- "bottom", "top"
                        size = 10,
                        encoding = "utf-8",
                        auto_close_when_success = false, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
                    },
                    toggleterm = {
                        direction = "float",   -- 'vertical' | 'horizontal' | 'tab' | 'float'
                        close_on_exit = false, -- whether close the terminal when exit
                        auto_scroll = true,    -- whether auto scroll to the bottom
                    },
                    overseer = {
                        new_task_opts = {
                            strategy = {
                                "toggleterm",
                                direction = "float",
                                autos_croll = true
                            }
                        },                             -- options to pass into the `overseer.new_task` command
                        on_new_task = function(_) end, -- a function that gets overseer.Task when it is created, before calling `task:start`
                    },
                    terminal = {
                        name = "Runner Terminal",
                        prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
                        split_direction = "horizontal", -- "horizontal", "vertical"
                        split_size = 10,

                        -- Window handling
                        single_terminal_per_instance = true,  -- Single instance, multiple windows
                        single_terminal_per_tab = true,       -- Single instance per tab
                        keep_terminal_static_location = true, -- Static location of the viewport if avialable

                        -- Running Tasks
                        start_insert = true,        -- If you want to enter terminal with :startinsert
                        focus = true,               -- Focus on cmake terminal when cmake task is launched.
                        do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
                    },
                },
            },
            cmake_notifications = {
                runner = { enabled = true },
                executor = { enabled = true },
                spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
                refresh_rate_ms = 100, -- how often to iterate icons
            },
        },
    },
}
