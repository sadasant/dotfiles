" Go

setlocal noexpandtab
setlocal shiftwidth=4

" Auto-fix go format
map <C-g> :!gofmt -w %<CR>
set listchars=tab:\ \ ,trail:-
