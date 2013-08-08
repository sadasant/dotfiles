" .vim/plugin/functions.vim
" By Daniel R. (sadasant.com)

" General wrapper
" ===============
" Used this way:
" nmap <Tab>S  :Sadasant 
" nmap <Tab>f  :Sadasant find 
" nmap <Tab>fv :Sadasant find v<cr>
" nmap <Tab>fh :Sadasant find h<cr>

com! -nargs=+ Sadasant call Sadasant(<f-args>)

function! Sadasant(name, ...)
  if a:name == "find"
    call call (function('SadasantFind'), a:000)
  endif
  if a:name == "align"
    call call (function('SadasantAlignRelative'), a:000)
  endif
endfunction

" Find and Open
" ==============

function! SadasantFindOpen(type)
  if g:last_buffer
    silent exec 'bwipeout' g:last_buffer
  endif
  let l:line = line('.')
  while has_key(s:grep, l:line) == 0
    let l:line -= 1
  endwhile
  let l:file = split(s:grep[l:line], ":")
  if a:type ==? "v"
    exe "new ".l:file[0]
  else
    exe "bel vnew ".l:file[0]
  endif
  exe ":".l:file[1]
  let g:last_buffer = bufnr(bufname("%"))
endfunction

function! SadasantFind(type, ...)
  let g:last_buffer = 0
  let match = a:0
  if !match
    call inputsave()
    let match = input('Enter search string: ')
    call inputrestore()
  endif
  if a:type ==? "v"
    bel vnew __SadasantFind__
    " Empty the buffer
    normal! ggdG
    " Enter to open the file under the cursor line at the position given by grep
    nnoremap <buffer> <Enter> :call SadasantFindOpen('v')<cr>
  else
    bel 13new __SadasantFind__
    " Empty the buffer
    normal! ggdG
    " Enter to open the file under the cursor line at the position given by grep
    nnoremap <buffer> <Enter> :call SadasantFindOpen('h')<cr>
  endif
  " Custom colors
  syntax region foundPath start=/\/\@<!\(\/\)\w/ end=/$/
  highlight link foundPath Comment
  syntax region foundNr start=/^ / end=/\d\( \|> *\)/
  highlight link foundNr LineNr
  " Fill with grep
  let l:grep = split(system("grep -rin ".match." ".expand("#:p:h")), '\v\n')
  let s:grep = {}
  let l:lines = []
  let l:count = 0
  for l:found in l:grep
    let s:grep[line('$')] = substitute(l:found, '\(:\d*\)\@<=:.*', '', '')
    let l:split = split(l:found, ':')
    let l:split[0] = substitute(l:split[0], '\w\@<=\w*\/', '/', 'g')
    let l:nr = l:split[1]
    let l:path = ' '.l:count.'> '.l:split[0]
    let l:match = ' '.l:nr.' '.join(l:split[2:], ':')
    call append(line('$'), l:path)
    call append(line('$'), l:match)
    call append(line('$'), '~')
    let l:count += 1
  endfor
  " Go to the first column of the first line
  normal! ggdd0l
  setlocal nonu
  setlocal bt=nofile
  setlocal modifiable
  setlocal bt=nowrite
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal nowrap
  nnoremap <buffer> h :silent;? \d\{1,}><cr>
  nnoremap <buffer> l :silent;/ \d\{1,}><cr>
  nnoremap <buffer> j :silent;/ \d\{1,}><cr>
  nnoremap <buffer> k :silent;? \d\{1,}><cr>
  nnoremap <buffer> q :bd<cr>
  noremap <buffer> <Up> <NOP>
  noremap <buffer> <Down> <NOP>
  noremap <buffer> <Left> <NOP>
  noremap <buffer> <Right> <NOP>
endfunction

" Delete Inactive Buffers
" =======================

" Thanks to: http://stackoverflow.com/questions/1534835/how-do-i-close-all-buffers-that-arent-shown-in-a-window-in-vim
function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
" command! Bdi :call DeleteInactiveBufs()

" Sadasant Align Relative
" =======================

let s:sadasant_align_ask = ''
function! SadasantAlignRelative(repeat, reverse, ask)
  let l:pos0 = getpos('.')
  let l:flags = ''
  let l:repeat = a:repeat
  if a:reverse == 1
    " Return if we're at the beginning
    if l:pos0[1] == 1
      call setpos('.', l:pos0)
      return
    endif
    " Setting the backwards flag
    let l:flags = 'b'
  else
    " Return if we're at the end
    if l:pos0[1] == line('$')
      call setpos('.', l:pos0)
      return
    endif
  endif
  " Taking the current character
  let l:ask = a:ask
  if l:ask == 'ask'
    call inputsave()
    let l:a = input('Enter regex: ')
    call inputrestore()
    let s:sadasant_align_ask = l:a
    let l:ask = 'stored'
    " Update the current position to the nearest
    " forward match of the requested query
    exe "normal! h"
    call search(l:a)
    let l:pos0 = getpos('.')
  elseif l:ask == 'stored'
    let l:a = s:sadasant_align_ask
  else
    exe 'normal! "ayl'
    let l:a = @a
  endif
  " In near, we'll store the next match which is at the nearest column "
  let l:near = []
  while 1
    call search(l:a, l:flags)
    let l:pos = getpos('.')
    let l:dif = abs(l:pos[1] - l:pos0[1])
    if l:dif > 1
      break
    endif
    if l:pos[1] == l:pos0[1] && l:pos[2] == l:pos0[2]
      break
    endif
    if l:pos[1] != l:pos0[1]
      if empty(l:near)
        let l:near = l:pos
      else
        let l:dif0 = abs(l:near[2] - l:pos0[2])
        let l:dif1 = abs(l:pos[2] - l:pos0[2])
        if l:dif0 > l:dif1
          let l:near = l:pos
        endif
      endif
    endif
  endwhile
  if empty(l:near)
    call setpos('.', l:pos0)
    return
  endif
  " Deleting unnecesary spaces in the nearest position
  call setpos('.', l:near)
  call search('\S\@<= ', 'b')
  let l:spaces = getpos('.')
  if !empty(l:spaces) && l:spaces[2] == l:near[2]
    exe "normal! dw"
    let l:near = getpos('.')
  else
    call setpos('.', l:near)
  endif
  " Now adding the spaces
  if l:near[2] != l:pos0[2]
    let l:dif = abs(l:near[2] - l:pos0[2])
    if l:near[2] < l:pos0[2]
      call setpos('.', l:near)
      exe "normal! i".repeat(' ', l:dif)."\<Esc>l"
    else
      call setpos('.', l:pos0)
      exe "normal! i".repeat(' ', l:dif)."\<Esc>"
      call setpos('.', l:near)
    endif
  endif
  if l:repeat > 1
    call SadasantAlignRelative(l:repeat-1, a:reverse, l:ask)
  endif
endfunction
