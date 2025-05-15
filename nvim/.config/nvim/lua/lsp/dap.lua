local function map(a, b, c)
    vim.keymap.set(a, b, c)
end

map("n", "<space>db", ":lua require'dap'.toggle_breakpoint()<CR>")
map("n", "<space>dc", ":lua require'dap'.continue()<CR>")
map("n", "<space>ds", ":lua require'dap'.step_over()<CR>")
map("n", "<space>dr", ":lua require'dap'.repl.open()<CR>")
map("n", "<space>dt", ':lua require("dapui").toggle()<CR>')

-- Icons
vim.fn.sign_define('DapBreakpoint', {text='B', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DabStopped', {text='S', texthl='', linehl='', numhl=''})

-- DapUi
-- require("dapui").setup()

--------------------
--Python debugging--
--------------------

local dap = require('dap')
dap.adapters.python = function(cb, config)
    if config.request == 'attach' then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or '127.0.0.1'
        cb({
            type = 'server',
            port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            host = host,
            options = {
                source_filetype = 'python',
            },
        })
    else
        cb({
            type = 'executable',
            --command = '/home/dario/.virtualenvs/debugpy/bin/python',
            command = '/home/dario/.local/progtools/debugpy/bin/python',
            args = { '-m', 'debugpy.adapter' },
            options = {
                source_filetype = 'python',
            },
        })
    end
end

local dap = require('dap')
dap.configurations.python = {
    {
        -- The first three options are required by nvim-dap
        type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch';
        name = "Launch file";

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = "${file}"; -- This configuration will launch the current file if used.
        pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                return cwd .. '/.venv/bin/python'
            else
                return '/usr/bin/python'
            end
        end;
    },
}

------------------------
--C/C++/Rust Debugging--
--------------------------

local dap = require('dap')
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
    name = 'lldb'
}

dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        args = {},

        -- 💀
        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html

        runInTerminal = false,
    },
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

----------------
--Go Debugging--
----------------

dap.adapters.go = {
    type = 'executable';
    command = 'node';
    args = {os.getenv('HOME') .. '/dev/golang/vscode-go/dist/debugAdapter.js'};
}

dap.configurations.go = {
    {
        type = 'go';
        name = 'Debug';
        request = 'launch';
        showLog = false;
        program = "${file}";
        dlvToolPath = vim.fn.exepath('dlv')  -- Adjust to where delve is installed
    },
}
