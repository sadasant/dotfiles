" ASCIID
" By Daniel R. (sadasant.com)
" 16 Sep 2012


" SHORTCUTS

" zw Save
" zq Quit
" zt New tab on the current folder
" ze Open current folder
nmap zw :w<CR>
vmap zw :w<CR>
nmap zq :q
vmap zq :q
nmap zt :tabf %:p:h<CR>
vmap zt :tabf %:p:h<CR>
nmap ze :e %:p:h<CR>

" Use ctrl-[hjkl] to select the active split!
nmap zk :wincmd k<CR>
nmap zj :wincmd j<CR>
nmap zh :wincmd h<CR>
nmap zl :wincmd l<CR>

" x< Yank to xclip
" x> xclip to yank
nmap x< :call system('xclip', @0)<CR>
nmap x> :let @" = system('xclip -o')[0:]<CR>

" Special characters mappings
imap \? ¿
imap \! ¡

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

inoremap (<Tab> ()<Left>
inoremap {<Tab> {}<Left>
inoremap [<Tab> []<Left>
inoremap [<Tab> []<Left>
inoremap "<Tab> ""<Left>
inoremap '<Tab> ''<Left>
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
