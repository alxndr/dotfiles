" Vim syntax file
" Language:     Lojban
" Maintainer:   Cyril Slobin <slobin@ice.ru>
" URL:          http://45.free.net/~slobin/vim/lojban.zip
" Last Change:  2007 Feb 23
" $Id: lojban.vim,v 3.14 2007-02-23 06:19:07+03 slobin Exp $

" For more information about Lojban language see http://www.lojban.org

" This syntax file doesn't implement a full Lojban morphology algorithm,
" but a rough approximation only: some broken words can be recognized as
" well-formed and vice versa; commas are allowed in cmene only; pauses
" are highlighted, but not otherwise checked; capital letters treated as
" lower-case. Digits are recognized as cmavo.

" Well, the previous paragraph was written long ago for 2.x version of
" this file. Now I believe this file *does* implement the full Lojban
" morphology algorithm. The only exception I am aware of is lack of test
" for redundant hyphens in lujvo: words like "xagyrai" will be reported
" as valid ones. By coincident this behavior is consistent with current
" BPFK suggestions. If you spot any other error or inconsistence, please
" report it to me using email address mentioned at the top of this file. 

" General meaning of colors:
"
"   gismu are green
"   lujvo are cyan
"   cmene are magenta
"   cmavo are yellow
"   fu'ivla are blue
"   experimental words are blue or underlined
"   errors are red or underlined
"
" If filetype plugin (bundled with this file) is installed, more details
" can be learned pressing '\k' with cursor on the word in question. 

" Starting with version 3.12 of this file, the default word recognition
" algorithm was changed and became compatible with vlatai, valfendi and
" other popular tools (e.g. the word "iglu" considered valid now). If
" you want an old behavior, assign value 0 to variable g:lojban_compat.
" The mnemonic is a bit misleading - the value 1 (the default now) means
" "compatible with the common standard", not "compatible with the elder
" versions of this file".

" This syntax file take a full advantage of Vim 7.x GUI version fancy
" underlining feature. If you are running GUI version of Vim and prefer
" an oldish highlighting style (no curly underlines), assign value 0 to
" the variable g:lojban_fancy. Assigning value 1 (default) turns the new
" style on. Value 2 is not supported any more, supporting three versions
" is too boring.

" If you are running character mode Vim or Vim version prior to 7.0, you
" have no choice - oldish style is the only available option.

" Starting from version 3.x of this file, compatibility with elder
" versions of Vim is broken; upgrade to Vim 7.x, it's worth doing!
" I have made a hard attempt to be compatible with Vim 6.x, but haven't
" tested it at all. If you MUST to stay with Vim 6.x and this file
" doesn't work for you, try to find version 2.7 of this file somewhere.
" The Vim version 5.x and elder is definitely out of play.

" From the same version, Lojban specific highlighting groups are defined
" directly in terms of specific colors, not as a links to standard
" highlighting groups. Lojban is not similar to programming languages!
" For details see "general meaning of colors" above.

" From the same version, options lojban_in_braces and lojban_in_brackets
" aren't supported any more. They used to make things too complicated.

" If 'foldmethod' option is set to 'syntax', Lojban text will be folded
" by Lojbanic paragraphs.

" BTW, /text in slashes/ is treated as a comment and is a subject of the
" spell checking (English, not Lojban!).

" Public Domain
" Made on Earth

if exists("b:current_syntax")
  finish
endif

if !exists("g:lojban_compat")
  let g:lojban_compat = 1
endif

if !exists("g:lojban_fancy")
  let g:lojban_fancy = 1
endif

if version < 700
  let g:lojban_fancy = 0
endif

setlocal iskeyword=39,44,48-57,A-Z,a-z

function! s:Sub(arg)
  let line = a:arg
                              " vAlid vowel pAir
  let line = substitute(line, '\CAA', '\\%([aeiou]''[aeiou]\\|[aeo]i\\|au\\)', 'g')
                              " Bad consonant pair
  let line = substitute(line, '\CBB', '\\%(cs\\|sc\\|jz\\|zj\\|cx\\|xc\\|kx\\|xk\\|mz\\)', 'g')
                              " Consonant
  let line = substitute(line, '\CC', '[bcdfgjklmnprstvxz]', 'g')
                              " Fu'ivla letter
  let line = substitute(line, '\CF', '[''abcdefgijklmnoprstuvxz]', 'g')
                              " Letter
  let line = substitute(line, '\CL', '[,''abcdefgijklmnoprstuvxyz]', 'g')
                              " vOiced consonant
  let line = substitute(line, '\CO', '[bdgjvz]', 'g')
                              " consonant excluding R
  let line = substitute(line, '\CR', '[bcdfgjklmnpstvxz]', 'g')
                              " Unvoiced consonant
  let line = substitute(line, '\CU', '[cfkpstx]', 'g')
                              " Vowel excluding y
  let line = substitute(line, '\CV', '[aeiou]', 'g')
                              " vowel including Y
  let line = substitute(line, '\CY', '[aeiouy]', 'g')
                              " initial consonant pair
  let line = substitute(line, '@@',  '\\%([bfgkmpvx][lr]\\|[cs][fklmnprt]\\|' .
                                   \ '[jz][bdgmv]\\|d[jrz]\\|t[crs]\\)', 'g')
                              " initial consonant cluster
  let line = substitute(line, '%%',  '\\%(' .
                                   \ '[bfgkmpvx][lr]\\|' .
                                   \ '[cs]\\%([lnr]\\|[fkmp][lr]\\=\\|tr\\=\\)\\|' .
                                   \ '[cs]\\%(t[cs]\\)\\+\\%([lnr]\\|[fkmp][lr]\\=\\|tr\\=\\)\\=\\|' .
                                   \ 'd\\%(r\\|[jz]\\%([bgvm][lr]\\=\\)\\=\\)\\|' .
                                   \ 'd\\%([jz]d\\)\\+\\%(r\\|[jz]\\%([bgvm][lr]\\=\\)\\=\\)\\=\\|' .
                                   \ '[jz]\\%([bgvm][lr]\\=\\|dr\\=\\)\\|' .
                                   \ '[jz]\\%(d[jz]\\)\\+\\%([bgvm][lr]\\=\\|dr\\=\\)\\=\\|' .
                                   \ 't\\%(r\\|[cs]\\%([lnr]\\|[fkmp][lr]\\=\\)\\=\\)' .
                                   \ 't\\%([cs]t\\)\\+\\%(r\\|[cs]\\%([lnr]\\|[fkmp][lr]\\=\\)\\=\\)\\=' .
                                   \ '\\)', 'g')
                              " space including newline
  let line = substitute(line, '__',  '\\%(/[^/]*/\\|\\k\\@!\\_.\\)', 'g')
                              " space excluding newline
  let line = substitute(line, '##',  '\\%(/[^/]*/\\|\\k\\@!.\\)', 'g')
  return line
