function Pintanela(color)
    color = color or "gruvbox"
    vim.cmd.colorscheme(color)
    --vim.g.transparent_enabled = true

    --vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    -- Selected text color
    vim.cmd([[:highlight visual guibg=#666666]])
end

vim.o.background = 'dark'
vim.o.termguicolors = true

Pintanela("onedark")
