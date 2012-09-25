" Go tabs
setlocal noexpandtab
setlocal shiftwidth=4

" No hidden characters

" Auto-fix go format
map <C-g> :!gofmt -w %<CR>
