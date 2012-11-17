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
fu! FoldLists()
  set foldmethod=manual
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
