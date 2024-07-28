local Path = require('plenary.path')
require('tasks').setup({
    -- Default module parameters with which `neovim.json` will be created.
    default_params = {
        cmake = {
            -- CMake executable to use, can be changed using `:Task set_module_param cmake cmd`.
            cmd = 'cmake',
            -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
            build_dir = function()
                --[[local git_dir = Path.find_upwards(".git")
                print(git_dir)
                return tostring(Path:new(git_dir, 'build'))--]]

                -- return "/home/jonas/software/llvm-project/build"
                return tostring(Path:new('{cwd}', 'build', '{os}-{build_type}'))
            end,
            -- Build type, can be changed using `:Task set_module_param cmake build_type`.
            build_type = 'Debug',
            -- DAP configuration name from `require('dap').configurations`. If there is no such configuration, a new one with this name as `type` will be created.
            dap_name = 'codelldb',
            -- Task default arguments.
            args = {
                configure = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1', '-G', 'Ninja' },
            },
        },
    },
    -- If true, all files will be saved before executing a task.
    save_before_run = true,
    -- JSON file to store module and task parameters.
    params_file = 'neovim.json',
    quickfix = {
        -- Default quickfix position.
        pos = 'botright',
        -- Default height.
        height = 12,
    },
    dap_open_command = require('dapui').open,
})
