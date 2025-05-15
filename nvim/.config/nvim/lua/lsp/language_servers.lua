-- Configuration for alll language servers

-- Pyright

require'lspconfig'.pyright.setup{
    cmd = { "/home/dario/.venv/bin/pyright-langserver", "--stdio" },
    single_file_support = true,
}

-- Clangd

require'lspconfig'.clangd.setup{}

-- Bash language server

require'lspconfig'.bashls.setup{

    cmd = { "bash-language-server", "start" }
}

-- Typescript/Javascript language server

require'lspconfig'.ts_ls.setup{

    cmd = { "typescript-language-server", "--stdio" },
}

-- Go language server

require'lspconfig'.gopls.setup{

    cmd = { "gopls" }
}

-- Awk language server

require'lspconfig'.awk_ls.setup{

    cmd = { "awk-language-server" }
}

-- Haskell language server

require('lspconfig')['hls'].setup{
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
}

-- LaTex language server

require'lspconfig'.texlab.setup{}

-- SQL Language server

require'lspconfig'.sqlls.setup{}

-- Perl

require'lspconfig'.perlnavigator.setup{
    cmd = { "perlnavigator" },
    settings = {
      perlnavigator = {
          perlPath = 'perl',
          enableWarnings = true,
          perltidyProfile = '',
          perlcriticProfile = '',
          perlcriticEnabled = true,
      }
    }
}

-- Lua language server

require'lspconfig'.lua_ls.setup {
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                            -- "${3rd}/luv/library"
                            -- "${3rd}/busted/library",
                        }
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                }
            })
            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
    end
}