endfunction

command -nargs=* SUB execute substitute(<q-args>, '"[^"]*"', '\=s:Sub(submatch(0))', 'g')

syn case ignore

syn region lojbanComment oneline start="/" end="/\|$" contains=@Spell

syn match lojbanPause "\."

syn match lojbanValsiUnrecognized "\<\k\+\>" contains=lojbanValsiUnrecognizedConsonantError

SUB syn match lojbanValsiUnrecognizedConsonantError contained "\(C\)\1"
SUB syn match lojbanValsiUnrecognizedConsonantError contained "OU\|UO"
SUB syn match lojbanValsiUnrecognizedConsonantError contained "BB"

SUB syn match lojbanFuhivlaUnrecognized "\<\%(F\|y\)\+\%(V\|y\)\>" contains=lojbanFuhivlaUnrecognizedConsonantError,lojbanFuhivlaUnrecognizedVowelError,lojbanFuhivlaUnrecognizedHyphenError

SUB syn match lojbanFuhivlaUnrecognizedConsonantError contained "\(C\)\1"
SUB syn match lojbanFuhivlaUnrecognizedConsonantError contained "OU\|UO"
SUB syn match lojbanFuhivlaUnrecognizedConsonantError contained "BB"

SUB syn match lojbanFuhivlaUnrecognizedVowelError contained "\%([aeo]i\|au\)\@!VV"

syn match lojbanFuhivlaUnrecognizedHyphenError contained "y"

SUB syn match lojbanFuhivla "\<V\%('\=V\)\{,2}CCF*V\>" contains=lojbanFuhivlaConsonantError,lojbanFuhivlaVowelError
SUB syn match lojbanFuhivla "\<%%VF*\%(C\|'\)F*V\>" contains=lojbanFuhivlaConsonantError,lojbanFuhivlaVowelError,lojbanFuhivlaSlinkuhi
SUB syn match lojbanFuhivla "\<CV'\=VCCF*V\>" contains=lojbanFuhivlaConsonantError,lojbanFuhivlaVowelError
SUB syn match lojbanFuhivla "\<CVCCF*V\>" contains=lojbanFuhivlaConsonantError,lojbanFuhivlaVowelError

SUB syn match lojbanFuhivlaConsonantError contained "\(C\)\1"
SUB syn match lojbanFuhivlaConsonantError contained "OU\|UO"
SUB syn match lojbanFuhivlaConsonantError contained "BB"

SUB syn match lojbanFuhivlaVowelError contained "\%([aeo]i\|au\)\@!VV"

SUB syn match lojbanFuhivlaSlinkuhi contained "\<C\%(@@V\|CAA\|CVC\)*\%(@@V\|CAA\|@@VCV\|CVCCV\)\>" contains=lojbanFuhivlaSlinkuhiConsonantError

SUB syn match lojbanFuhivlaSlinkuhiConsonantError contained "\(C\)\1"
SUB syn match lojbanFuhivlaSlinkuhiConsonantError contained "OU\|UO"
SUB syn match lojbanFuhivlaSlinkuhiConsonantError contained "BB"

if g:lojban_compat

  SUB syn match lojbanFuhivlaBreakable "\<V\%('\=V\)\{,2}%%VF*\%(C\|'\)F*V\>" contains=lojbanFuhivlaBreakableConsonantError,lojbanFuhivlaBreakableVowelError,lojbanFuhivlaStrong
  SUB syn match lojbanFuhivlaBreakable "\<CV\%('\=V\)\=%%VF*\%(C\|'\)F*V\>" contains=lojbanFuhivlaBreakableConsonantError,lojbanFuhivlaBreakableVowelError,lojbanFuhivlaStrong

  SUB syn match lojbanFuhivlaStrong contained "\<V\%('\=V\)\{,2}C\%(@@V\|CAA\|CVC\)*\%(@@V\|CAA\|@@VCV\|CVCCV\)\>" contains=lojbanFuhivlaStrongConsonantError,lojbanFuhivlaStrongVowelError
  SUB syn match lojbanFuhivlaStrong contained "\<CV\%('\=V\)\=C\%(@@V\|CAA\|CVC\)*\%(@@V\|CAA\|@@VCV\|CVCCV\)\>" contains=lojbanFuhivlaStrongConsonantError,lojbanFuhivlaStrongVowelError

  SUB syn match lojbanFuhivlaBreakable "\<V\%('\=V\)\{,2}\%(@@V\|CVCy\=\|@@VCy\|CVCCy\|@@V'\=VCy\)\%(@@V\|CV'\=V\|CVCy\=\|@@VCy\|CVCCy\|@@V'\=VCy\)*\%(@@V\|CV'\=V\|@@VCV\|CVCCV\)\>" contains=lojbanFuhivlaBreakableConsonantError,lojbanFuhivlaBreakableVowelError
  SUB syn match lojbanFuhivlaBreakable "\<CV\%('\=V\)\=\%(@@V\|CVCy\=\|@@VCy\|CVCCy\|@@V'\=VCy\)\%(@@V\|CV'\=V\|CVCy\=\|@@VCy\|CVCCy\|@@V'\=VCy\)*\%(@@V\|CV'\=V\|@@VCV\|CVCCV\)\>" contains=lojbanFuhivlaBreakableConsonantError,lojbanFuhivlaBreakableVowelError

  SUB syn match lojbanFuhivlaStrongConsonantError contained "\(C\)\1"
  SUB syn match lojbanFuhivlaStrongConsonantError contained "OU\|UO"
  SUB syn match lojbanFuhivlaStrongConsonantError contained "BB"

  SUB syn match lojbanFuhivlaStrongVowelError contained "\%([aeo]i\|au\)\@!VV"

