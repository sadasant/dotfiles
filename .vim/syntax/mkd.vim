" Vim syntax file
" Language:     Markdown
" Maintainer:   Daniel Rodríguez <djrs@sadasant.com>
" URL:          http://plasticboy.com/markdown-vim-mode
" URL:          https://github.com/hallison/vim-markdown
" URL:          https://github.com/sadasant/vim-markdown
" Version:      10
" Last Change:  2012 Nov 16
" Remark:       Uses HTML syntax file
" TODO:         Handle stuff contained within stuff (e.g. headings within blockquotes)


" Read the HTML syntax to start with
if version < 600
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

syn spell toplevel
syn case ignore
syn sync linebreaks=1

"additions to HTML groups
syn region htmlBold   start=/\\\@<!\(^\|\A\)\@=\*\@<!\*\*\*\@!\S\@=/ end=/\S\\\@<!\*\@<!\*\*\*\@!\($\|\A\)\@=/ contains=htmlItalic,@Spell
syn region htmlItalic start=/\\\@<!\(^\|\A\)\@=\*\@<!\*\*\@!\S\@=/   end=/\S\\\@<!\*\@<!\*\*\@!\($\|\A\)\@=/   contains=htmlBold,@Spell
syn region htmlBold   start=/\\\@<!\(^\|\A\)\@=\<_\@<!___\@!\S\@=/   end=/\S\\\@<!_\@<!___\@!\($\|\A\)\@=/     contains=htmlItalic,@Spell
syn region htmlItalic start=/\\\@<!\(^\|\A\)\@=\<_\@<!__\@!\S\@=/    end=/\S\\\@<!_\@<!__\@!\($\|\A\)\@=/      contains=htmlBold,@Spell

" [link](URL) | [link][id] | [link][]
syn region mkdLink matchgroup=mkdDelimiter start="\!\?\["  end="\]\ze\s*[[(]" contains=@Spell nextgroup=mkdURL,mkdID skipwhite
syn region mkdID   matchgroup=mkdDelimiter start="\["      end="\]" contained
syn region mkdURL  matchgroup=mkdDelimiter start="("       end=")"  contained

" <https://link.link>                            : protocol   optional  user:pass@       sub/domain             .com, .co.uk, etc             optional port     path/querystring/hash fragment
syn region mkdLink matchgroup=mkdDelimiter start="<\(https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*\)\@="  end=">" oneline contains=@Spell skipwhite

" Link definitions: [id]: URL (Optional Title)
syn region mkdLinkDef   matchgroup=mkdDelimiter start="^ \{,3}\zs\[" end="]:"     oneline   nextgroup=mkdLinkDefTarget skipwhite
syn region mkdLinkDefTarget start="<\?\zs\S" excludenl    end="\ze[>[:space:]\n]" contained nextgroup=mkdLinkTitle,mkdLinkDef skipwhite skipnl oneline
syn region mkdLinkTitle matchgroup=mkdDelimiter start=+"+ end=+"+  contained
syn region mkdLinkTitle matchgroup=mkdDelimiter start=+'+ end=+'+  contained
syn region mkdLinkTitle matchgroup=mkdDelimiter start=+(+ end=+)+  contained


"define Markdown groups
syn match  mkdLineContinue ".$" contained
syn match  mkdRule       /^\s*\*\s\{0,1}\*\s\{0,1}\*$/
syn match  mkdRule       /^\s*-\s\{0,1}-\s\{0,1}-$/
syn match  mkdRule       /^\s+_\s\{0,1}_\s\{0,1}_$/
syn match  mkdRule       /^\s*-\{3,}$/
syn match  mkdRule       /^\s*\*\{3,5}$/
syn match  mkdListItem   "^\s*[-*+]\s\+"
syn match  mkdListItem   "^\s*\d\+\.\s\+"

" 3 level depth code
syn match  mkdBlockCode  /^\(^\S.*\n\)\@<=\n\(^\(\s\{4}\|\t\).*\n\)\+/
syn match  mkdBlockCode  /^\(^\s\{4}\S.*\n\)\@<=\n\(^\(\s\{8}\|\t\{2}\).*\n\)\+/
syn match  mkdBlockCode  /^\(^\s\{8}\S.*\n\)\@<=\n\(^\(\s\{12}\|\t\{3}\).*\n\)\+/

syn match  mkdLineBreak  /  \+$/
syn region mkdCode       start=/\\\@<!`/        end=/\\\@<!`/
syn region mkdCode       start=/\s*``[^`]*/     end=/[^`]*``\s*/
syn region mkdCode       start=/^```\s*\w*\s*$/ end=/^```\s*$/
syn region mkdBlockquote start=/^\s*>/          end=/$/                 contains=mkdLineBreak,mkdLineContinue,@Spell
syn region mkdCode       start="<pre[^>]*>"     end="</pre>"
syn region mkdCode       start="<code[^>]*>"    end="</code>"

"HTML headings
syn region htmlH1       start="^\s*#"                   end="\($\|#\+\)" contains=@Spell
syn region htmlH2       start="^\s*##"                  end="\($\|#\+\)" contains=@Spell
syn region htmlH3       start="^\s*###"                 end="\($\|#\+\)" contains=@Spell
syn region htmlH4       start="^\s*####"                end="\($\|#\+\)" contains=@Spell
syn region htmlH5       start="^\s*#####"               end="\($\|#\+\)" contains=@Spell
syn region htmlH6       start="^\s*######"              end="\($\|#\+\)" contains=@Spell
syn match  htmlH1       /^.\+\n=\+$/ contains=@Spell
syn match  htmlH2       /^.\+\n-\+$/ contains=@Spell

"highlighting for Markdown groups
HtmlHiLink mkdString        String
HtmlHiLink mkdCode          String
HtmlHiLink mkdBlockCode     String
HtmlHiLink mkdBlockquote    Comment
HtmlHiLink mkdLineContinue  Comment
HtmlHiLink mkdListItem      Identifier
HtmlHiLink mkdRule          Identifier
HtmlHiLink mkdLineBreak     Todo
HtmlHiLink mkdFootnotes     htmlLink
HtmlHiLink mkdLink          htmlLink
HtmlHiLink mkdURL           htmlString
HtmlHiLink mkdInlineURL     htmlLink
HtmlHiLink mkdID            Identifier
HtmlHiLink mkdLinkDef       mkdID
HtmlHiLink mkdLinkDefTarget mkdURL
HtmlHiLink mkdLinkTitle     htmlString
HtmlHiLink mkdDelimiter     Delimiter

let b:current_syntax = "mkd"
set foldmethod=manual

delcommand HtmlHiLink
" vim: ts=4
