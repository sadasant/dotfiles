" ASCIID
" By Daniel R. (sadasant.com)
" 16 Sep 2012


" SHORTCUTS

" <F5> Save
" <F6> Quit
" <F7> New tab on the current folder
" <F8> Open current folder
"  x<  Yank to xclip
"  x>  xclip to yank
map <F5> :w<CR>
map <F6> :q
map <F7> :tabf %:p:h<CR>
map <F8> :e %:p:h<CR>
nmap x< :call system('xclip', @0)<CR>
nmap x> :let @" = system('xclip -o')[0:]<CR>

" I'm left handed and I usually play guitar.
" So I prefered to use this notes, it feels like frets on fire :)
imap <F1> <Left>
map  <F1> h
imap <F2> <Down>
map  <F2> j
imap <F3> <Up>
map  <F3> k
imap <F4> <Right>
map  <F4> l

" No arrows!
map  <Up>    <nop>
map  <Down>  <nop>
map  <Left>  <nop>
map  <Right> <nop>



" INTERFACE

set nocompatible               " Ignore the old vi
set backspace=eol,start,indent " Backspace everything on insert mode
set whichwrap=[,],h,l          " Wrap when moving towards the limit of the line
set nowrap                     " Too long? no wrap
set scrolloff=2                " lines around when scrolling

set number                     " Line numbers, babe
set ruler                      " Show the position of the cursor
set list                       " Show hidden characters, but only tabs for me, sir
set listchars=tab:»\ ,trail:-  " Show different characters

set wildmenu                   " Help with the command line
set laststatus=2               " show the status line always
set statusline=%{fugitive#statusline()}%h%r%m[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%y%t%=%c,%l/%L\ %P
set cursorline

syntax on                      " syntax
colorscheme sadasant           " color


" SEARCH
set smartcase " ignore case when all is lowercase
set incsearch " window to the current match
set magic     " search with \n like characters

" NO BACKUPS
set noswapfile
set nobackup
set nowb

" TABS AND IDENTATION
set shiftwidth=2
set autoindent
set smartindent
set expandtab
set tabstop=4
set smarttab
filetype plugin indent on

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

" PERFORMANCE
" :help slow-terminal
set ttyfast
set noshowcmd
set scrolljump=5

" BEHAVIOR
" clear right whitespaces
" WARNING: Problematic with Jade
" autocmd BufWritePre * :%s/\s\+$//e

" Save and Restore Folds
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

" Pathogen
call pathogen#infect()

" Cool down syntastic

let g:syntastic_mode_map={
  \ 'mode': 'active',
  \ 'active_filetypes': [],
  \ 'passive_filetypes': ['html']
  \ }