else

  SUB syn match lojbanFuhivlaBreakable "\<V\%('\=V\)\{,2}%%V\%(F*V\)\=\>" contains=lojbanFuhivlaBreakableConsonantError,lojbanFuhivlaBreakableVowelError
  SUB syn match lojbanFuhivlaBreakable "\<CV\%('\=V\)\=%%VF*\%(C\|'\)F*V\>" contains=lojbanFuhivlaBreakableConsonantError,lojbanFuhivlaBreakableVowelError

endif

SUB syn match lojbanFuhivlaBreakableConsonantError contained "\(C\)\1"
SUB syn match lojbanFuhivlaBreakableConsonantError contained "OU\|UO"
SUB syn match lojbanFuhivlaBreakableConsonantError contained "BB"

SUB syn match lojbanFuhivlaBreakableVowelError contained "\%([aeo]i\|au\)\@!VV"

SUB syn match lojbanLujvo "\<CV'\=Vr\%(@@V\|RV'\=V\|RVCy\=\|@@VCy\|RVCCy\|@@V'\=VCy\)\%(@@V\|CV'\=V\|CVCy\=\|@@VCy\|CVCCy\|@@V'\=VCy\)*\%(@@V\|CV'\=V\|@@VCV\|CVCCV\)\>" contains=lojbanLujvoConsonantError,lojbanLujvoVowelError,lojbanRafsiCultural
SUB syn match lojbanLujvo "\<CV'\=Vn\%(rV'\=V\|rVCy\=\|rVCCy\)\%(@@V\|CV'\=V\|CVCy\=\|@@VCy\|CVCCy\|@@V'\=VCy\)*\%(@@V\|CV'\=V\|@@VCV\|CVCCV\)\>" contains=lojbanLujvoConsonantError,lojbanLujvoVowelError,lojbanRafsiCultural
SUB syn match lojbanLujvo "\<CV'\=Vr\%(RV'\=V\|@@VCV\|RVCCV\)\>" contains=lojbanLujvoConsonantError,lojbanLujvoVowelError
SUB syn match lojbanLujvo "\<CV'\=Vn\%(rV'\=V\|rVCCV\)\>" contains=lojbanLujvoConsonantError,lojbanLujvoVowelError
SUB syn match lojbanLujvo "\<CV'\=V@@V\>" contains=lojbanLujvoConsonantError,lojbanLujvoVowelError
SUB syn match lojbanLujvo "\<\%(@@V\|CVCy\=\|@@VCy\|CVCCy\|@@V'\=VCy\)\%(@@V\|CV'\=V\|CVCy\=\|@@VCy\|CVCCy\|@@V'\=VCy\)*\%(@@V\|CV'\=V\|@@VCV\|CVCCV\)\>" contains=lojbanLujvoConsonantError,lojbanLujvoVowelError,lojbanRafsiCultural,lojbanLujvoTosmabru

SUB syn match lojbanLujvoConsonantError contained "\(C\)\1"
SUB syn match lojbanLujvoConsonantError contained "OU\|UO"
SUB syn match lojbanLujvoConsonantError contained "BB"

SUB syn match lojbanLujvoVowelError contained "\%([aeo]i\|au\)\@!VV"

SUB syn match lojbanRafsiCultural contained "@@V'\=VCy" contains=lojbanRafsiCulturalConsonantError,lojbanRafsiCulturalVowelError

SUB syn match lojbanRafsiCulturalConsonantError contained "\(C\)\1"
SUB syn match lojbanRafsiCulturalConsonantError contained "OU\|UO"
SUB syn match lojbanRafsiCulturalConsonantError contained "BB"

SUB syn match lojbanRafsiCulturalVowelError contained "\%([aeo]i\|au\)\@!VV"

SUB syn match lojbanLujvoTosmabru contained "\<C\%(V@@\)\{2,}V\>" contains=lojbanLujvoTosmabruConsonantError,lojbanLujvoTosmabruVowelError
SUB syn match lojbanLujvoTosmabru contained "\<C\%(V@@\)\+VCyL\+\>" contains=lojbanLujvoTosmabruConsonantError,lojbanLujvoTosmabruVowelError

SUB syn match lojbanLujvoTosmabruConsonantError contained "\(C\)\1"
SUB syn match lojbanLujvoTosmabruConsonantError contained "OU\|UO"
SUB syn match lojbanLujvoTosmabruConsonantError contained "BB"

SUB syn match lojbanLujvoTosmabruVowelError contained "\%([aeo]i\|au\)\@!VV"

