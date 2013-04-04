" .vimrc
" By Daniel R. (sadasant.com)

" <Tab>w   Save
" <Tab>s   Make user's session
" <Tab>o   Load user's session
" <Tab>q   Ask to quit
" <Tab>t   New tab on the current folder
" <Tab>tf  Wildcard search, open in a new tab
" <Tab>tr  Read command in new tab
" <Tab>tp  Get someting from vpaste.net with curl, results in new tab
" <Tab>tpf Post something to vpaste.net with curl, results in new tab
" <Tab>e   Open current folder
" <Tab>ef  Wildcard search, open in current pane
" <Tab>eh  Split horizontalky on current directory
" <Tab>ev  Split vertically on current directory
" <Tab>er  Read command in the same window
" <Tab>ehf Wildcard search in a new split
" <Tab>evf Wildcard search in a new vertical split
" <Tab>ehr Read command in a new split
" <Tab>evr Read command in a new vertical split
" <Tab>ep  Get someting from vpaste.net with curl, results in vertical split
" <Tab>epf Post something to vpaste.net with curl, results in vertical split
" <Tab>jq  Auto-format paragraph
nmap <Tab>w   :w<cr>
nmap <Tab>s   :mksession! ~/.vim_session
nmap <Tab>o   :source ~/.vim_session
nmap <Tab>q   :q
nmap <Tab>t   :tabf %:p:h<cr>
nmap <Tab>tf  :tabf ~/**/
nmap <Tab>tr  :tabnew <bar> r!
nmap <Tab>tp  :tabnew <bar> r!curl -\# vpaste.net/?raw<left><left><left><left>
nmap <Tab>tpf :tabnew <bar> r!curl vpaste.net -F 'text='<left>
nmap <Tab>e   :e %:p:h<cr>
nmap <Tab>ef  :e ~/**/
nmap <Tab>eh  :40Hex <cr>
nmap <Tab>ev  :50Vex!<cr>
nmap <Tab>er  :ene   <bar> r!
nmap <Tab>ehf :bel 13new ~/**/
nmap <Tab>evf :bel vnew  ~/**/
nmap <Tab>ehr :bel 13new <bar> r!
nmap <Tab>evr :bel vnew  <bar> r!
nmap <Tab>ep  :bel vnew  <bar> r!curl -\# vpaste.net/?raw<left><left><left><left>
nmap <Tab>epf :bel vnew  <bar> r!curl vpaste.net -F 'text='<left>
nmap <Tab>jq  v}hJgqq<c-o>

" Go to the last active tab
let g:lasttab = 1
nmap <Tab><Tab> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Use <Tab>-[hjkl] to select the active split!
nmap <Tab>k :wincmd k<cr>
nmap <Tab>j :wincmd j<cr>
nmap <Tab>h :wincmd h<cr>
nmap <Tab>l :wincmd l<cr>

" <Tab>< Yank to xclip
" <Tab>> xclip to yank
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

" nmap :BufferList
nmap <Tab>b :Bufferlist<cr>
