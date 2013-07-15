" .vim/plugin/functions.vim
" By Daniel R. (sadasant.com)

com! -nargs=+ Sadasant call Sadasant(<f-args>)

function! Sadasant(name, ...)
  if a:name == "grep"
    :call call (function('SadasantGrep'), a:000)
  endif
endfunction

function! SadasantGrep(type, ...)
  let match = a:0
  if !match
    call inputsave()
    let match = input('Enter search string: ')
    call inputrestore()
  endif
  if a:type ==? "v"
    :exe "bel vnew | r!grep -rin ".match." ".expand("%:p:h")
  endif
endfunction

