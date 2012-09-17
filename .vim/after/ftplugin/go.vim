" Go custom settings
setlocal nosmarttab
setlocal noexpandtab
setlocal nosmartindent

" No hidden characters
set nolist

" Auto-fix go format
map <C-g> :!gofmt -w %<CR>
