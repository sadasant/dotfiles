noremap  <buffer> o :s/,\?$/,/<cr>o"" : <Esc>3hi
noremap  <buffer> O O"" : ,<Esc>hhhh

inoremap <buffer> [<cr> [<cr>]<Esc>O<Tab>""<Esc>i
inoremap <buffer> {<cr> {<cr>}<Esc>O""<Esc>i
inoremap <buffer> <cr> <Esc>:s/,\?$/,/<cr>o""<Esc>
