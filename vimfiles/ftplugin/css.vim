fu! s:CssTagChange()
  let x = input('')
  execute 's/\(^ *[a-zA-Z\-]\+ *: *\)[a-zA-Z\-]\+/\1'.x.'/'
endfu

fun! s:CssTagInsert()
  let key = input('')
  let val = input('')
  if key == "" || val == ""
    return
  endif
  call append(line('.'), key.':'.val.';')
  execute 'normal j==$'
endf

fun! s:CssStartRule()"
  let tag = input('')
  call append(line('.'), [tag.' {', '', '}'])
  execute 'normal jj'
endfu

nmap \c :call s:CssTagChange()<cr>
nmap \i :call s:CssTagInsert()<cr>
nmap \t :call s:CssStartRule()<cr>
