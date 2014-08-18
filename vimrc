colorscheme kolor

set guifont=Source\ Code\ Pro\ Semibold\ 9

set autoread "Set to auto read when a file is changed from the outside
set tabstop=4
set shiftwidth=4
set showmatch
filetype plugin on
filetype indent on
syntax enable
set noswapfile
set cursorline
set number
set smartcase " When searching try to be smart about cases 
set tabstop=2
set title
set backspace=indent,eol,start
set ruler "Always show current position
set ignorecase " Ignore case when searching
set hlsearch " Ignore case when searching

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent
set wrap "Wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2


" limite comentary by 80
" gq}
set textwidth=80

" Reformat paragraphs and list.
nnoremap R gq}

nmap <F2> gg=G

imap <C-W> <ESC><C-W>
" copy
vmap <C-C> y
" paste
nmap <C-V> p
imap <C-V> <C-O>p
" undo
noremap <C-Z> u
inoremap <C-Z> <C-O>u
