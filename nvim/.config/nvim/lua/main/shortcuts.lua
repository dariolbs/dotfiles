local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

map("n", ".cb", "<Esc>I#include <stdio.h><Esc>o#include <stdlib.h><Esc>o")
map("n", ".s", "<Esc>i#!/usr/bin/")
