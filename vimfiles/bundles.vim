"p'p'-- Vundle -------------------------------------------------------------------

set nocompatible
filetype off

set rtp+=$HOME/$VIMFILES/bundle/vundle/
"set rtp+=$HOME/$VIMFILES/plugins

call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/SearchComplete'
Bundle 'msanders/snipmate.vim'
Bundle 'mhinz/vim-startify'
Bundle 'kien/ctrlp.vim'
Bundle 'Rip-Rip/clang_complete.git'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'itchyny/lightline.vim'
Bundle 'derekwyatt/vim-scala'
Bundle 'jnwhiteh/vim-golang'
Bundle 'davidhalter/jedi-vim'
Bundle 'nvie/vim-flake8'
Bundle 'mattn/emmet-vim'
Bundle 'ukima/xmledit'

function! InsertTag()
    let l:name = input(":")
    let @="<".l:name."> </".l:name.">"
    normal '"ap'
endfunction

nmap <leader>t :call InsertTag()<cr>

let g:ctrlp_user_command = ['.git',
      \'cd %s && git ls-files . -co --exclude-standard',
      \'find %s -type f']
let g:ctrlp_use_caching = 0
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'component': {
      \   'readonly': '%{&readonly?"⭤":""}',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

filetype plugin indent on 
syntax on
