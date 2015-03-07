call pathogen#infect()

"
" settings
"

set   autoindent
set noautochdir
set   backspace=indent,eol,start
set   bg=dark
set nocompatible
set   expandtab
set   foldmethod=indent
set   foldlevelstart=99
set   guioptions+=a " autoselect
set   history=500
set   ignorecase
set   incsearch
set   laststatus=2 " always show status line
set   list listchars=tab:»\ ,trail:·,nbsp:⎵,extends:…
set   number
set   ruler
set   shiftwidth=2
set   scroll=15
set   scrolloff=3 " scroll 3 lines before end
set   showcmd
set   smartcase
set   softtabstop=2
set   splitbelow
set   splitright
set   tabstop=4
set   textwidth=0 wrapmargin=0
set   whichwrap+=<,>,h,l,[,]
set nowrap

" modify scroll value: ^d / ^u move by 1/3 of buffer height instead of 1/2
" TODO why errors when 16 or fewer lines high? E49: Invalid scroll size: scroll=15
execute "set scroll=" . &lines / 3
au VimResized * execute "set scroll=" . &lines / 3

" json files use js highlighting
autocmd BufNewFile,BufRead *.json set ft=javascript

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch

  let g:netrw_liststyle=3 " NerdTree style

  let g:airline_theme='simple'
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#branch#displayed_head_limit = 12

  let g:ctrlp_show_hidden = 1

  let g:solarized_termtrans=1
  let g:solarized_termcolors=256
  colorscheme solarized
  highlight MatchParen cterm=bold ctermfg=white ctermbg=none

  highlight clear SignColumn
  autocmd ColorScheme * highlight clear SignColumn

  "let g:indentLine_color_term=239
  let g:indentLine_color_gui='#00FF00'
  let g:indentLine_char='┊'

  " use custom coffeelint configuration
  let g:coffee_lint_options='~/coffeelint.json'

endif


"
" mappings
"

" make Y behave like other capitals
map Y y$

" splits navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" space to toggle fold
" shift-space to close fold
nnoremap <Space> za
nnoremap <S-Space> zc

" buffer list
nnoremap <Leader><Leader> :buffers<CR>:b

" shift-k: opposite of shift-j, h/t http://vim.wikia.com/wiki/Insert_newline_without_entering_insert_mode
nnoremap K a<CR><Esc>k$

" gj, gk: vertical movement through whitespace
" thanks, WChargin! http://vi.stackexchange.com/a/156/67
function FloatUp()
  while line(".") > 1 && (strlen(getline(".")) < col(".") || getline(".")[col(".") - 1] =~ '\s')
    norm k
  endwhile
endfunction
function FloatDown()
  while line(".") > 1 && (strlen(getline(".")) < col(".") || getline(".")[col(".") - 1] =~ '\s')
    norm j
  endwhile
endfunction
nnoremap gk :call FloatUp()<CR>
nnoremap gj :call FloatDown()<CR>

" re-highlight
" by Steve Losh (slj) https://bitbucket.org/sjl/dotfiles/src/603bb1ae/vim/vimrc?at=default#cl-445
nnoremap U :syntax sync fromstart<CR>:redraw!<CR>

" toggle comment of paragraph, uses NERDCommenter
map <Leader>cp {jV}k\ci

" make splits bigger
map ,w <C-w>10>
map ,W <C-w>5+

" create tags file
map <Leader>ct :!/usr/local/bin/ctags --recurse -f .git/tags --exclude=pkg --exclude=.git --exclude=coverage --exclude=jscoverage .<CR>

" 'home-row' shortcut for escape
" thanks, Doorknob! http://vi.stackexchange.com/a/309/67
inoremap jk <esc>
inoremap kj <esc>

" remove all trailing whitespace
" http://vi.stackexchange.com/a/2285/67
nnoremap <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <CR>

" Git
" view last diff
command GitLastDiff !git log -1 -u
map gld :GitLastDiff<CR>

" read last commit message
command GitLastMessage :r !git log -1u
map glm :GitLastMessage<CR>

" jump to next/prev edited area
map <Leader>k :GitGutterPrevHunk<CR>
map <Leader>j :GitGutterNextHunk<CR>

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

" \q for vim-bbye's :Bdelete
nnoremap <Leader>q :Bdelete<CR>


"
" plugin configuration
"

filetype plugin indent on

" CtrlP
let g:ctrlp_show_hidden = 1

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

" fix numpad mappings
" http://swannie.net/index.php?title=Numeric+keypad+in+iTerm+with+vi&function=viewpage&pageid=24
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

" set up tab labels with tab number, buffer name, number of windows
" http://vim.wikia.com/wiki/Show_tab_number_in_your_tab_line
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


"
" macros!
"

let @c='\cij' " comment or uncomment (uses NERDCommenter plugin)
