local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

--Plugins
map("n", "<A-w>", "<C-w>w")
map("n", "<A-t>", ":TransparentToggle<CR>")
map('n', '<A-n>', ':NERDTreeToggle<CR>')
map('n', '<A-i>', ':IndentLinesToggle<CR>')

--Normal Mode Bidnings
map("n", ",s", "<Esc>i#!/usr/bin/")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-j>", ":tabprevious<CR>")
map("n", "<C-k>", ":tabnext<CR>")
map("n", "<S-w>", ":w<CR>")
map("n", "<F1>", "<Esc>")
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', '<A-w>', '<C-w>w')

--Visual Mode Bindings
map("v", "<C-u>", "<C-u>zz")
map("v", "<C-d>", "<C-d>zz")
map("v", "<F1>", "<Esc>")
map("v", "e", "0")
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")
map('v', '<Space>y', "\"+y")

--Insert Mode Bindings
map("i", "<F1>", "<Esc>")
