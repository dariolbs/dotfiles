Term = require("toggleterm")

Term.setup{
    open_mapping = [[<c-t>]],
    direction = "float",
    float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    border = 'curved'
  },
}

function Horizontal_Termm()
    vim.cmd("ToggleTerm direction=horizontal")
end

vim.keymap.set("n", ":horiz_term",  ":lua Horizontal_Termm()<CR>", {silent = true})
vim.keymap.set("n", ":vert_term",   ":ToggleTerm<CR>", {silent = true})
