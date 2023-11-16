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

syntax keyword tpInterrogatives anu seme
syntax   match tpInterrogativesMatch '\<\([a-z]\+\) ala \1\>'
syntax   match tpNamesMatch '\<[a-z]\+\s\+\(\<[A-Z][A-Za-z]\+\>\s*\)\+'
syntax keyword tpNounParticles en pi
syntax keyword tpModifiers taso
syntax   match tpPrenex '\([A-Za-z]\+\s\+\)\+la\>'
syntax keyword tpPrepositions kama ken kepeken lon sama tan tawa
syntax keyword tpPronouns mi ni ona sina
syntax   match tpPunctuation '[^A-Za-z0-1]\+'
syntax keyword tpQuantifier ala ale ali
syntax keyword tpVerbParticles e li
syntax keyword tpVocalizations a o

highlight default link tpInterrogatives      Special
highlight default link tpInterrogativesMatch Special
highlight default link tpNamesMatch          Statement
highlight default link tpNounParticles       Operator
highlight default link tpPrenex              String
highlight default link tpPrepositions        Identifier
highlight default link tpPronouns            Type
highlight default link tpPunctuation         Comment
highlight default link tpQuantifier          Type
highlight default link tpVerbParticles       Constant
highlight default link tpVocalizations       Underlined
