function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename . " "
  call append(2, "")
  execute "normal! Go#endif /* " . gatename . " */"
  normal! 3G
endfunction

autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()
