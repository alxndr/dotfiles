" Vim syntax file
" Language:   Toki Pona https://tokipona.org (unofficial)
" Maintainer: jan Lesate <alxndr+tp.vim@gmail.com>
" Source:     https://github.com/alxndr/dotfiles
" Screenshot: https://i.imgur.com/gJdPmsa.png

"" USAGE:
"" :set filetype=tp

"" TODO:
"" hl as error? `[fragment start] mi li ...` and same for `sina`"
"" hl as error? `[non-particle] pi [non-particle] [fragment-end]`"

let b:current_syntax = "tp"

syntax keyword tpInterrogatives anu seme
syntax   match tpInterrogativesMatch '\<\([a-z]\+\) ala \1\>'
syntax   match tpNamesMatch '\<[a-z]\+\s\+\(\<[A-Z][A-Za-z]\+\>\s*\)\+' " broken??
syntax keyword tpNounParticles en pi
syntax keyword tpModifiers kin taso
" syntax   match tpPrenex '\([A-Za-z]\+\s\+\)\+la\>'
syntax  region tpPrenex start=/[aeiou]/ end=/la/ matchgroup=Quote contains=ALLBUT,tpPrenexSuffix
syntax keyword tpPrenexSuffix la
syntax keyword tpPrepositions kama ken kepeken lon sama tan tawa
syntax keyword tpPronouns mi ni ona sina
syntax   match tpPunctuation '[^A-Za-z]\+'
syntax keyword tpQuantifier ala ale ali
syntax keyword tpVerbParticles e li
syntax keyword tpVocalizations a o
syntax   match tpWord '[A-Za-z]\+'

"Identifier
highlight default link tpNamesMatch          Statement
highlight default link tpPronouns            Statement "Type
" highlight default link tpNounParticles       Operator

highlight default link tpInterrogatives      Special
highlight default link tpInterrogativesMatch Special
highlight default link tpQuantifier          Type

highlight tpPrenex gui=underline " how to _only_ underline an not change color??
" highlight default link tpPrenexSuffix Function
highlight tpPrenexSuffix gui=underline

highlight default link tpPrepositions        Constant
highlight default link tpPunctuation         Comment

highlight default link tpVerbParticles       Constant
highlight default link tpModifiers           String

" highlight link tpVocalizations       Function
highlight tpVocalizations gui=italic