SUB syn match lojbanGismuUnknown "\<CCVCV\>" contains=lojbanGismuSpecificError,lojbanGismuConsonantError
SUB syn match lojbanGismuUnknown "\<CVCCV\>" contains=lojbanGismuConsonantError

SUB syn match lojbanGismuSpecificError contained "\<@@\@!CC"

SUB syn match lojbanGismuConsonantError contained "\(C\)\1"
SUB syn match lojbanGismuConsonantError contained "OU\|UO"
SUB syn match lojbanGismuConsonantError contained "BB"

SUB syn match lojbanCmavo "\<\%(Y\%('\=Y\)*\)\=\%([0-9]\|\%(C\%(V\|\%(Y\%('\=Y\)\+\)\)\)\)*\%(Cy\)*\>" contains=lojbanCmavoSimple,lojbanCmavoExperimental,lojbanCmavoIllegal,lojbanCmavoUnassigned,lojbanCmavoWrongHesitation

SUB syn match lojbanCmavoSimple contained "CV\%('\=V\)\=" contains=lojbanCmavoDiphtongError,lojbanCmavoVowelError
SUB syn match lojbanCmavoSimple contained "V\%('\=V\)\=" contains=lojbanCmavoVowelError
SUB syn match lojbanCmavoSimple contained "Cy"
syn match lojbanCmavoSimple contained "y\+"
syn match lojbanCmavoSimple contained "y'y"
syn match lojbanCmavoSimple contained "[0-9]"

SUB syn match lojbanCmavoExperimental contained "xV'\=V" contains=lojbanCmavoDiphtongError,lojbanCmavoVowelError
SUB syn match lojbanCmavoExperimental contained "C\=V\%('\=V\)\{2,}" contains=lojbanCmavoDiphtongError,lojbanCmavoVowelError

SUB syn match lojbanCmavoIllegal contained "V\%('\=Y\)*'\=y\%('\=Y\)*" contains=lojbanCmavoDiphtongError,lojbanCmavoVowelError
SUB syn match lojbanCmavoIllegal contained "y\%('\=Y\)*'\=V\%('\=Y\)*" contains=lojbanCmavoDiphtongError,lojbanCmavoVowelError
SUB syn match lojbanCmavoIllegal contained "y'yy\+" contains=lojbanCmavoVowelError
SUB syn match lojbanCmavoIllegal contained "yy\+'y\+" contains=lojbanCmavoVowelError
SUB syn match lojbanCmavoIllegal contained "Cy\%('\=Y\)\+" contains=lojbanCmavoDiphtongError,lojbanCmavoVowelError
SUB syn match lojbanCmavoIllegal contained "CV\%('\=Y\)*'\=y\%('\=Y\)*" contains=lojbanCmavoDiphtongError,lojbanCmavoVowelError

syn match lojbanCmavoUnassigned contained "bi'a\|bo'a\|bo'e\|bo'i\|bo'o\|bo'u\|ci'a"
syn match lojbanCmavoUnassigned contained "ja'u\|ne'e\|po'a\|te'i\|zi'a\|zi'i\|zi'u"

SUB syn match lojbanCmavoWrongHesitation contained "\<y\+\%([0-9]\|C\)\@="

syn match lojbanCmavoSimple contained "\<y\+bu\>"
SUB syn match lojbanCmavoSimple contained "\<y\+bu\%([0-9]\|C\)\@="

SUB syn match lojbanCmavoDiphtongError contained "[iu]V"
SUB syn match lojbanCmavoVowelError contained "\%([aeo]i\|au\|[iu]V\)\@!YY"

SUB syn match lojbanCmene "\<L*C\>" contains=lojbanCmeneConsonantError,lojbanCmeneSpecificError

SUB syn match lojbanCmeneConsonantError contained "\(C\)\1"
SUB syn match lojbanCmeneConsonantError contained "OU\|UO"
SUB syn match lojbanCmeneConsonantError contained "BB"

syn match lojbanCmeneSpecificError contained "\<doi"
syn match lojbanCmeneSpecificError contained "\<la[^u]"he=e-1
SUB syn match lojbanCmeneSpecificError contained "Ydoi"hs=s+1
SUB syn match lojbanCmeneSpecificError contained "Yla[^u]"he=e-1,hs=s+1

SUB syn match lojbanValsiIllegal "\<\k*C'\k*\>" contains=lojbanValsiIllegalConsonantError,lojbanValsiIllegalSpecificError
SUB syn match lojbanValsiIllegal "\<\k*'C\k*\>" contains=lojbanValsiIllegalConsonantError,lojbanValsiIllegalSpecificError
syn match lojbanValsiIllegal "\<[,']\k*\>" contains=lojbanValsiIllegalConsonantError,lojbanValsiIllegalSpecificError
syn match lojbanValsiIllegal "\k*[,']\>" contains=lojbanValsiIllegalConsonantError,lojbanValsiIllegalSpecificError
syn match lojbanValsiIllegal "\<\k*[,'][,']\k*\>" contains=lojbanValsiIllegalConsonantError,lojbanValsiIllegalSpecificError
SUB syn match lojbanValsiIllegal "\<\k*[hqw]\k*\>" contains=lojbanValsiIllegalConsonantError,lojbanValsiIllegalSpecificError

SUB syn match lojbanValsiIllegalConsonantError contained "\(C\)\1"
SUB syn match lojbanValsiIllegalConsonantError contained "OU\|UO"
SUB syn match lojbanValsiIllegalConsonantError contained "BB"

