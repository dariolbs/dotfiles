local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

--Plugins
map("n", "<A-t>", ":TransparentToggle<CR>")
map("n", "gs", ":Git<CR>")

--Normal mode Bindings
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- ,q -> Insert double quotes in 
map('n', ',q', 'Bi"<Esc>Ea"<Esc>')
-- ,s -> Insert shebang
map("n", ",s", "<Esc>i#!/usr/bin/")


--Visual Mode Bindings
map("v", "<C-u>", "<C-u>zz")
map("v", "<C-d>", "<C-d>zz")
map("v", "<F1>", "<Esc>")
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")
map('v', '<space>y', "\"+y")

--Insert Mode Bindings
map("i", "<F1>", "<Esc>")
