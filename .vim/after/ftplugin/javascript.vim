" JavaScript

inoremap <buffer> \fn      function() {<cr>}<Esc>k$hhi
inoremap <buffer> \fa      () => {<cr>}<Esc>k$5hi
inoremap <buffer> \af      async () => {<cr>}<Esc>k$5hi
inoremap <buffer> \[       [<cr>]<Esc>O
inoremap <buffer> \{       {<cr>}<Esc>O
inoremap <buffer> \(       (<cr>)<Esc>O
inoremap <buffer> \l[      let = []<Left><cr><Esc>kea<Space>
inoremap <buffer> \l{      let = {}<Left><cr><Esc>kea<Space>
inoremap <buffer> \a{      async => {}<Left><cr><Esc>kea<Space>
inoremap <buffer> \({      ({ }) => {}<Esc>i<cr><Esc>?({<cr>:let @/ = ""<cr><Right>a<Space>
inoremap <buffer> \l({     let = ({ }) => {}<Esc>i<cr><Esc>?let<cr>:let @/ = ""<cr>ea<Space>
inoremap <buffer> \sT      setTimeout(, 000)<Esc>5hi
inoremap <buffer> \sI      setInterval(, 000)<Esc>5hi
inoremap <buffer> \if      if () {<cr>}<Esc>k3la
inoremap <buffer> \rq      require()<Left>
inoremap <buffer> \cl      console.log()<Left>
inoremap <buffer> \ci      console.info()<Left>
inoremap <buffer> \ce      console.error()<Left>
inoremap <buffer> \for     for (;;) {<cr>}<Esc>k4la
inoremap <buffer> \fori    for (var i = 0; i < .length; i++) {<cr>}<Esc>k19la
inoremap <buffer> \sw      switch () {<cr><cr>}<Up>case:<cr>break<Esc>0k<c-v>j<2Yjp3k7la
inoremap <buffer> \wh      while () {<cr>}<Esc>k6la
inoremap <buffer> \ex      expect().toEqual()<Esc>10hi

" HTML specific
inoremap <buffer> \<d      <div></div><Esc>?><cr>:let @/ = ""<cr>a
inoremap <buffer> \<p      <p></p><Esc>?><cr>:let @/ = ""<cr>a
inoremap <buffer> \<table  <table><cr></table><Esc>?><cr>:let @/ = ""<cr>o<Tab>
inoremap <buffer> \<thead  <thead><cr></thead><Esc>?><cr>:let @/ = ""<cr>o<Tab>
inoremap <buffer> \<tbody  <tbody><cr></tbody><Esc>?><cr>:let @/ = ""<cr>o<Tab>
inoremap <buffer> \<tr     <tr></tr><Esc>?><cr>:let @/ = ""<cr>a
inoremap <buffer> \<th     <th></th><Esc>?><cr>:let @/ = ""<cr>a
inoremap <buffer> \<td     <td></td><Esc>?><cr>:let @/ = ""<cr>a
inoremap <buffer> \>       <Esc>v?<<cr>yea><Esc>p?<<cr>a/<Esc>ea><Esc>?><cr>:let @/ = ""<cr>a

" lodash specific
inoremap <buffer> \_f      _.flow(<cr>)<Esc>?_.flo<cr>:let @/ = ""<cr>jhdwi <Esc>O
inoremap <buffer> \_m      _.map( => )<Esc>%a
inoremap <buffer> \_e      _.each( => )<Esc>%a
inoremap <buffer> \_g      _.get('')<Esc>%la
inoremap <buffer> \_s      _.sortBy('')<Esc>%la
