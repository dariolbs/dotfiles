-- Toggle colorcolumn
vim.opt.colorcolumn = "0"
ColState = 0

function ToggleColorCol()

    if ColState == 0 then
        vim.opt.colorcolumn = "80"
        ColState = 80
    else
        vim.opt.colorcolumn = "0"
        ColState = 0
    end
end

-- Mappings
vim.keymap.set("n", "<C-y>", ":lua ToggleColorCol()<CR>", {silent = true})
