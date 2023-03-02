"Plugin Bindings

nnoremap <A-n> :NERDTreeToggle<CR>
nnoremap <A-w> <C-w>w
nnoremap <A-t> :TransparentToggle<CR>

"Normal Mode Bidnings
nnoremap ,s <Esc>i#!/usr/bin/
nnoremap <S-k> <C-u>zz
nnoremap <S-j> <C-d>zz
nnoremap <S-w> :w<CR>
nnoremap <F1> <Esc>
nnoremap B <C-v>
nnoremap e 0
nnoremap E $

"Visual Mode Bindings
vnoremap <S-k> <C-u>zz
vnoremap <S-j> <C-d>zz
vnoremap <F1> <Esc>
vnoremap e 0
vnoremap E $

"Insert Mode Bindings
inoremap <F1> <Esc>

"Shell
autocmd Filetype sh nnoremap ,if iif<Space>[<Space><Space>];<Space>then<Esc>ofi<Esc>kf]hi
autocmd Filetype sh nnoremap ,for ifor<Space>i<Space>in<Space>;<Space>do<Esc>odone<Esc>kf;i
autocmd Filetype sh nnoremap ,ma i$(())<Esc>hi
autocmd Filetype sh nnoremap ,arr i${[@]}<Esc>hhhi
"LaTeX
autocmd Filetype plaintex nnoremap ,bs i\documentclass{}<Esc>oauthor{Dário Batista}<Enter>\title<Enter>\begin{document}<Enter>\end{document}
autocmd Filetype tex nnoremap ,sec i\section{}<Esc>i
autocmd Filetype tex nnoremap ,sub i\subsection{}<Esc>i
autocmd Filetype tex nnoremap ,ch i\chapter{}<Esc>i
autocmd Filetype tex nnoremap ,it i\textit{}<Esc>i
autocmd Filetype tex nnoremap ,em i\emph{}<Esc>i
autocmd Filetype tex nnoremap ,bf i\textbf{}<Esc>i
autocmd Filetype tex nnoremap ,pic i\includegraphics{}<Esc>i
autocmd Filetype tex nnoremap ,ma i\begin{math}<Enter><Enter>\end{math}<Esc>ki
"Html
autocmd Filetype html nnoremap ,b i<html><Enter><body><Enter><h1></h1><Enter><p></p><Enter></body><Enter></html>
autocmd Filetype html nnoremap ,p i<p></p><Esc>3hi
autocmd Filetype html nnoremap ,h1 i<h1></h1><Esc>4hi
autocmd Filetype html nnoremap ,h2 i<h2></h2><Esc>4hi
autocmd Filetype html nnoremap ,h3 i<h3></h3><Esc>4hi
autocmd Filetype html nnoremap ,h4 i<h4></h4><Esc>4hi
autocmd Filetype html nnoremap ,h5 i<h5></h5><Esc>4hi
autocmd Filetype html nnoremap ,h6 i<h6></h6><Esc>4hi
