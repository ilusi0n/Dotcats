if !exists("g:syntax_js")
    let g:syntax_js = []
endif

syntax match jsFunc /\<function\>/ nextgroup=jsFuncName,jsFuncParams skipwhite display
syntax match jsFuncName contained /\<\k\+\>/ nextgroup=jsFuncParams skipwhite display
syntax region jsFuncParams contained matchgroup=jsFuncParens start=/(/ end=/)/ nextgroup=jsFuncBlock contains=@jsComment,jsFuncParam skipwhite skipempty
syntax match jsFuncParam contained /\<\k\+\>/ display
syntax region jsFuncBlock contained matchgroup=jsFuncBraces start=/{/ end=/}/ contains=@jsAll fold

if (has('conceal') && &enc=="utf-8")

    if count(g:syntax_js, 'function')
        syntax match jsConcealFunction contained /function/ containedin=jsFunc conceal cchar=ƒ
        hi def link jsConcealFunction jsFunc
    endif
endif
