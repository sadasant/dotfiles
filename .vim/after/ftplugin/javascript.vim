" JavaScript

inoremap <buffer> \fn   function() {<Enter>}<Esc>k$hhi
inoremap <buffer> \sT   setTimeout(, 000)<Esc>5hi
inoremap <buffer> \sI   setInterval(, 000)<Esc>5hi
inoremap <buffer> \if   if () {<Enter>}<Esc>k3la
inoremap <buffer> \rq   require()<Left>
inoremap <buffer> \log  console.log()<Left>
inoremap <buffer> \for  for (;;) {<Enter>}<Esc>k4la
inoremap <buffer> \fori for (var i = 0; i < .length; i++) {<Enter>}<Esc>k19la
inoremap <buffer> \sw   switch () {<Enter><Enter>}<Up>case:<Enter>break<Esc>0k<c-v>j<2Yjp3k7la
inoremap <buffer> \wh   while () {<Enter>}<Esc>k6la
