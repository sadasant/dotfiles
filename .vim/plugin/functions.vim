" .vim/plugin/functions.vim
" By Daniel R. (sadasant.com)

com! -nargs=+ Sadasant call Sadasant(<f-args>)

function! Sadasant(name, ...)
  if a:name == "find"
    :call call (function('SadasantFind'), a:000)
  endif
endfunction

function! SadasantFind(type, ...)
  let match = a:0
  if !match
    call inputsave()
    let match = input('Enter search string: ')
    call inputrestore()
  endif
  if a:type ==? "v"
    :exe "bel vnew | r!grep -rin ".match." ".expand("%:p:h")
    " Enter to open the file under the cursor line at the position given by grep
    :exe "nnoremap <buffer> <Enter> 0:wincmd F<cr>"
  elseif a:type ==? "h"
    :exe "bel 13new | r!grep -rin ".match." ".expand("%:p:h")
    " Enter to open the file under the cursor line at the position given by grep
    :exe "nnoremap <buffer> <Enter> 0:bel vert wincmd F<cr>"
  endif
  " `t` to open the file under the cursor line at the position given by grep
  :exe "nnoremap <buffer> t 0:wincmd gF<cr>"
  " h and l will look for the prev/next occurrence of a line start or matched content
  :exe "nnoremap <buffer> h ?\\(\\(\\/.*:\\d*:\\)\\@<=\\)\\\\|^<cr>zs20zh"
  :exe "nnoremap <buffer> l /\\(\\(\\/.*:\\d*:\\)\\@<=\\)\\\\|^<cr>zs20zh"
  " j and k will look for the next/prev matched content
  :exe "nnoremap <buffer> j /\\(\\/.*:\\d*:\\)\\@<=<cr>zs20zh"
  :exe "nnoremap <buffer> k ?\\(\\/.*:\\d*:\\)\\@<=<cr>zs20zh"
  :exe "nnoremap <buffer> q :q!<cr>"
endfunction

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

