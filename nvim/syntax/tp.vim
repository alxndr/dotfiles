" Vim syntax file for Toki Pona https://tp.org (unofficial)
" by jan Lesate <alxndr+tp.vim@gmail.com>

" TODO:
" hl as error? `[sentence start] mi li ...` and same for `sina`"
" hl as error? `[non-particle] pi [non-particle] [fragment-end]`"

echo "TP syntax file..."

" https://vim.fandom.com/wiki/Creating_your_own_syntax_files#Telling_Vim_how_to_highlight_.2B_final_touches
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
