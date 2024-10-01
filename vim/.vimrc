"------------------------------------------------------------------------------
" Normal Mode
"------------------------------------------------------------------------------

nnoremap ,s <Esc>i#!/usr/bin/
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <F1> <Esc>

"------------------------------------------------------------------------------
" Visual Mode
"------------------------------------------------------------------------------

vnoremap <C-u> <C-u>zz
vnoremap <C-d> <C-d>zz
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
vnoremap <F1> <Esc>

set nocompatible
filetype plugin on
syntax on

:set number
:set relativenumber
"set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
"set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set wildmode=longest,list   " get bash-like tab completions

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

filetype plugin indent on   "allow auto-indenting depending on file type
set mouse=a                 " enable mouse click
"set clipboard=unnamedplus   " using system clipboard
set noswapfile            " disable creating swap file
set backupdir=~/.cache/vim " Directory to store backup files.

"if has('termguicolors')
"	    " Turns on true terminal colors
"	    " let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"	    " let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"	    set termguicolors
"	    set t_Co=256
"endif

"Languages
autocmd Filetype tex set spelllang=pt | set spell

"Initial commands
"set cursorline
set background=dark
"colorscheme gruvbox
