" .vimrc
" By Daniel R. (sadasant.com)

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
set listchars=tab:�\ ,trail:-  " Show different characters
set wildmenu                   " Help with the command line
set laststatus=2               " show the status line always
set statusline=%{fugitive#statusline()}%h%r%m[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%y%t%=%c,%l/%L\ %P
set cursorline
set modeline
set foldmethod=syntax
set foldtext=MyFoldText()
set fillchars=fold:_

" setting fold text
function! MyFoldText()
  let nl = v:foldend - v:foldstart + 1
  let comment = substitute(getline(v:foldstart),"^ *\" *","",1)
  let txt = '+' . nl . ' ' . comment . '                                                                                                                                                                  '
  return txt
endfunction

" Sessions
set ssop-=options  " do not store global and local values in a session
" set ssop-=folds    " do not store folds

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

" Dictionary
set dictionary-=/usr/share/dict/words
set dictionary-=/usr/share/dict/spanish
set dictionary+=/usr/share/dict/words
set complete-=k complete+=k

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

" JS folds
au FileType javascript call JavaScriptFold()

