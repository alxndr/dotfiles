" Vim syntax file
" Langugae:   Toki Pona https://tokipona.org (unofficial)
" Maintainer: jan Lesate <alxndr+tp.vim@gmail.com>
" Source:     https://github.com/alxndr/dotfiles

"" USAGE:
"" :set filetype=tp

"" TODO:
"" hl as error? `[fragment start] mi li ...` and same for `sina`"
"" hl as error? `[non-particle] pi [non-particle] [fragment-end]`"

let b:current_syntax = "tp"

" syntax keyword tpHeadnouns      jan
" syntax match   tpHeadnounsMatch '[a-z]\+'
syntax keyword tpInterrogatives    anu seme
syntax match tpInterrogativesMatch '\<\([a-z]\+\) ala \1\>'
syntax match tpNamesMatch '\(\<[A-Z][A-Za-z]\+\>\s*\)\+'
syntax keyword tpQuantifier ala ale ali
syntax keyword tpNounParticles en pi
syntax match tpPrenex '\([A-Za-z]\+\s\+\)\+la\>'
syntax keyword tpPrepositions kama ken kepeken lon sama tan tawa
syntax keyword tpPronouns mi ni ona sina
syntax match tpPunctuation '[^A-Za-z0-1]\+'
syntax keyword tpVerbParticles e li
syntax keyword tpVocalizations a o
syntax keyword tpUnknown taso

" highlight default link tpHeadnouns
" highlight default link tpHeadnounsMatch
highlight default link tpInterrogatives      Special
highlight default link tpInterrogativesMatch Special
highlight default link tpNamesMatch          Statement
highlight default link tpNounParticles       Operator
highlight default link tpPrenex              String " predecednce above others...
highlight default link tpPrepositions        PreProc
highlight default link tpPronouns            Type
highlight default link tpPunctuation         Comment
highlight default link tpQuantifier          Identifier
highlight default link tpVerbParticles       Constant
highlight default link tpVocalizations       Underlined
" highlight default link tpUnknown
