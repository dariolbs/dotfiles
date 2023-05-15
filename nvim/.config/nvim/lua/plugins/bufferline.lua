vim.opt.termguicolors = true
local bufferline = require("bufferline")


bufferline.setup({
    options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or ""
            return " " .. icon .. count
        end
}
})