SUB syn match lojbanValsiIllegalSpecificError contained "C'"hs=s+1
SUB syn match lojbanValsiIllegalSpecificError contained "'C"he=e-1
syn match lojbanValsiIllegalSpecificError contained "\<[,']"
syn match lojbanValsiIllegalSpecificError contained "[,']\>"
syn match lojbanValsiIllegalSpecificError contained "[,'][,']"
SUB syn match lojbanValsiIllegalSpecificError contained "[hqw]"

syn region lojbanQuoteBalanced start="\<lu\>" end="\<li'u\>" transparent extend keepend contains=TOP

SUB syn match lojbanLetteral "\(\<bu\>\)\@!\<\k\+\>\(__\+\<bu\>\)\+" transparent extend contains=TOP,lojbanQuoteBalanced,lojbanLetteral,lojbanQuoteSequence,lojbanQuoteForeign,lojbanQuoteSingle

syn region lojbanQuoteSequence start="\<lo'u\>" end="\<le'u\>" transparent extend keepend contains=TOP,lojbanQuoteBalanced,lojbanLetteral,lojbanQuoteSequence

syn match lojbanQuoteForeign "\<la'o\>\|\<zoi\>" nextgroup=lojbanQuoteJoiner transparent extend contains=TOP
SUB syn match lojbanQuoteJoiner "__\{-1,}\%(\.*\k\)\@=" contained nextgroup=lojbanTextForeign transparent extend contains=lojbanComment,lojbanPause
syn region lojbanTextForeign contained matchgroup=lojbanQuoteSymbol start="\.*\<\z(\k\+\)\>\.*" end="\.*\<\z1\>\.*" extend

SUB syn match lojbanQuoteSingle "\<zo\>__\+\<\k\+\>" transparent extend contains=TOP,lojbanQuoteBalanced,lojbanLetteral,lojbanQuoteSequence,lojbanQuoteForeign,lojbanQuoteSingle

SUB syn region lojbanParagraph start="\_^##*\<ni'o\>\%(##\+\<ni'o\>\)\@!" end="\ze\_^##*\<\(ni'o\)\+\>\|\_^##*\<\(no'i\)\+\>" fold transparent keepend contains=TOP
SUB syn region lojbanParagraph start="\_^##*\<ni'o\>##\+\<ni'o\>\%(##\+\<ni'o\>\)\@!\|\_^##*\<ni'oni'o\>" end="\ze\_^##*\<ni'o\>##\+\<ni'o\>\|\ze\_^##*\<\(ni'o\)\{2,}\>\|\_^##*\<no'i\>##\+\<no'i\>\|\_^##*\<\(no'i\)\{2,}\>" fold transparent keepend contains=TOP
SUB syn region lojbanParagraph start="\_^##*\<ni'o\>##\+\<ni'o\>##\+\<ni'o\>\|\_^##*\<\(ni'o\)\{3,}\>" end="\ze\_^##*\<ni'o\>##\+\<ni'o\>##\+\<ni'o\>\|\ze\_^##*\<\(ni'o\)\{3,}\>\|\_^##*\<no'i\>##\+\<no'i\>##\+\<no'i\>\|\_^##*\<\(no'i\)\{3,}\>" fold transparent keepend contains=TOP

