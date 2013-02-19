" Vim filetype plugin file
" Language:     Lojban
" Maintainer:   Cyril Slobin <slobin@ice.ru>
" URL:          http://45.free.net/~slobin/vim/lojban.zip
" Last Change:  2007 Feb 27
" $Id: lojban.vim,v 1.9 2007-02-27 00:42:10+03 slobin Exp $

" For more information about Lojban language see http://www.lojban.org

" This plugin redefines some motion commands in a Lojban-specific way:

" - '(' and ')' moves to the start/end of Lojban sentences, separated by
"   "i", "ni'o" and "no'i".
" - '{' and '}' moves to the start/end of Lojban paragraphs, separated
"   by "ni'o" and "no'i" at the beginning of a line.
" - '%' moves to the matching cmavo, observing nested grammar forms.
"   This works only if "matchit" plugin is installed.

" The later is not handled very well, because '%' command searches for
" a closing tag for the cmavo under cursor, but most of the closing tags
" in a Lojban text are typically elided.

" Processing of the 'magic' words (e.g. "zo" or "bu") can be especially
" time consuming (plugin scrupulously counts preceding "zo" to realise
" whether its number is odd or even). If this tires you, turn it off by
" assigning the value 0 to the variable g:lojban_magic. The value 1
" turns it to be 'semi-magic' - only one occurrence of "zo" is taken
" into account. The value 2 (default) turns all magic on. 

" Also, the command '\k' displays the syntax category of the word in the
" cursor position (this works only if syntax highlighting is enabled).
" The first character of this command need not to be backslash - replace
" it with the value of the maplocalleader variable.

" If variable g:lojban_space is set to value 1, syntax category of white
" space between words is also displayed. This may be a bit confusing, so
" it is turned off by default.

" Known errors:

" During the search for matching cmavo for "%" command:

" - Erasure words "si", "sa" and "su" aren't processed. 
" - Matches aren't skipped in "lo'u" .. "le'u" quotations.
" - "zoi" quoting words doesn't match each other.

" This plugin is developed using Vim 7.x. I have no clue whether it will
" work with elder versions of Vim.

" There exists another Lojban filetype plugin for Vim, it is written by
" Martin Bays and can be found at http://mbays.freeshell.org/lojban.vim
" If you want them both to coexist, rename one to, say, lojban_cyril.vim
" and other to, say, lojban_martin.vim or something like this.

" Public Domain
" Made on Earth

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

setlocal iskeyword=39,44,48-57,A-Z,a-z
let b:undo_ftplugin = "setlocal iskeyword<"

if !exists("g:lojban_space")
  let g:lojban_space = 0
endif

if !exists("g:lojban_magic")
  let g:lojban_magic = 2
endif

noremap <buffer> <silent> ( :call search('\.\@<!\.*\<\(i\\|\(ni''o\)\+\\|\(no''i\)\+\)\>\.*\\|\%^', "bW")<CR>
noremap <buffer> <silent> ) :call search('\ze\.\@<!\.*\<\(i\\|\(ni''o\)\+\\|\(no''i\)\+\)\>\.*\\|\%$', "W")<CR>

noremap <buffer> <silent> { :call search('^\(/[^/]*/\\|\k\@!.\)*\<\(\(ni''o\)\+\\|\(no''i\)\+\)\>\\|\%^', "bW")<CR>
noremap <buffer> <silent> } :call search('\ze\_^\(/[^/]*/\\|\k\@!.\)*\<\(\(ni''o\)\+\\|\(no''i\)\+\)\>\\|\%$', "W")<CR>

noremap <buffer> <silent> <LocalLeader>k :echo synIDattr(synID(line("."), col("."), !g:lojban_space), "name")<CR>

if exists("loaded_matchit")
  let b:match_ignorecase = 1
  let b:match_skip = 's:lojbanComment\|lojbanQuoteSymbol\|lojbanTextForeign'
  let b:match_words =
        \ '<<i\|ni''o\|no''i>>:<<zo''u>>:<<cu>>:<<vau>>,' .
        \ '<<be''e\|co''o\|coi\|doi\|fe''o\|fi''e\|je''e\|ju''i\|ke''o\|ki''e\|mi''e\|mu''o\|nu''e\|pe''u\|re''i\|ta''a\|vi''o>>:<<do''u>>,' .
        \ '<<be>>:<<bei>>:<<be''o>>,' .
        \ '<<du''u\|jei\|ka\|li''i\|mu''e\|ni\|nu\|pu''u\|si''o\|su''u\|za''i\|zu''o>>:<<kei>>,' .
        \ '<<fi''o>>:<<fe''u>>,' .
        \ '<<fu''e>>:<<fu''o>>,' .
        \ '<<ga\|ge''i\|ge\|go\|gu''a\|gu''e\|gu''i\|gu''o\|gu''u\|gu>>:<<gi>>,' .
        \ '<<goi\|ne\|no''u\|pe\|po''e\|po''u\|po>>:<<ge''u\|zi''e>>,' .
        \ '<<jo''i\|ma''o\|mo''e\|na''u\|ni''e>>:<<te''u>>,' .
        \ '<<ke>>:<<ke''e>>,' .
        \ '<<la''i\|la\|lai\|le''e\|le''i\|le\|lei\|lo''e\|lo''i\|lo\|loi>>:<<ku>>,' .
        \ '<<la''e\|lu''a\|lu''e\|lu''i\|lu''o\|tu''a\|vu''i\|je''a__bo\|na''e__bo\|no''e__bo\|to''e__bo>>:<<lu''u>>,' .
        \ '<<li>>:<<lo''o>>,' .
        \ '<<lo''u>>:<<le''u>>,' .
        \ '<<lu>>:<<li''u>>,' .
        \ '<<me>>:<<me''u>>,' .
        \ '<<noi\|poi\|voi>>:<<ku''o\|zi''e>>,' .
        \ '<<nu''i>>:<<nu''u>>,' .
        \ '<<pe''o>>:<<ku''e>>,' .
        \ '<<soi>>:<<se''u>>,' .
        \ '<<tei>>:<<foi>>,' .
        \ '<<to''i\|to>>:<<toi>>,' .
        \ '<<tu''e>>:<<tu''u>>,' .
        \ '<<vei>>:<<ve''o>>'
  if g:lojban_magic == 0
    let b:match_words = substitute(b:match_words, '<<', '\\<\\%(', "g")
    let b:match_words = substitute(b:match_words, '>>', '\\)\\>', "g")
  elseif g:lojban_magic == 1
    let b:match_words = substitute(b:match_words, '<<', '\\%(\\<zo\\>__\\)\\@<!\\<\\%(', "g")
    let b:match_words = substitute(b:match_words, '>>', '\\)\\>\\%(__\\<bu\\>\\)\\@!', "g")
  else
    let b:match_words = substitute(b:match_words, '<<', '\\%(\\%(\\<zo\\>__\\)\\@<!\\%(\\<zo\\>__\\<zo\\>__\\)*\\<zo\\>__\\)\\@<!\\<\\%(', "g")
    let b:match_words = substitute(b:match_words, '>>', '\\)\\>\\%(__\\<bu\\>\\)\\@!', "g")
  endif
  let b:match_words = substitute(b:match_words, '__', '\\%(/[^/]*/\\|\\k\\@!\\_.\\)\\+', "g")
endif

let &cpo = s:save_cpo
