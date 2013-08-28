" Go

setlocal noexpandtab
setlocal shiftwidth=4

" Auto-fix go format
setlocal listchars=tab:\ \ ,trail:-

inoremap <buffer> \fn   func() {<Enter>}<Esc>k$hhi
inoremap <buffer> \for  for  {<Enter>}<Esc>k$hi
inoremap <buffer> \fori for i := 0; i < ; i++ {<Enter>}<Esc>k$6hi
inoremap <buffer> \forv for _, v := range  {<Enter>}<Esc>k$hi
inoremap <buffer> \fT   func(t *testing.T) {<Enter>}<Esc>k$hhi
inoremap <buffer> \if   if  {<Enter>}<Esc>k$hi
inoremap <buffer> \imp  import (<Enter>)<Esc>ko
inoremap <buffer> \in   interface{}
inoremap <buffer> \sw   switch  {<Enter><Enter>}<Up>case:<Esc>0<<Left>k$hi
inoremap <buffer> \ty   type  {<Enter>}<Esc>k$hi
inoremap <buffer> \sel  select {<Enter>}<Esc>O
