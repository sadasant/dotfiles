" Go

setlocal noexpandtab
setlocal shiftwidth=4

inoremap <buffer> \fn   func() {<Enter>}<Esc>k$hhi
inoremap <buffer> \for  for {<Enter>}<Esc>k$hi
inoremap <buffer> \fori for i := 0; i < ; i++ {<Enter>}<Esc>k$6hi
inoremap <buffer> \forv for _, v := range  {<Enter>}<Esc>k$hi
inoremap <buffer> \fT   func(t *testing.T) {<Enter>}<Esc>k$hhi
inoremap <buffer> \if   if {<Enter>}<Esc>k$hi
inoremap <buffer> \ife  if err != nil {<Enter>}<Esc>O
inoremap <buffer> \imp  import (<Enter>)<Esc>ko
inoremap <buffer> \in   interface{}
inoremap <buffer> \sw   switch {<Enter><Enter>}<Up>case:<Esc>0<<Left>k$hi
inoremap <buffer> \ty   type {<Enter>}<Esc>k$hi
inoremap <buffer> \sel  select {<Enter>}<Esc>O
inoremap <buffer> \Pf   fmt.Printf("")<Esc>h
inoremap <buffer> \Pln  fmt.Println("")<Esc>h
