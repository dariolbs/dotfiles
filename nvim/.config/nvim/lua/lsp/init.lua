-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
vim.keymap.set('n', 'gp', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'gn', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})


local function lsp_settings()

vim.diagnostic.config({

    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,

    float = {
        focusable = false,
        style = 'minimal',
        -- border = 'rounded',
        border = 'single',
        source = 'always',
        header = '',
        prefix = '',
    },
})

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = 'rounded'}
    )

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {border = 'rounded'}
    )

    local command = vim.api.nvim_create_user_command

    command('LspWorkspaceAdd', function()
        vim.lsp.buf.add_workspace_folder()
    end, {desc = 'Add folder to workspace'})

    command('LspWorkspaceList', function()
        vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, {desc = 'List workspace folders'})

    command('LspWorkspaceRemove', function()
        vim.lsp.buf.remove_workspace_folder()
    end, {desc = 'Remove folder from workspace'})
end

-- Snippet engine setup

local luasnip = require('luasnip')

luasnip.config.set_config({
    region_check_events = 'InsertEnter',
    delete_check_events = 'InsertLeave'
})


-- Chad symbols
-- sign({name = 'DiagnosticSignError', text = 'E'})
-- sign({name = 'DiagnosticSignWarn', text = 'W'})
-- sign({name = 'DiagnosticSignHint', text = 'H'})
-- sign({name = 'DiagnosticSignInfo', text = 'I'})

-- Virgin symbols
-- sign({name = 'DiagnosticSignError', text = ''})
-- sign({name = 'DiagnosticSignWarn', text = ''})
-- sign({name = 'DiagnosticSignHint', text = ''})
-- sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({

    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,

    float = {
        focusable = false,
        style = 'minimal',
        -- border = 'rounded',
        -- border = 'single',
        source = 'always',
        header = '',
        prefix = '',
    },
})

require('luasnip.loaders.from_vscode').lazy_load()
require("lsp.language_servers")
require("lsp.dap")
