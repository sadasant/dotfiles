" .vim/plugin/functions.vim
" By Daniel R. (sadasant.com)

com! -nargs=+ Sadasant call Sadasant(<f-args>)

function! Sadasant(name, ...)
  if a:name == "grep"
    :call call (function('SadasantGrep'), a:000)
  endif
endfunction

function! SadasantGrep(type, match)
  if a:type ==? "v"
    :exe "bel vnew | r!grep -rin ".a:match." ".expand("%:p:h")
  endif
endfunction

