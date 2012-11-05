" VIM colors scheme.
" by Daniel Rodríguez @sadasant
" http://sadasant.com/license
"

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "sadasant"

" General colors
hi Comment          ctermfg=237         ctermbg=NONE        cterm=NONE
hi Conditional      ctermfg=white       ctermbg=NONE        cterm=BOLD
hi Constant         ctermfg=gray        ctermbg=NONE        cterm=BOLD
hi CursorColumn     ctermfg=NONE        ctermbg=NONE        cterm=BOLD
hi Cursor           ctermfg=black       ctermbg=NONE        cterm=NONE
hi CursorLine       ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi CursorLineNr     ctermfg=white       ctermbg=233         cterm=BOLD
hi Directory        ctermfg=gray        ctermbg=NONE        cterm=NONE
hi Delimiter        ctermfg=white       ctermbg=NONE        cterm=BOLD
hi Error            ctermfg=black       ctermbg=red         cterm=NONE
hi ErrorMsg         ctermfg=black       ctermbg=red         cterm=NONE
hi Folded           ctermfg=gray        ctermbg=NONE        cterm=NONE
hi Function         ctermfg=white       ctermbg=NONE        cterm=NONE
hi Identifier       ctermfg=gray        ctermbg=NONE        cterm=BOLD
hi Ignore           ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi Keyword          ctermfg=white       ctermbg=NONE        cterm=BOLD
hi LineNr           ctermfg=240         ctermbg=232         cterm=NONE
hi MatchParen       ctermfg=black       ctermbg=white       cterm=BOLD
hi ModeMsg          ctermfg=16          ctermbg=white       cterm=BOLD
hi NonText          ctermfg=gray        ctermbg=NONE        cterm=NONE
hi Normal           ctermfg=white       ctermbg=NONE        cterm=NONE
hi Number           ctermfg=gray        ctermbg=NONE        cterm=BOLD
hi Operator         ctermfg=gray        ctermbg=NONE        cterm=BOLD
hi Pmenu            ctermfg=gray        ctermbg=NONE        cterm=NONE
hi PmenuSbar        ctermfg=black       ctermbg=white       cterm=NONE
hi PmenuSel         ctermfg=white       ctermbg=NONE        cterm=NONE
hi PreProc          ctermfg=gray        ctermbg=NONE        cterm=BOLD
hi Search           ctermfg=NONE        ctermbg=NONE        cterm=UNDERLINE
hi Special          ctermfg=gray        ctermbg=NONE        cterm=BOLD
hi SpecialKey       ctermfg=52          ctermbg=NONE        cterm=NONE
hi Statement        ctermfg=white       ctermbg=NONE        cterm=BOLD
hi StatusLine       ctermfg=white       ctermbg=233         cterm=BOLD
hi StatusLineNC     ctermfg=240         ctermbg=233         cterm=NONE
hi String           ctermfg=gray        ctermbg=NONE        cterm=NONE
hi TabLine          ctermfg=black       ctermbg=white       cterm=NONE
hi TabLineSel       ctermfg=white       ctermbg=232         cterm=NONE
hi Title            ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi Todo             ctermfg=red         ctermbg=NONE        cterm=NONE
hi Type             ctermfg=white       ctermbg=NONE        cterm=NONE
hi VertSplit        ctermfg=233         ctermbg=233         cterm=NONE
hi Visual           ctermfg=NONE        ctermbg=darkgray    cterm=NONE
hi WarningMsg       ctermfg=black       ctermbg=red         cterm=NONE
hi WildMenu         ctermfg=white       ctermbg=237         cterm=NONE

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
