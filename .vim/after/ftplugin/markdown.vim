" VIM Markdown after/ftplugin
" Maintainer:   Daniel Rodríguez <djrs@sadasant.com>
" URL:          https://github.com/sadasant/dotfiles
" Last Change:  2012 Nov 17

set shiftwidth=4
set autoindent
set smartindent
set expandtab
set tabstop=4
set smarttab
filetype plugin indent on

" Fold all the lists
fu! FoldCurrentList()
  set foldmethod=manual
  if foldlevel('.') == 0
    let here = line('.')
    exe ":" . (here + 1)
    exe "?^-"
    let l0 = line(".")
    if here < l0
      exe ":" . here
      return
    endif
    /\(\n\(\n^-   .*$\)\|\%$\)\@=/
    let l1 = line(".")
    exe l0 . "," . l1 . " fold"
    exe ":" . here
  else
    " Delete the fold on the current line
    normal zd
  endif
endfu

" Fold all the lists
fu! FoldAllLists()
  set foldmethod=manual
  " Delete all the folds
  normal zE
  let here = line('.')
  let last = line('$')
  :0
  while last != line(".")
    /^-/
    let l0 = line(".")
    /\(\n\(\n^-   .*$\)\|\%$\)\@=/
    let l1 = line(".")
    exe l0 . "," . l1 . " fold"
  endwhile
  exe ":" . here
endfu

nmap zl :call FoldCurrentList()<CR>
nmap zL :call FoldAllLists()<CR>
