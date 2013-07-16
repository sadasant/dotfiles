" .vim/plugin/functions.vim
" By Daniel R. (sadasant.com)

com! -nargs=+ Sadasant call Sadasant(<f-args>)

function! Sadasant(name, ...)
  if a:name == "find"
    :call call (function('SadasantFind'), a:000)
  endif
endfunction

function! SadasantFind(type, ...)
  let match = a:0
  if !match
    call inputsave()
    let match = input('Enter search string: ')
    call inputrestore()
  endif
  if a:type ==? "v"
    :exe "bel vnew | r!grep -rin ".match." ".expand("%:p:h")
  elseif a:type ==? "h"
    :exe "bel 13new | r!grep -rin ".match." ".expand("%:p:h")
  endif
  " Enter to open the file under the cursor line at the position given by grep
  :exe "nnoremap <buffer> <Enter> 0:wincmd F<cr>"
  " h and l will look for the prev/next occurrence of a line start or matched content
  :exe "nnoremap <buffer> h ?\\(\\(\\/.*:\\d*:\\)\\@<=\\)\\\\|^<cr>zs20zh"
  :exe "nnoremap <buffer> l /\\(\\(\\/.*:\\d*:\\)\\@<=\\)\\\\|^<cr>zs20zh"
  " j and k will look for the next/prev matched content
  :exe "nnoremap <buffer> j /\\(\\/.*:\\d*:\\)\\@<=<cr>zs20zh"
  :exe "nnoremap <buffer> k ?\\(\\/.*:\\d*:\\)\\@<=<cr>zs20zh"
  :exe "nnoremap <buffer> q :q!<cr>"
endfunction