syn keyword lojbanGismu bacru badna badri bajra bakfu bakni bakri baktu balji balni
syn keyword lojbanGismu balre balvi bancu bandu banfi bangu banli banro banxa banzu
syn keyword lojbanGismu bapli barda bargu barja barna bartu basna basti batci batke
syn keyword lojbanGismu bavmi baxso bebna bemro bende bengo benji bersa berti besna
syn keyword lojbanGismu betfu betri bevri bidju bifce bikla bilga bilma bilni bindo
syn keyword lojbanGismu binra binxo birje birka birti bisli bitmu blabi blaci blanu
syn keyword lojbanGismu bliku bloti bolci bongu botpi boxfo boxna bradi bratu brazo
syn keyword lojbanGismu bredi bridi brife briju brito broda brode brodi brodo brodu
syn keyword lojbanGismu bruna budjo bukpu bumru bunda bunre burcu burna cabna cabra
syn keyword lojbanGismu cacra cadzu cafne cakla calku canci cando cange canja canko
syn keyword lojbanGismu canlu canpa canre canti carce carmi carna cartu carvi casnu
syn keyword lojbanGismu catke catlu catni catra caxno cecla cecmu cedra cenba censa
syn keyword lojbanGismu centi cerda cerni certu cevni cfari cfika cfila cfine cfipu
syn keyword lojbanGismu ciblu cicna cidja cidni cidro cifnu cigla cikna cikre ciksi
syn keyword lojbanGismu cilce cilmo cilre cilta cimde cimni cinba cindu cinfo cinje
syn keyword lojbanGismu cinki cinla cinmo cinri cinse cinta cinza cipni cipra cirko
syn keyword lojbanGismu cirla ciska cisma ciste citka citno citri citsi civla cizra
syn keyword lojbanGismu ckabu ckafi ckaji ckana ckape ckasu ckeji ckiku ckilu ckini
syn keyword lojbanGismu ckire ckule ckunu cladu clani claxu clika clira clite cliva
syn keyword lojbanGismu clupa cmaci cmalu cmana cmavo cmene cmila cmima cmoni cnano
syn keyword lojbanGismu cnebo cnemu cnici cnino cnisa cnita cokcu condi cortu cpacu
syn keyword lojbanGismu cpana cpare cpedu cpina cradi crane creka crepu cribe crida
syn keyword lojbanGismu crino cripu crisa critu ctaru ctebi cteki ctile ctino ctuca
syn keyword lojbanGismu cukla cukta culno cumki cumla cunmi cunso cuntu cupra curmi
syn keyword lojbanGismu curnu curve cusku cutci cutne cuxna dacru dacti dadjo dakfu
syn keyword lojbanGismu dakli damba damri dandu danfu danlu danmo danre dansu danti
syn keyword lojbanGismu daplu dapma dargu darlu darno darsi darxi daski dasni daspo
syn keyword lojbanGismu dasri datka datni decti degji dejni dekpu dekto delno dembi
syn keyword lojbanGismu denci denmi denpa dertu derxi desku detri dicra dikca diklo
syn keyword lojbanGismu dikni dilcu dilnu dimna dinju dinko dirba dirce dirgo dizlo
syn keyword lojbanGismu djacu djedi djica djine djuno donri dotco draci drani drata
syn keyword lojbanGismu drudi dugri dukse dukti dunda dunja dunku dunli dunra dzena
syn keyword lojbanGismu dzipo facki fadni fagri falnu famti fancu fange fanmo fanri
syn keyword lojbanGismu fanta fanva fanza fapro farlu farna farvi fasnu fatci fatne
syn keyword lojbanGismu fatri febvi femti fendi fengu fenki fenra fenso fepni fepri
syn keyword lojbanGismu ferti festi fetsi figre filso finpe finti flalu flani flecu
syn keyword lojbanGismu fliba flira foldi fonmo fonxa forca fraso frati fraxu frica
syn keyword lojbanGismu friko frili frinu friti frumu fukpi fulta funca fusra fuzme
syn keyword lojbanGismu gacri gadri galfi galtu galxe ganlo ganra ganse ganti ganxo
syn keyword lojbanGismu ganzu gapci gapru garna gasnu gasta genja gento genxu gerku
syn keyword lojbanGismu gerna gidva gigdo ginka girzu gismu glare gleki gletu glico
syn keyword lojbanGismu gluta gocti gotro gradu grake grana grasu greku grusi grute
syn keyword lojbanGismu gubni gugde gundi gunka gunma gunro gunse gunta gurni guska
syn keyword lojbanGismu gusni gusta gutci gutra guzme jabre jadni jakne jalge jalna
syn keyword lojbanGismu jalra jamfu jamna janbe janco janli jansu janta jarbu jarco
syn keyword lojbanGismu jarki jaspu jatna javni jbama jbari jbena jbera jbini jdari
syn keyword lojbanGismu jdice jdika jdima jdini jduli jecta jeftu jegvo jelca jemna
syn keyword lojbanGismu jenca jendu jenmi jerna jersi jerxo jesni jetce jetnu jgalu
syn keyword lojbanGismu jganu jgari jgena jgina jgira jgita jibni jibri jicla jicmu
syn keyword lojbanGismu jijnu jikca jikru jilka jilra jimca jimpe jimte jinci jinga
syn keyword lojbanGismu jinku jinme jinru jinsa jinto jinvi jinzi jipci jipno jirna
syn keyword lojbanGismu jisra jitfa jitro jivbu jivna jmaji jmifa jmina jmive jordo
syn keyword lojbanGismu jorne jubme judri jufra jukni jukpa julne jundi jungo junla
syn keyword lojbanGismu junri junta jurme jursa jutsi juxre jvinu kabri kacma kadno
syn keyword lojbanGismu kafke kagni kajde kajna kakne kakpa kalci kalri kalsa kalte
syn keyword lojbanGismu kamju kamni kampu kanba kancu kandi kanji kanla kanro kansa
syn keyword lojbanGismu kantu kanxe karbi karce karda kargu karli karni katna kavbu
syn keyword lojbanGismu kecti kelci kelvo kenra kensa kerfa kerlo ketco kevna kicne
syn keyword lojbanGismu kijno kilto kinli kisto klaji klaku klama klani klesi klina
syn keyword lojbanGismu kliru kliti klupe kluza kobli kojna kolme komcu konju korbi
syn keyword lojbanGismu korcu korka kosta kramu krasi krati krefu krici krili krinu
syn keyword lojbanGismu krixa kruca kruji kruvi kubli kucli kufra kukte kulnu kumfa
syn keyword lojbanGismu kumte kunra kunti kurfa kurji kurki kuspe kusru labno lacpu
syn keyword lojbanGismu lacri ladru lafti lakne lakse lalxu lamji lanbi lanci lanka
syn keyword lojbanGismu lanli lanme lante lanxe lanzu larcu lasna lastu latmo latna
syn keyword lojbanGismu lazni lebna lenjo lenku lerci lerfu libjo lidne lifri lijda
syn keyword lojbanGismu limna lindi linji linsi linto lisri liste litce litki litru
syn keyword lojbanGismu livga livla logji lojbo loldi lorxu lubno lujvo lumci lunbe
syn keyword lojbanGismu lunra lunsa mabla mabru macnu makcu makfa maksi malsi mamta
syn keyword lojbanGismu manci manfo manku manri mansa manti mapku mapni mapti marbi
syn keyword lojbanGismu marce marde margu marji marna marxa masno masti matci matli
syn keyword lojbanGismu matne matra mavji maxri mebri megdo mekso melbi meljo menli
syn keyword lojbanGismu mensi mentu merko merli mexno midju mifra mikce mikri milti
syn keyword lojbanGismu milxe minde minji minli minra mintu mipri mirli misno misro
syn keyword lojbanGismu mitre mixre mlana mlatu mleca mledi mluni mokca moklu molki
syn keyword lojbanGismu molro morji morko morna morsi mosra mraji mrilu mruli mucti
syn keyword lojbanGismu mudri mukti mulno munje mupli murse murta muslo mutce muvdu
syn keyword lojbanGismu muzga nabmi nakni nalci namcu nanba nanca nandu nanla nanmu
syn keyword lojbanGismu nanvi narge narju natfe natmi navni naxle nazbi nejni nelci
syn keyword lojbanGismu nenri nibli nicte nikle nilce nimre ninmu nirna nitcu nivji
syn keyword lojbanGismu nixli nobli notci nukni nupre nurma nutli nuzba pacna pagbu
syn keyword lojbanGismu pagre pajni palci palku palne palta pambe panci pandi panje
syn keyword lojbanGismu panka panlo panpi panra pante panzi papri parbi pastu patfu
syn keyword lojbanGismu patlu patxu pelji pelxu pemci penbi pencu pendo penmi pensi
syn keyword lojbanGismu perli pesxu petso pezli picti pijne pikci pikta pilji pilka
syn keyword lojbanGismu pilno pimlu pinca pindi pinfu pinji pinka pinsi pinta pinxe
syn keyword lojbanGismu pipno pixra plana platu pleji plibu plini plipe plise plita
syn keyword lojbanGismu plixa pluja pluka pluta polje polno ponjo ponse porpi porsi
syn keyword lojbanGismu porto prali prami prane preja prenu preti prije prina pritu
syn keyword lojbanGismu prosa pruce pruni pruxi pulce pulji pulni punji punli purci
syn keyword lojbanGismu purdi purmo racli ractu radno rafsi ragve rakso raktu ralci
syn keyword lojbanGismu ralju ralte randa rango ranji ranmi ransu ranti ranxi rapli
syn keyword lojbanGismu rarna ratcu ratni rebla rectu remna renro renvi respa ricfu
syn keyword lojbanGismu rigni rijno rilti rimni rinci rinju rinka rinsa rirci rirni
syn keyword lojbanGismu rirxe rismi risna ritli rivbi rokci romge ropno rorci rotsu
syn keyword lojbanGismu rozgu ruble rufsu runme runta rupnu rusko rutni sabji sabnu
syn keyword lojbanGismu sacki saclu sadjo sakci sakli sakta salci salpo salta samcu
syn keyword lojbanGismu sampu sance sanga sanji sanli sanmi sanso santa sarcu sarji
syn keyword lojbanGismu sarlu sarxe saske satci satre savru sazri sefta selci selfu
syn keyword lojbanGismu semto senci senpi senta senva sepli serti setca sevzi sfani
syn keyword lojbanGismu sfasa sfofa sfubu siclu sicni sidbo sidju sigja silka silna
syn keyword lojbanGismu simlu simsa simxu since sinma sinso sinxa sipna sirji sirxo
syn keyword lojbanGismu sisku sisti sitna sivni skaci skami skapi skari skicu skiji
syn keyword lojbanGismu skina skori skoto skuro slabu slaka slami slanu slari slasi
syn keyword lojbanGismu sligu slilu sliri slovo sluji sluni smacu smadi smaji smani
syn keyword lojbanGismu smoka smuci smuni snada snanu snidu snime snipa snuji snura
syn keyword lojbanGismu snuti sobde sodna sodva softo solji solri sombo sonci sorcu
syn keyword lojbanGismu sorgu sovda spaji spali spano spati speni spisa spita spofu
syn keyword lojbanGismu spoja spuda sputu sraji sraku sralo srana srasu srera srito
syn keyword lojbanGismu sruma sruri stace stagi staku stali stani stapa stasu stati
syn keyword lojbanGismu steba steci stedu stela stero stici stidi stika stizu stodi
syn keyword lojbanGismu stuna stura stuzi sucta sudga sufti suksa sumji sumne sumti
syn keyword lojbanGismu sunga sunla surla sutra tabno tabra tadji tadni tagji talsa
syn keyword lojbanGismu tamca tamji tamne tanbo tance tanjo tanko tanru tansi tanxe
syn keyword lojbanGismu tapla tarbi tarci tarla tarmi tarti taske tatpi tatru tavla
syn keyword lojbanGismu taxfu tcaci tcadu tcana tcati tcena tcica tcidu tcika tcila
syn keyword lojbanGismu tcima tcini tcita temci tenfa tengu terdi terpa terto tigni
syn keyword lojbanGismu tikpa tilju tinbe tinci tinsa tirna tirse tirxu tisna titla
syn keyword lojbanGismu tivni tixnu toknu toldi tonga tordu torni traji trano trati
syn keyword lojbanGismu trene tricu trina trixe troci tsali tsani tsapi tsiju tsina
syn keyword lojbanGismu tubnu tugni tujli tumla tunba tunka tunlo tunta tuple turni
syn keyword lojbanGismu tutci tutra vacri vajni valsi vamji vamtu vanbi vanci vanju
syn keyword lojbanGismu vasru vasxu vecnu venfu vensa verba vibna vidni vidru vifne
syn keyword lojbanGismu vikmi viknu vimcu vindu vinji vipsi virnu viska vitci vitke
syn keyword lojbanGismu vitno vlagi vlile vlina vlipa vofli voksa vorme vraga vreji
syn keyword lojbanGismu vreta vrici vrude vrusi vukro xabju xadba xadni xagji xagri
syn keyword lojbanGismu xajmi xaksu xalbo xalka xalni xamgu xampo xamsi xance xanka
syn keyword lojbanGismu xanri xanto xarci xarju xarnu xasli xasne xatra xatsi xazdo
syn keyword lojbanGismu xebni xebro xecto xedja xekri xelso xendo xenru xexso xindo
syn keyword lojbanGismu xinmo xirma xislu xispo xlali xlura xotli xrabo xrani xriso
syn keyword lojbanGismu xruba xruki xrula xruti xukmi xunre xurdo xusra xutla zabna
syn keyword lojbanGismu zajba zalvi zanru zarci zargu zasni zasti zbabu zbani zbasu
syn keyword lojbanGismu zbepi zdani zdile zekri zenba zepti zetro zgana zgike zifre
syn keyword lojbanGismu zinki zirpu zivle zmadu zmiku zukte zumri zungi zunle zunti
syn keyword lojbanGismu zutse zvati

