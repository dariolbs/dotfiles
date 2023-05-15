function ToggleCursorLine()
    vim.o.cursorline = not vim.o.cursorline;
end

function ToggleFullTrasparency()
    vim.o.cursorline = not vim.o.cursorline;
    vim.cmd([[:TransparentToggle]]);
end
