" ASCIID
" By Daniel R. (sadasant.com)
" 16 Sep 2012


" SHORTCUTS

" <C-g> Save
" <C-d> Quit
" <C-t> New tab on the current folder
" <C-e> Open current folder
"  x<  Yank to xclip
"  x>  xclip to yank
nmap <C-g> :w<CR>
vmap <C-g> :w<CR>
imap <C-g> :w<CR>a
imap <C-g> <Esc><c-g>
nmap <C-d> :q<CR>
vmap <C-d> :q<CR>
imap <C-d> :q<CR>
nmap <C-t> :tabf %:p:h<CR>
vmap <C-t> :tabf %:p:h<CR>
imap <C-t> :tabf %:p:h<CR>
nmap <C-e> :e %:p:h<CR>
nmap x< :call system('xclip', @0)<CR>
nmap x> :let @" = system('xclip -o')[0:]<CR>

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

" Hardmode
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" Cool down syntastic

let g:syntastic_mode_map={
  \ 'mode': 'active',
  \ 'active_filetypes': [],
  \ 'passive_filetypes': ['html']
  \ }
