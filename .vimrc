" .vimrc
" By Daniel R. (sadasant.com)
" 08 Mar 2013

" zw Save
" zq Quit
" zt New tab on the current folder
" ze Open current folder
nmap <Tab>w  :w<CR>
nmap <Tab>q  :q
nmap <Tab>t  :tabf %:p:h<CR>
nmap <Tab>e  :e %:p:h<CR>
nmap <Tab>ex :Sex<CR>
nmap <Tab>ev :Vex<CR>

" Use ctrl-[hjkl] to select the active split!
nmap <Tab>k :wincmd k<CR>
nmap <Tab>j :wincmd j<CR>
nmap <Tab>h :wincmd h<CR>
nmap <Tab>l :wincmd l<CR>

" x< Yank to xclip
" x> xclip to yank
nmap <Tab>< :call system('xclip', @0)<CR>
nmap <Tab>> :let @" = system('xclip -o')[0:]<CR>

" Closing Characters
inoremap (<Tab> ()<Left>
inoremap {<Tab> {}<Left>
inoremap [<Tab> []<Left>
inoremap [<Tab> []<Left>
inoremap "<Tab> ""<Left>
inoremap '<Tab> ''<Left>
set showmatch

" Special characters mappings
imap \? ¿
imap \! ¡

" Settings
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

" Search
set smartcase " ignore case when all is lowercase
set incsearch " window to the current match
set magic     " search with \n like characters

" No Backups
set noswapfile
set nobackup
set nowb

" Tabs And Identation
set shiftwidth=2
set autoindent
set smartindent
set expandtab
set tabstop=4
set smarttab
filetype plugin indent on

" :help slow-terminal
set ttyfast
set noshowcmd
set scrolljump=5

" Syntax Color
syntax on
colorscheme sadasant

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
