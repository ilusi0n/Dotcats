
function! HackerNewsInit()
  if bufexists('hackernews')
    bdelete hackernews
  endif

  split hackernews
  setlocal modifiable
  setlocal foldlevel=0

ruby << EOF

  require 'open-uri'
  require 'json'

  open('http://api.ihackernews.com/page') do |io|
    urls = []
    posts = JSON.parse(io.read)
    posts['items'].each do |item|
      line = "%-80s" % [item['title']] 
      VIM::Buffer.current.append(VIM::Buffer.current.count, line)
      line = "\t%3d points | posted %s" % [item['points'], item['postedAgo']]
      VIM::Buffer.current.append(VIM::Buffer.current.count, line)
      VIM::Buffer.current.append( VIM::Buffer.current.count,"")
      urls << '"' + item['url'] + '"'
    end
    #VIM::command("let urls=[#{urls.join(',')}]")
    VIM::Buffer.current.delete(1)
    VIM::command("let s:urls=[#{urls.join(',')}]")
  end
EOF

  function! OpenHackerNewsPost(line, post)
ruby << EOF
    require 'json'
    require 'open-uri'
      b.append(0, "[213]")
    b = VIM::Buffer.current
    puts "opening #{VIM::evaluate('a:post')}..."
    open(VIM::evaluate("a:post")) do |io|
      comments = JSON.parse(io.read)['comments']
      b.append(VIM::evaluate("a:line"), "\t#{comments[0]['comment']}")
    end
EOF
  endfunction

  function! OpenHackerNewsPostURL()
    let l:line = line('.')
    if l:line % 3 != 1 
      return
    endif
    call system("firefox " . s:urls[ (l:line-1)/3 ])
  endfunction

  nmap <buffer>o :call OpenHackerNewsPostURL()<cr>
  nnoremap <buffer>j jjj
  nnoremap <buffer>k kkk

  setlocal nomodifiable readonly nomodified bufhidden=wipe
  syn match points '\d\+ \(points\)\@='
  syn match timeelapsed '\d\+ [a-z]\+ ago$'
  syn match title '^[^\t].\+'  
  hi def link points Constant
  hi def link timeelapsed Type
  hi def link title Comment

endfunction

command! HN call HackerNewsInit()
