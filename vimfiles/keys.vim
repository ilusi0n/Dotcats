let mapleader = "\<space>"

" Normal Mode
nnoremap <C-l> :vertical resize +5<cr>
nnoremap <C-h> :vertical resize -5<cr>
nnoremap <C-k> :resize -5<cr>
nnoremap <C-j> :resize +5<cr>
nnoremap <leader>r :w <cr> :source %<cr>
nnoremap <leader>h :Startify<cr>
nnoremap - : 
nnoremap <tab> :
if has('win32')
    " We really should make this more transparent
    nnoremap <F12> :tabnew! $HOME/_vimrc<cr>
else
    nnoremap <F12> :tabnew! $HOME/.vimrc<cr>
end
for x in range(1,10)
    execute "nnoremap <silent><M-".x."> :".x."wincmd w<CR>"
    execute "nnoremap <silent><leader>t".x." ".x."gt"
endfor

" Insertion Mode
inoremap jk <esc>

" Command mode
cmap <C-a> <home>
cmap <C-e> <end>
cmap <C-k> <Up>
cmap <C-j> <Down>

nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
vmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
nmap <silent> --h :help <cword> cr>
