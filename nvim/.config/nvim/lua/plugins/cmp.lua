-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
--local lsp = require('lsp-zero')

require("nvim-autopairs").setup {}

local cmp = require('cmp')

local cmp_select = { behaviour = cmp.SelectBehavior.Select}

local cmp_kinds = {
  Text = "  ",
  Method = "󰆧  ",
  Function = "󰊕  ",
  Constructor = "  ",
  Field = "󰇽  ",
  Variable = "󰂡  ",
  Class = "󰠱  ",
  Interface = "  ",
  Module = "  ",
  Property = "󰜢  ",
  Unit = "  ",
  Value = "󰎠  ",
  Enum = "  ",
  Keyword = "󰌋  ",
  Snippet = "  ",
  Color = "󰏘  ",
  File = "󰈙  ",
  Reference = "  ",
  Folder = "󰉋  ",
  EnumMember = "  ",
  Constant = "󰏿  ",
  Struct = "  ",
  Event = "  ",
  Operator = "󰆕  ",
  TypeParameter = "󰅲  ",
}


cmp.setup({

    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    -- Display icons
    formatting = {
        format = function(_, vim_item)
          vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
          return vim_item
        end,
    },
    window = {
        -- Window Settings
        -- completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item()),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item()),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item()),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item()),
    ['<C-l>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    },
    ['<C-p>'] = cmp.mapping.scroll_docs(-4),
    ['<C-n>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    --['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
      }, {
      { name = 'buffer' },
    });
  })
