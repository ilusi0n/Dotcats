fu! s:CompareLines(l1, l2)
    return len(a:l2) - len(a:l1)
endf

fu! Sortlines () range
    let l:currentline = line("'<")
    let l:lines = []
    
    while l:currentline <= line("'>")
        call insert(l:lines, getline(l:currentline))
        let l:currentline = l:currentline + 1
    endwh

    let l:lines = sort(l:lines, "s:CompareLines")
    let l:currentline = line("'<")
    
    while l:currentline <= line("'>")
        execute l:currentline."s/^.*$/\\=escape("'l:lines[0]'",'')/"
        call remove(l:lines, 0)
        let l:currentline = l:currentline + 1
    endwhile
endf

" [range]!awk '{ print length, $0 | \"sort -n\" } | cut -d' ' -f 2-'

vmap <leader>s :call Sortlines()<cr>
command! -range SortLines '<,'>call Sortlines()
