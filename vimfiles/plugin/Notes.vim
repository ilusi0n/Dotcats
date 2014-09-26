fun! OpenFile()
execute 'e ' . getline(line('.'))
nmap <buffer> <leader>q :bd!<cr>
endfun

fun! OpenFileAtLine()
  let l:line = input("#: ")
  call cursor(l:line, 0)
  call OpenFile()
endfun

fun! OpenNotes()
  let l:notes = system("ls ~/Dropbox/*.note ")
  silent e notes
  setlocal modifiable
  0,$d
  silent 0put =l:notes
  setlocal nomodifiable readonly nomodified bufhidden=wipe
  nmap <buffer>o :call OpenFile()<cr>
  nmap <buffer> <leader>o :call OpenFileAtLine()<cr>
endfun

fun! NewNote()
  let l:notename = input("> ")
  execute 'e ~/Dropbox/' . l:notename . '.note'
endfun

nmap <silent> <leader>no :call OpenNotes()<cr>
nmap <leader>nn :call NewNote()<cr>
nmap <leader>ce :call Teste()<cr>