" Add your favorite unofficial cultural gismu here!

syn keyword lojbanGismuUnofficial loglo norgo nuzlo spero talno turko xorvo

hi def lojbanComment term=None cterm=None gui=None
hi def lojbanPause term=bold cterm=bold gui=bold
hi def lojbanValsiUnrecognized term=reverse ctermfg=Red gui=undercurl guifg=Red guisp=Magenta
hi def lojbanValsiUnrecognizedConsonantError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanValsiUnrecognizedVowelError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanFuhivlaUnrecognized term=reverse ctermfg=Red gui=undercurl guifg=Blue guisp=Magenta
hi def lojbanFuhivlaUnrecognizedConsonantError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanFuhivlaUnrecognizedVowelError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanFuhivlaUnrecognizedHyphenError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanFuhivla term=underline ctermfg=Blue guifg=Blue
hi def lojbanFuhivlaConsonantError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanFuhivlaVowelError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanFuhivlaSlinkuhi term=reverse ctermfg=Red gui=undercurl guifg=Blue guisp=Magenta
hi def lojbanFuhivlaSlinkuhiConsonantError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanFuhivlaBreakable term=reverse ctermfg=Red gui=undercurl guifg=Blue guisp=Magenta
hi def lojbanFuhivlaBreakableConsonantError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanFuhivlaBreakableVowelError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanFuhivlaStrong term=underline ctermfg=Blue guifg=Blue
hi def lojbanFuhivlaStrongConsonantError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanFuhivlaStrongVowelError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanLujvo term=underline ctermfg=Cyan guifg=Cyan
hi def lojbanLujvoConsonantError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanLujvoVowelError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanRafsiCultural term=underline ctermfg=Blue gui=undercurl guifg=Cyan guisp=Blue
hi def lojbanRafsiCulturalConsonantError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanRafsiCulturalVowelError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanLujvoTosmabru term=reverse ctermfg=Red gui=undercurl guifg=Cyan guisp=Magenta
hi def lojbanLujvoTosmabruConsonantError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanLujvoTosmabruVowelError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanGismuUnknown term=reverse ctermfg=Red gui=undercurl guifg=Green guisp=Magenta
hi def lojbanGismuSpecificError term=reverse ctermbg=Green gui=undercurl guibg=Green guisp=Green
hi def lojbanGismuConsonantError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanCmavoSimple term=bold ctermfg=Yellow guifg=Brown
hi def lojbanCmavoExperimental term=bold ctermfg=Blue gui=undercurl guifg=Brown guisp=Blue
hi def lojbanCmavoIllegal term=reverse ctermfg=Red gui=undercurl guifg=Brown guisp=Magenta
hi def lojbanCmavoUnassigned term=reverse ctermfg=Blue gui=undercurl guifg=Brown guisp=Blue
hi def lojbanCmavoWrongHesitation term=reverse ctermfg=Red gui=undercurl guifg=Brown guisp=Magenta
hi def lojbanCmavoDiphtongError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanCmavoVowelError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanCmene term=italic ctermfg=Magenta guifg=Magenta
hi def lojbanCmeneConsonantError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanCmeneSpecificError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanValsiIllegal term=reverse ctermfg=Red gui=undercurl guifg=Red guisp=Magenta
hi def lojbanValsiIllegalConsonantError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanValsiIllegalSpecificError term=reverse ctermbg=Red gui=undercurl guibg=Red guisp=Red
hi def lojbanQuoteSymbol term=bold cterm=bold gui=bold
hi def lojbanTextForeign term=None cterm=None gui=None
hi def lojbanGismu term=underline ctermfg=Green guifg=Green 
hi def lojbanGismuUnofficial term=underline ctermfg=Blue gui=undercurl guifg=Green guisp=Blue

