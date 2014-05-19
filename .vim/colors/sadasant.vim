" VIM colors scheme.
" Name:     sadasant.vim
" Author:   Daniel Rodríguez <djrs@sadasant.com>
" Version:  2.0
" License:  http://sadasant.com/license

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "sadasant"

" General colors
hi Normal           ctermfg=white       ctermbg=NONE        cterm=NONE
hi NonText          ctermfg=NONE        ctermbg=NONE        cterm=NONE

hi Cursor           ctermfg=black       ctermbg=NONE        cterm=NONE
hi CursorColumn     ctermfg=NONE        ctermbg=NONE        cterm=BOLD
hi CursorLine       ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi CursorLineNr     ctermfg=white       ctermbg=233         cterm=BOLD
hi LineNr           ctermfg=240         ctermbg=232         cterm=NONE

hi StatusLine       ctermfg=244         ctermbg=234         cterm=NONE
hi StatusLineNC     ctermfg=240         ctermbg=233         cterm=NONE

hi Pmenu            ctermfg=gray        ctermbg=NONE        cterm=NONE
hi PmenuSbar        ctermfg=black       ctermbg=white       cterm=NONE
hi PmenuSel         ctermfg=white       ctermbg=NONE        cterm=NONE

hi Title            ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi VertSplit        ctermfg=233         ctermbg=233         cterm=NONE
hi WildMenu         ctermfg=white       ctermbg=237         cterm=NONE

hi Folded           ctermfg=gray        ctermbg=233         cterm=NONE
hi Visual           ctermfg=NONE        ctermbg=darkgray    cterm=NONE
hi SpecialKey       ctermfg=235         ctermbg=NONE        cterm=UNDERLINE

hi Error            ctermfg=black       ctermbg=red         cterm=NONE
hi ErrorMsg         ctermfg=black       ctermbg=red         cterm=NONE
hi WarningMsg       ctermfg=black       ctermbg=red         cterm=NONE
hi LongLineWarning  ctermfg=NONE        ctermbg=NONE        cterm=underline

hi ModeMsg          ctermfg=16          ctermbg=8           cterm=BOLD

hi MatchParen       ctermfg=white       ctermbg=darkgray    cterm=BOLD
hi Search           ctermfg=black       ctermbg=yellow      cterm=NONE

hi Comment          ctermfg=237         ctermbg=NONE        cterm=NONE
hi Todo             ctermfg=red         ctermbg=NONE        cterm=NONE

hi String           ctermfg=gray        ctermbg=NONE        cterm=NONE
hi Number           ctermfg=gray        ctermbg=NONE        cterm=BOLD
hi Constant         ctermfg=gray        ctermbg=NONE        cterm=BOLD
hi Keyword          ctermfg=white       ctermbg=NONE        cterm=BOLD
hi PreProc          ctermfg=gray        ctermbg=NONE        cterm=BOLD
hi Conditional      ctermfg=white       ctermbg=NONE        cterm=BOLD
hi Identifier       ctermfg=gray        ctermbg=NONE        cterm=BOLD
hi Function         ctermfg=white       ctermbg=NONE        cterm=NONE
hi Type             ctermfg=white       ctermbg=NONE        cterm=NONE
hi Statement        ctermfg=white       ctermbg=NONE        cterm=BOLD
hi Special          ctermfg=gray        ctermbg=NONE        cterm=BOLD
hi Delimiter        ctermfg=white       ctermbg=NONE        cterm=BOLD
hi Operator         ctermfg=gray        ctermbg=NONE        cterm=BOLD

hi DiffAdd          ctermfg=green       ctermbg=232         cterm=NONE
hi DiffChange       ctermfg=darkgray    ctermbg=233         cterm=NONE
hi DiffDelete       ctermfg=darkred     ctermbg=232         cterm=NONE
hi DiffText         ctermfg=blue        ctermbg=232         cterm=NONE

hi Directory        ctermfg=gray        ctermbg=NONE        cterm=NONE
hi Ignore           ctermfg=NONE        ctermbg=NONE        cterm=NONE

hi TabNum           ctermfg=240         ctermbg=233         cterm=NONE
hi TabNumSel        ctermfg=white       ctermbg=235         cterm=NONE
hi TabLine          ctermfg=240         ctermbg=233         cterm=NONE
hi TabLineSel       ctermfg=white       ctermbg=235         cterm=NONE
hi TabLineFill      ctermfg=240         ctermbg=NONE        cterm=NONE

hi link Character       Constant
hi link Boolean         Constant
hi link Float           Number
hi link Repeat          Statement
hi link Label           Statement
hi link Exception       Statement
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc
hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type
hi link Tag             Special
hi link SpecialChar     Special
hi link SpecialComment  Special
hi link Debug           Special

" Special for XML
hi link xmlTag          Keyword
hi link xmlTagName      Conditional
hi link xmlEndTag       Identifier

" Special for HTML
hi link htmlTag         Keyword
hi link htmlTagName     Conditional
hi link htmlEndTag      Identifier

" Special for Javascript
hi link javaScriptNumber      Number

if &t_Co != 256
    hi Normal        ctermfg=NONE      ctermbg=NONE   cterm=NONE
    hi LineNr        ctermfg=darkgrey  ctermbg=NONE   cterm=BOLD
    hi StatusLine    ctermfg=white     ctermbg=blue   cterm=NONE
    hi StatusLineNC  ctermfg=cyan      ctermbg=blue   cterm=NONE
    hi VertSplit     ctermfg=NONE      ctermbg=NONE   cterm=NONE
    hi Folded        ctermfg=black     ctermbg=cyan   cterm=NONE
    hi Visual        ctermfg=darkgray  ctermbg=green  cterm=NONE
    hi SpecialKey    ctermfg=NONE      ctermbg=NONE   cterm=NONE
    hi MatchParen    ctermfg=NONE      ctermbg=NONE   cterm=REVERSE
    hi Comment       ctermfg=blue      ctermbg=NONE   cterm=NONE
    hi String        ctermfg=cyan      ctermbg=NONE   cterm=NONE
    hi Number        ctermfg=green     ctermbg=NONE   cterm=BOLD
    hi Constant      ctermfg=green     ctermbg=NONE   cterm=BOLD
    hi Keyword       ctermfg=white     ctermbg=NONE   cterm=BOLD
    hi PreProc       ctermfg=gray      ctermbg=NONE   cterm=BOLD
    hi Conditional   ctermfg=white     ctermbg=NONE   cterm=BOLD
    hi Identifier    ctermfg=gray      ctermbg=NONE   cterm=BOLD
    hi Function      ctermfg=white     ctermbg=NONE   cterm=NONE
    hi Type          ctermfg=white     ctermbg=NONE   cterm=NONE
    hi Statement     ctermfg=white     ctermbg=NONE   cterm=BOLD
    hi Special       ctermfg=yellow    ctermbg=NONE   cterm=NONE
    hi Delimiter     ctermfg=white     ctermbg=NONE   cterm=NONE
    hi Operator      ctermfg=gray      ctermbg=NONE   cterm=BOLD
    hi TabNum        ctermfg=cyan      ctermbg=blue   cterm=NONE
    hi TabNumSel     ctermfg=white     ctermbg=blue   cterm=NONE
    hi TabLine       ctermfg=cyan      ctermbg=blue   cterm=NONE
    hi TabLineSel    ctermfg=white     ctermbg=blue   cterm=NONE
    hi TabLineFill   ctermfg=NONE      ctermbg=NONE   cterm=NONE
endif
