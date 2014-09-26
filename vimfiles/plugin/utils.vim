function! UInsertHeader(d)
  let l:target = getpos("'<")[1:3]
  let l:end    = getpos("'>")[2]
  let l:line   = getline('.')[(l:target[1]-1):l:end]
  let l:length = len(l:line)
endf