if g:lojban_fancy == 0

  let s:colors = ["Black", "DarkBlue", "DarkGreen", "DarkCyan",
        \         "DarkRed", "DarkMagenta", "Brown", "Gray",
        \         "DarkGray", "Blue", "Green", "Cyan",
        \         "Red", "Magenta", "Yellow", "White"]

  let s:synID = 1
  let s:name = synIDattr(s:synID, "name", "cterm")
  
  while s:name != ""
    if s:name =~ "^lojban"
      let s:fg = synIDattr(s:synID, "fg", "cterm")
      let s:fgarg = ""
      if s:fg != -1
        if s:fg =~ '^\d\+$'
          let s:fg = s:colors[s:fg]
        endif
        let s:guifg = s:fg == "Yellow" ? "Brown" : s:fg
        let s:fgarg = " ctermfg=" . s:fg . " guifg=" . s:guifg
      endif
      let s:bg = synIDattr(s:synID, "bg", "cterm")
      let s:bgarg = ""
      if s:bg != -1
        if s:bg =~ '^\d\+$'
          let s:bg = s:colors[s:bg]
        endif
        let s:bgarg = " ctermbg=" . s:bg . " guibg=" . s:bg
      endif
      let s:attr = "None"
      for s:what in ["bold", "italic", "reverse", "underline", "undercurl"]
        if synIDattr(s:synID, s:what, "cterm")
          let s:attr .= "," . s:what
        endif
      endfor
      let s:arg = " cterm=" . s:attr . " gui=" . s:attr
      execute "hi clear " . s:name
      execute "hi def " . s:name . s:arg . s:fgarg . s:bgarg
    endif
    let s:synID += 1
    let s:name = synIDattr(s:synID, "name", "cterm")
  endwhile

endif

delcommand SUB

let b:current_syntax = "lojban"
