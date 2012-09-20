" Go tabs
setlocal noexpandtab
setlocal shiftwidth=4

" No hidden characters
setlocal nolist

" Auto-fix go format
map <C-g> :!gofmt -w %<CR>
