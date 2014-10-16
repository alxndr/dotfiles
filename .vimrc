call pathogen#infect()

set autoindent
set backspace=indent,eol,start
set bg=dark
set expandtab
set foldmethod=indent
set foldlevelstart=99
set guioptions+=a " autoselect
set history=500
set ignorecase
set incsearch
set laststatus=2 " always show status line
set list listchars=tab:»·,trail:·
set nocompatible
set nowrap
set number
set relativenumber " tweaked below
set ruler
set shiftwidth=2
set scroll=15
set scrolloff=3 " scroll 3 lines before end
set showcmd
set smartcase
set softtabstop=2
set splitbelow
set splitright
set tabstop=4
set textwidth=0 wrapmargin=0
set whichwrap+=<,>,h,l,[,]

" relative numbering on focus, normal on blur
autocmd BufEnter * set relativenumber
autocmd BufLeave * set number

" make Y behave like other capitals
map Y y$

" switching buffers w/o a modifier
nnoremap gb <C-w><C-w>
nnoremap gj <C-w>j
nnoremap gk <C-w>k
nnoremap gh <C-w>h
nnoremap gl <C-w>l

" convert ruby 1.8 hash style to 1.9 style
nnoremap \: :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<return>

"" system clipboard paste
"nnoremap ,v :r !pbpaste
"nnoremap ,V ,v

" space to toggle fold
" shift-space to close fold
nnoremap <Space> za
nnoremap <S-Space> zc

" buffer list
nnoremap <leader><leader> :buffers<CR>:buffer<Space>

" :grep for word under cursor
nnoremap ,g :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" slash-slash to search for visual selection, h/t http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnorem // y/<c-r>"<cr>

" shift-k: opposite of shift-j, h/t http://vim.wikia.com/wiki/Insert_newline_without_entering_insert_mode
nnoremap K a<CR><Esc>k$

" TODO fix. resize splits
nnoremap <C-+> <C-W>+
nnoremap <C--> <C-W>-
nnoremap <C-<> <C-W><
nnoremap <C->> <C-W>>


" modify scroll value: ^d / ^u move by 1/3 of buffer height instead of 1/2
execute "set scroll=" . &lines / 3
au VimResized * execute "set scroll=" . &lines / 3


" Git
" view last diff
command GitLastDiff !git log -1 -u
map gld :GitLastDiff<CR>

" read last commit message
command GitLastMessage :r !git log -1u
map glm :GitLastMessage<CR>

" toggle comment of paragraph, uses NERDCommenter's \ci
map ,cp {jV}k\ci

" jump to next/prev edited area
map <Leader>k :GitGutterPrevHunk<CR>
map <Leader>j :GitGutterNextHunk<CR>

" create tags file
map <Leader>ct :!/usr/local/bin/ctags --recurse -f .git/tags --exclude=pkg --exclude=.git --exclude=coverage --exclude=jscoverage .<CR>

" buffer shortcuts
nnoremap \1 :b1<CR>
nnoremap \2 :b2<CR>
nnoremap \3 :b3<CR>
nnoremap \4 :b4<CR>
nnoremap \5 :b5<CR>
nnoremap \6 :b6<CR>
nnoremap \7 :b7<CR>
nnoremap \8 :b8<CR>
nnoremap \9 :b9<CR>

" json files use js highlighting
autocmd BufNewFile,BufRead *.json set ft=javascript

" GUI stuff
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch

  let g:airline_powerline_fonts = 1

  let g:solarized_termtrans=1
  let g:solarized_termcolors=256
  colorscheme solarized
  highlight MatchParen cterm=bold ctermfg=white ctermbg=none

  highlight clear SignColumn
  autocmd ColorScheme * highlight clear SignColumn

  "let g:indentLine_color_term=239
  let g:indentLine_color_gui='#00FF00'
  let g:indentLine_char='┊'

endif


"
" plugin configuration
"

filetype plugin indent on

" CtrlP
let g:ctrlp_show_hidden = 1
nnoremap <C-l> :CtrlP<CR>

" synatstic
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_json_checkers=['jsonlint']
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='!'

" silver searcher tweaks
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor                  " use ag for grep
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' " use ag in CtrlP for listing files
  let g:ctrlp_use_caching = 0                           " ag is fast enough that CtrlP doesn't need to cache
endif

" GitGutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '∼'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_modified_removed = '⋍'

" vim-airline
let g:airline_section_x = ''
let g:airline_section_y = "%{&fileformat=='unix'?'':&fileformat}%{&fileencoding!='utf-8'?&fileformat!='unix'?', ':'':''}%{&fileencoding=='utf-8'?'':&fileencoding}"

" no more arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" very-magic regexes by default
nnoremap / /\v
vnoremap / /\v

" fix numpad mappings, http://swannie.net/index.php?title=Numeric+keypad+in+iTerm+with+vi&function=viewpage&pageid=24
if &term=~"xterm" || &term=="xterm-color"
  imap <Esc>Oq 1
  imap <Esc>Or 2
  imap <Esc>Os 3
  imap <Esc>Ot 4
  imap <Esc>Ou 5
  imap <Esc>Ov 6
  imap <Esc>Ow 7
  imap <Esc>Ox 8
  imap <Esc>Oy 9
  imap <Esc>Op 0
  imap <Esc>On .
  imap <Esc>OQ /
  imap <Esc>OR *
  imap <Esc>Ol +
  imap <Esc>OS -
  "imap ?????? =
endif

" \q for vim-bbye's :Bdelete
nnoremap <Leader>q :Bdelete<CR>

" comment macros
" @3 for # before, @l for // before
" @4 for # after, @s for // after
let @3='I#'
let @4='A # '
let @l='I//'
let @s='A // '



" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor
  " Append the tab number
  let label .= v:lnum.': '
  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name
  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}
