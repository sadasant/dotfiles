" Vim syntax file
" Language: POSXML
" Maintainer: Daniel Rodríguez <sadasant@cloudwalk.io>
" URL:        https://github.com/sadasant/vim-posxml
" Version:    1
" Last Change: 2015 Aug 26
" Remark:      Uses HTML syntax file
" TODO:        All the things

" Read the HTML syntax to start with
if version < 600
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

syn spell toplevel
syn case ignore
syn sync linebreaks=1

