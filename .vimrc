set statusline=%{fugitive#statusline()}%h%r%m[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%y%t%=%c,%l/%L\ %P
set showmatch                   " Show brace match
set nocompatible                " Ignore the old vi
set virtualedit=all             " Move beyond limits
set backspace=eol,start,indent  " Backspace everything on insert mode
set nowrap                      " Too long? no wrap
set scrolloff=2                 " lines around when scrolling
set number                      " Line numbers
set ruler                       " Show the position of the cursor
set list                        " Show hidden characters, but only tabs for me
set listchars=tab:\ \ ,trail:\  " Show different characters
set wildmenu                    " Help with the command line
set laststatus=2                " show the status line always
set nobomb                      " UTF8's <U+FEFF>
set cursorline
set modeline

" Folds
function! MyFoldText()
  let columnwidth = &fdc + &number*&numberwidth
  let windowwidth = winwidth(0) - columnwidth - 1
  let foldlinecount = foldclosedend(v:foldstart) - foldclosed(v:foldstart) + 1
  let fdnfo = " ["  . string(v:foldlevel) . "," . string(foldlinecount) . "]"
  let line =  strpart(getline(v:foldstart), 0 , windowwidth - len(fdnfo))
  let fillcharcount = windowwidth - len(line) - len(fdnfo)
  return line . repeat(" ",fillcharcount) . fdnfo
endfunction
set foldtext=MyFoldText()
set foldmethod=syntax
set fillchars=fold:\ 
let g:vimsyn_folding='af' " Folding vim scripts

" Sessions
set ssop-=options " do not store global and local values in a session

" Search
set ignorecase
set smartcase " ignore case only when all is lowercase
set incsearch " window to the current match
set magic     " search with \n like characters
set hlsearch  " highlight search

" No Backups
set noswapfile
set nobackup
set nowb

" Tabs And Identation
set shiftwidth=2
set autoindent
set smartindent
set expandtab
set tabstop=2
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
set background=dark
" colorscheme sadasant

" Save and Restore Folds
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

" Pathogen
call pathogen#infect()

let g:vim_markdown_new_list_item_indent = 2
let g:ale_linters = { 'javascript': ['eslint'], 'typescript': ['eslint'] }
let g:ale_sign_error = '!!'
let g:ale_sign_info = '??'
let g:ale_sign_style_error = '!!'
let g:ale_sign_style_warning = '??'
let g:ale_sign_warning = '??'
hi ALEErrorSign ctermfg=white ctermbg=88 cterm=BOLD
hi ALEWarningSign ctermfg=white ctermbg=88 cterm=BOLD
hi SignColumn ctermbg=52

" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:python_host_prog = '/home/sadasant/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/sadasant/.pyenv/versions/neovim3/bin/python'

" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)

"neoformat on save
"augroup fmt
"  autocmd!
"  autocmd BufWritePre * undojoin | Neoformat
"augroup END

"tmux window title based on file name
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window '" . expand("%:t") . "'")

"Lenghty syntax highlighting
syntax sync minlines=2000
