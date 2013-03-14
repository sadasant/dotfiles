" .vimrc
" By Daniel R. (sadasant.com)
" 08 Mar 2013

" <Tab>w   Save
" <Tab>s   Make user's session
" <Tab>o   Load user's session
" <Tab>q   Ask to quit
" <Tab>t   New tab on the current folder
" <Tab>tf  Wildcard search, open in a new tab
" <Tab>tr  Read command in new tab
" <Tab>e   Open current folder
" <Tab>ef  Wildcard search, open in current pane
" <Tab>es  Split horizontalky on current directory
" <Tab>ev  Split vertically on current directory
" <Tab>esr Read command in new split
" <Tab>evr Read command in new vertical split
" <Tab>jq  Auto-format paragraph
nmap <Tab>w   :w<cr>
nmap <Tab>s   :mksession! ~/.session.vim<cr>
nmap <Tab>o   :source ~/.session.vim<cr>
nmap <Tab>q   :q
nmap <Tab>t   :tabf %:p:h<cr>
nmap <Tab>tf  :tabf ~/**/
nmap <Tab>tr  :tabnew <bar> r!
nmap <Tab>e   :e %:p:h<cr>
nmap <Tab>ef  :e ~/**/
nmap <Tab>es  :Sex!<cr>
nmap <Tab>ev  :Vex!<cr>
nmap <Tab>esr :new <bar> r!
nmap <Tab>evr :vnew <bar> r!
nmap <Tab>jq  v}hJgqq<c-o>

" Use ctrl-[hjkl] to select the active split!
nmap <Tab>k :wincmd k<cr>
nmap <Tab>j :wincmd j<cr>
nmap <Tab>h :wincmd h<cr>
nmap <Tab>l :wincmd l<cr>

" x< Yank to xclip
" x> xclip to yank
nmap <Tab>< :call system('xclip', @0)<cr>
nmap <Tab>> :let @" = system('xclip -o')[0:]<cr>

" Closing Characters
inoremap (<Tab> ()<Left>
inoremap {<Tab> {}<Left>
inoremap [<Tab> []<Left>
inoremap [<Tab> []<Left>
inoremap "<Tab> ""<Left>
inoremap '<Tab> ''<Left>
inoremap **<Tab> ****<Left><Left>
inoremap `<Tab> ``<Left>
inoremap _<Tab> __<Left>

" Special characters mappings
imap \? ¿
imap \! ¡

" Settings
set showmatch                  " Show brace match
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
