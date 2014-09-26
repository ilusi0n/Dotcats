function! WordProcessorMode()
  setlocal formatoptions=1
  setlocal noexpandtab
  setlocal spell spelllang=en
  set thesaurus+=/home/miguel/.vim/thesaurus/mthesaur.txt
  set complete+=s
  setlocal wrap
  setlocal linebreak
endfu

com! WP call WordProcessorMode()
