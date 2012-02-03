" ASCIID
" By Daniel R. (sadasant.com)
" 11 Octo 2011

" MOVILITY
  " <F?> on fire
    imap <F1> <Left>
    map  <F1> h
    imap <F2> <Down>
    map  <F2> j
    imap <F3> <Up>
    map  <F3> k
    imap <F4> <Right>
    map  <F4> l
  " <F?> not arrows!
    map  <Up>    <nop>
    map  <Down>  <nop>
    map  <Left>  <nop>
    map  <Right> <nop>
  " lines around when scrolling
    set scrolloff=2

" SHORCUTS
  " save
    map <F5> :w<CR>
  " quit
    map <F6> :q

" INTERFACE
  " ignore the old vi
    set nocompatible
  " wrap when moving towards the limit of the line
    set whichwrap=[,],h,l
  " backspace everything on insert mode
    set backspace=eol,start,indent
  " help with the command line
    set wildmenu
  " too long? no wrap
    set nowrap
  " line numbers, babe
    set number
  " show the position of the cursor
    set ruler
  " show hidden characters, but only tabs for me, sir
    set list
    set listchars=tab:>-,trail:-
  " show the fancy status line
    set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*
  " show the status line always
    set laststatus=2
  syntax on

" COLORS
  colorscheme asciid

" SEARCH
  " ignore case when all is lowercase
    set smartcase
  " window to the current match
    set incsearch
  " search with \n like characters
    set magic

" NO BACKUPS
  set noswapfile
  set nobackup
  set nowb

" TABS AND IDENTATION
  set shiftwidth=2
  set autoindent
  set smartindent
  set expandtab
  set tabstop=2
  set smarttab

" CLOSING CHARACTERS
  inoremap {     {}<Left>
  inoremap {<CR> {<CR>}<Esc>0
  inoremap {{    {
  inoremap {}    {}
  inoremap [     []<Left>
  inoremap [<CR> [<CR>]<Esc>0
  inoremap [[    [
  inoremap []    []
  inoremap (     ()<Left>
  inoremap (<CR> (<CR>)<Esc>0
  inoremap ((    (
  inoremap ()    ()
  inoremap "     ""<Left>
  inoremap "<CR> "<CR>"<Esc>0
  inoremap ""    "
  inoremap ""    ""
  inoremap '     ''<Left>
  inoremap '<CR> '<CR>'<Esc>0
  inoremap ''    '
  inoremap ''    ''
  set showmatch

" BEHAVIOR
  " clear right whitespaces
  autocmd BufWritePre * :%s/\s\+$//e

"░░░░░░░░░░░"
"░░░░█░█░░░░"
"░░░█████░░░"
"░░███████░░"
"░░█░░█░░█░░"
"░░███████░░"
"░░░░█░█░░░░"
"░░░░░░░░░░░"
"░░░░█░█░░░░"
"░░░░░░░░░░░"
