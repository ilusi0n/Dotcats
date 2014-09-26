function! MpcLs()
  if bufexists('hackernews')
    bdelete hackernews
  endif

  split hackernews
  setlocal modifiable
  setlocal foldlevel=0
  
  syn match artist  '^[a-zA-Z ]*'
  syn match title '[^-]*$'
  hi def link artist Type 
  hi def link title Type

  let l:pl = split(system("mpc playlist"), '\n')

  call append(0, l:pl)
  normal dd
  setlocal nomodifiable readonly nomodified bufhidden=wipe

  nmap <buffer>o :call MpcPlayThis()<cr>
  nmap <buffer>p :call MpcToggle()<cr>
  nmap <buffer>b :call MpcBack()<cr>

endfunction

function! MpcBack()
  let l:t = getline(line('.'))
  call MpcDirLs(join(remove(split(l:t, '/'), 0, -2),'/'))
endfunction

function! MpcToggle()
  call system("mpc toggle")
endfunction

function! MpcPlayThis()
  let l:pos = line('.')
  call system("mpc play ".l:pos)
endfunction

function! BuildPath(a,b)
  if a:a
    return a:a . '/' . a:b
  else
    return a:b
  endif
endfunction

function! MpcDirLs(relative)
  if bufexists('hackernews')
    bdelete mpddir
  endif

  split mpddir
  setlocal modifiable
  setlocal foldlevel=0

  let l:log = 'Opening '. a:relative
  call append(0, l:log)

  let l:pl = split(system("mpc ls '".a:relative . "'"), '\n')
  for l:track in l:pl
    let l:track = BuildPath(a:relative, l:track)
    call append(0, l:track)
  endfor

  normal ddgg
  setlocal nomodifiable readonly nomodified bufhidden=wipe

  nmap <buffer>o :call MpcDirLs(getline(line('.')))<cr>
  nmap <buffer>a :call MpcAddTrack()<cr>
endfunction

function! MpcAddTrack()
  let l:track = getline(line('.'))
  call system("mpc add '" . l:track . "'")
  cal MpcLs()
endfunction

command! MPC call MpcLs()
