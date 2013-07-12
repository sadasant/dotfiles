" .vim/plugin/mappings.vim
" By Daniel R. (sadasant.com)

" <Tab>vr  Reload ~/.vimrc
" <Tab>vc  Reload %
" <Tab>w   Save
" <Tab>s   Make user's session
" <Tab>o   Load user's session
" <Tab>q   Ask to quit
" <Tab>Q   Ask to remove the current buffer
" <Tab>t   New tab on the current folder
" <Tab>tf  Wildcard search, open in a new tab
" <Tab>tr  Read command in new tab
" <Tab>tp  Get someting from vpaste.net with curl, results in new tab
" <Tab>tpf Post something to vpaste.net with curl, results in new tab
" <Tab>T   New tab on the current folder, on the left of the current tab
" <Tab>ef  Wildcard search, open in current pane
" <Tab>eh  Split current file horizontally
" <Tab>ev  Split current file vertically
" <Tab>ex  Open current folder
" <Tab>exh Split horizontalky on current directory
" <Tab>exv Split vertically on current directory
" <Tab>er  Read command in the same window
" <Tab>ehf Wildcard search in a new split
" <Tab>evf Wildcard search in a new vertical split
" <Tab>ehr Read command in a new split
" <Tab>evr Read command in a new vertical split
" <Tab>ep  Get someting from vpaste.net with curl, results in vertical split
" <Tab>epf Post something to vpaste.net with curl, results in vertical split
" <Tab>jq  Auto-format paragraph
nmap <Tab>vr  :source ~/.vimrc<cr>
nmap <Tab>vc  :source %
nmap <Tab>w   :w<cr>
nmap <Tab>s   :mksession! ~/.vim_session/
nmap <Tab>o   :source ~/.vim_session/
nmap <Tab>q   :q
nmap <Tab>Q   :bd
nmap <Tab>t   :tabf %:p:h<cr>
nmap <Tab>tf  :tabf ~/**/
nmap <Tab>tr  :tabnew <bar> r!
nmap <Tab>tp  :tabnew <bar> r!curl -\# vpaste.net/?raw<left><left><left><left>
nmap <Tab>tpf :tabnew <bar> r!curl vpaste.net -F 'text='<left>
nmap <Tab>T   :exec (tabpagenr()-1).'tabf %:p:h'<cr>
nmap <Tab>ef  :e ~/**/
nmap <Tab>eh  :bel sp <cr>
nmap <Tab>ev  :bel vs <cr>
nmap <Tab>ex  :e %:p:h<cr>
nmap <Tab>exh :40Hex  <cr>
nmap <Tab>exv :50Vex! <cr>
nmap <Tab>er  :ene   <bar> r!
nmap <Tab>ehf :bel 13new ~/**/
nmap <Tab>evf :bel vnew  ~/**/
nmap <Tab>ehr :bel 13new <bar> r!
nmap <Tab>evr :bel vnew  <bar> r!
nmap <Tab>ep  :bel vnew  <bar> r!curl -\# vpaste.net/?raw<left><left><left><left>
nmap <Tab>epf :bel vnew  <bar> r!curl vpaste.net -F 'text='<left>
nmap <Tab>jq  }ho<Esc><c-o>v}hJgqq:s/ \+$//g<cr>

" Mapping tab move 0..8
nmap <Tab>tm1  :tabm 0<cr>
nmap <Tab>tm2  :tabm 1<cr>
nmap <Tab>tm3  :tabm 2<cr>
nmap <Tab>tm4  :tabm 3<cr>
nmap <Tab>tm5  :tabm 4<cr>
nmap <Tab>tm6  :tabm 5<cr>
nmap <Tab>tm7  :tabm 6<cr>
nmap <Tab>tm8  :tabm 7<cr>
nmap <Tab>tm9  :tabm 8<cr>

" Go to the last active tab
let g:lasttab = 1
nmap <Tab><Tab> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Use <Tab>-[hjkl] to select the active split!
nmap <Tab>k :wincmd k<cr>
nmap <Tab>j :wincmd j<cr>
nmap <Tab>h :wincmd h<cr>
nmap <Tab>l :wincmd l<cr>

" Closing Characters
inoremap (<Tab> ()<Left>
inoremap {<Tab> {}<Left>
inoremap [<Tab> []<Left>
inoremap [<Tab> []<Left>
inoremap "<Tab> ""<Left>
inoremap '<Tab> ''<Left>
inoremap **<Tab> ****<Left><Left>
inoremap /*<Tab> /*  */<Left><Left><Left>
inoremap `<Tab> ``<Left>
inoremap <<Tab> <><Left>

" Special characters mappings
imap \? ¿
imap \! ¡

" Changing the dictionary language
nmap <Tab>ds :set dictionary=/usr/share/dict/spanish<cr>
nmap <Tab>dw :set dictionary=/usr/share/dict/words<cr>
nmap <Tab>de :set dictionary=/usr/share/dict/american-english<cr>

" Work with Bufferlist faster
nmap <Tab>b :Bufferlist<cr>

" Work with fugitive faster
nmap <Tab>gc :Gcommit<cr>
nmap <Tab>gs :Gstatus<cr>
nmap <Tab>gw :Gwrite<cr>
nmap <Tab>gp :Git push 
nmap <Tab>ge :Gedit 
nmap <Tab>gh :Gsplit 
nmap <Tab>gv :Gvsplit 
nmap <Tab>gt :Gtabedit 

