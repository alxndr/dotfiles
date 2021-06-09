set noautochdir
set   background=dark
set   diffopt+=vertical
set   expandtab
set   foldlevelstart=99
set   foldmethod=syntax
set   hlsearch
set   ignorecase
set   inccommand=nosplit
set   incsearch
set   iskeyword-=.
set   laststatus=2
set   lazyredraw
set   list listchars=tab:␉\ ,trail:␠,nbsp:⎵,extends:⋯
set   mouse=
set   number
set   relativenumber
set   scrolloff=2
set   shell=zsh
set   shiftwidth=0
set   showcmd
set   smartcase
set   splitbelow splitright
set   tabstop=2
set notermguicolors
set   wildcharm=<C-z> " need this before we can remap <Tab>
set   wildignore+=*/tmp/*,*.dump,*.pyc,*.so,*.swp,*.zip,*/data.*@*/*,*/log.*@*/*,*/.sass-cache/*,*/.git/*,*/.idea/*,*/node_modules/*
set nowrap

if executable('rg')
  set grepprg=rg\ --vimgrep
elseif isdirectory('.git') && executable('git')
  set grepprg=git\ grep\ -nI
endif

" h/t grep helpfile
command! -nargs=+ GrepQF execute 'silent grep! <args>' | copen "42


"""""""""""
" Plugins "
"""""""""""

" set up vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source '~/.config/nvim/init.vim'
endif

call plug#begin("~/.config/nvim/plugged")

  " Abolish: assorted helpers by @tpope
  Plug 'tpope/vim-abolish'
    nnoremap <Leader>cc crc " coerce to camelCase
    nnoremap <Leader>cs crs " coerce to snake_case
    nnoremap <Leader>cu cru " coerce to UPPER_SNAKE

  " Airline: fancy status line
  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme = 'ouo'
    let g:airline_powerline_fonts = 1
    let g:airline_section_x = 0 " hide tagbar, filetype, virtualenv section
    let g:airline_section_y = 0 " hide fileencoding, fileformat section
    let g:airline_skip_empty_sections = 1
    let g:airline#extensions#hunks#enabled = 0 " hide git change summary
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    let g:airline#extensions#whitespace#enabled = 0 " hide [88]trailing

  " ALE: linting engine
  Plug 'w0rp/ale'
    let g:ale_fixers = {
    \  '*': ['remove_trailing_lines', 'trim_whitespace'],
    \  'jasmine.javascript': ['eslint'],
    \  'javascript': ['eslint'],
    \}
    " call ale#linter#Define('gitcommit', {
    " \   'name': 'husky',
    " \   'language': 'gitcommit',
    " \   'lsp': 'stdio',
    " \   'executable': './.git/hooks/post-commit',
    " \   'command': '%e',
    " \})
    let g:ale_linters = {
    \  'gitcommit': ['gitlint'],
    \  'jasmine.javascript': ['eslint'],
    \  'javascript': ['eslint'],
    \  'json': ['jsonlint'],
    \  'scheme': ['raco'],
    \  'sass': ['sass-lint', 'scss-lint'],
    \}
    let g:ale_pattern_options = {
    \  '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
    \  '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
    \} " Do not lint or fix minified files.
    let g:ale_sign_error = '🚨'
    let g:ale_sign_warning = '⚠️'
    let g:ale_lint_on_enter = 0
    let g:ale_lint_on_save = 1
    let g:ale_sign_column_always = 0
    let g:ale_lint_delay = 300

  " BBye: smart buffer deleter
  Plug 'moll/vim-bbye'

  " COC: code completion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " EditorConfig: coding style documentor
  Plug 'editorconfig/editorconfig-vim'
    let g:EditorConfig_exclude_patterns = ['fugitive://.*']
    let g:EditorConfig_indent_style = 'space'

  " Emoji: 🌚
  Plug 'junegunn/vim-emoji'

  " Floaterm: Terminal in floating window
  Plug 'voldikss/vim-floaterm'

  " Fugitive: Git wrapper
  Plug 'tpope/vim-fugitive'
    nnoremap ,gc :Git commit<CR>
    nnoremap ,gp :Git push
    nnoremap ,gP :Git push --force
    nnoremap ,gs :Git<CR>

  " FZF: 'fuzzy' text finder
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " to install via plug
  Plug 'junegunn/fzf.vim' " helpers to use FZF as file finder
  " Customize fzf colors to match your color scheme … https://github.com/junegunn/fzf/blob/ab11b74/README-VIM.md#examples
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

  " GitGutter: mark diff status in gutter
  Plug 'airblade/vim-gitgutter'
    let g:gitgutter_sign_added = '+'
    let g:gitgutter_sign_modified = 'δ'
    let g:gitgutter_sign_removed = '✂︎'
    let g:gitgutter_sign_removed_first_line = '✃'
    let g:gitgutter_sign_modified_removed = '✁'

  " GitLink: generate URL for the current file / line / SHA / GitHub repo
  Plug 'iautom8things/gitlink-vim'
    function! CopyGitLink(...) range
      redir @+
      silent echo gitlink#GitLink(get(a:, 1, 0))
      redir END
    endfunction
    " Leader gl : GitLink
    nmap <leader>gl :call CopyGitLink()<CR>
    vmap <leader>gl :call CopyGitLink(1)<CR>

  " Lexima: auto-close parentheses/brackets/quotes/oh my
  Plug 'cohama/lexima.vim'

  " Lightbulb: add icon to gutter when LSP actions are available (?)
  " TODO only install this if has(lua) ?
  Plug 'kosayoda/nvim-lightbulb'
    autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
    " vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

  " LF: file browser UI
  Plug 'ptzz/lf.vim'
  Plug 'rbgrouleff/bclose.vim' " dependency of lf.vim
    let g:lf_replace_netrw = 1 " use lf when opening a directory
    let g:lf_map_keys = 0 " turn off default lf mapping

  " Markdown: highlight & conceal Markdown syntax
  Plug 'plasticboy/vim-markdown'
    let g:vim_markdown_new_list_item_indent = 0

  " Markdown Preview: opens a browser tab with hot-preview of .md files
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
    let g:mkdp_page_title = '𝐌𝐃： ${name}'

  " GitMessenger: git commit browser
  Plug 'rhysd/git-messenger.vim'
    let g:git_messenger_no_default_mappings=v:true " need this to create our own mapping

  " NeoFormat: code formatting
  Plug 'sbdchd/neoformat'

  " NeoTerm: terminal buffer manager
  Plug 'kassio/neoterm'
    let g:neoterm_default_mod = 1
    " nnoremap <Leader>t :Tnew<CR>

  " OneDark: colorscheme
  Plug 'joshdick/onedark.vim'

  " Polyglot: syntax highlighting for a bunch of languages
  Plug 'sheerun/vim-polyglot'

  " QuickScope: navigation helpers
  Plug 'unblevable/quick-scope'
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

  " RainbowParentheses: just like it sounds
  Plug 'junegunn/rainbow_parentheses.vim'

  " Recover: add Compare to Swapfile actions
  Plug 'chrisbra/Recover.vim'

  " Rooter: change vim working dir
  Plug 'airblade/vim-rooter'
    let g:rooter_patterns = ['.git', '.git/']

  " Startify: show recent files on start
  Plug 'mhinz/vim-startify'
    let g:startify_custom_header = ''
    function! s:gitModified()
      let files = systemlist('git ls-files -m 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
    endfunction
    function! s:gitUntracked()
      let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
    endfunction
    " h/t https://github.com/mhinz/vim-startify/wiki/Example-configurations#show-modified-and-untracked-git-files
    let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
      \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]

  " Surround: modify enclosing matched pairs
  Plug 'tpope/vim-surround'

  " TextObjUser: custom text objs
  Plug 'kana/vim-textobj-user'

  " TextObjQuote: text objs for quotation marks, plus transformations
  Plug 'reedes/vim-textobj-quote'

  " TextObjXMLAttr: text objs for xml element attrs
  Plug 'whatyouhide/vim-textobj-xmlattr'

  " ToggleCursor: change cursor in insert mode
  Plug 'jszakmeister/vim-togglecursor'

  " yaml-folds: better-looking folding format for .yml files
  Plug 'pedrohdz/vim-yaml-folds'

call plug#end()


"""
" post-Plug configuration
"""

colorscheme onedark

" if has('termguicolors') " This messes up colors for OS X's Terminal.app...
"   set termguicolors
" endif

highlight Folded cterm=NONE

highlight clear SignColumn " make gutter background transparent
autocmd ColorScheme * highlight clear SignColumn

call lexima#add_rule({
\ 'char': '=',
\ 'at': ')\%#',
\ 'input': ' => ',
\ 'filetype': ['javascript', 'jasmine.javascript']
\})
call lexima#add_rule({
\ 'char': '{',
\ 'at': ')\%#',
\ 'input': ' => {',
\ 'input_after': '}',
\ 'filetype': ['javascript', 'jasmine.javascript']
\})

" fix saving crontab on OS X
" h/t https://superuser.com/a/907889/112856
autocmd filetype crontab setlocal nobackup nowritebackup

" h/t https://ornithocoder.github.io/programming/commit-msg-with-vim/
augroup gitcommit
  set complete+=kspell
  au FileType gitcommit setlocal spell
  au FileType gitcommit setlocal textwidth=72
  au FileType gitcommit setlocal colorcolumn=+1
augroup END

" line numbers: relative & absolute; hidden in terminals ...h/t https://jeffkreeftmeijer.com/vim-number/
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  " autocmd TermOpen * setlocal norelativenumber
  " autocmd TermOpen * setlocal nonumber
augroup END
augroup TerminalStuff " https://github.com/onivim/oni/issues/962
  " autocmd! " Clear old autocommands
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

highlight EyeGrabbers gui=bold guifg=magenta guibg=black
syntax match EyeGrabbers /TBD|TODOs/

highlight MatchParen guifg=magenta guibg=NONE

" highlight git merge conflict markers as TODOs ...h/t https://vimrcfu.com/snippet/177
match Todo '\v^(\<|\||\=|\>){7}([^=].+)?$'

augroup MarkdownStuff
  autocmd!
  autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown,*.mdwn set concealcursor-=n conceallevel=3
  autocmd FileType markdown highlight htmlBold ctermbg=60
  autocmd FileType markdown highlight EyeGrabbers ctermbg=60
augroup END

augroup ParensStuff
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
  autocmd BufNewFile,BufRead *.scm set foldmethod=indent
augroup END


""""""""""""
" Mappings "
"„„„„„„„„„„"

" jk / kj : Escape
inoremap kj <Esc>
inoremap jk <Esc>

" gk / gj : vertical movement through whitespace
nnoremap gk :call VerticalSpaceJumpUp()<CR>
nnoremap gj :call VerticalSpaceJumpDown()<CR>

" gn : Go to next File in quickfix
nnoremap gn :cnf<CR>

" j / k: respect wrapped lines when unprefixed by a count
" ...h/t https://www.hillelwayne.com/post/intermediate-vim/
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')

" Tab : (normal) change splits
nnoremap <Tab> <C-w>w
" Tab : (visual) delete selection, paste into new vertical split buffer
vnoremap <Tab> d:vnew<CR>PGddgg

" Q : close buffer but preserve split, using vim-bbye
nnoremap Q :Bdelete<CR>

" make Y behave like C and D
nnoremap Y y$
" ...except in visual mode; then make it yank to the system clipboard
vnoremap Y "+y

" ,c : close fold
nnoremap ,c zc

" ,f : reformat with npm
nnoremap ,f :!npx prettier --write %<CR>

" ,m : jump to merge conflict
nnoremap ,m /\| merged common ancestors<CR>:noh<CR>zz

" ,md : preview markdown file in browser with MarkdownPreview
" nnoremap ,md :MarkdownPreview<CR>

" ,n : remove search highlight
nnoremap ,n :nohl<CR>

" ,r : jump to next ALE error
nnoremap ,r :ALENext<CR>
nnoremap ,R :ALEPrevious<CR>

" ,s : open cypress screenshots
nnoremap ,s :!open cypress/screenshots/<CR><CR>

" ,t : toggle fold
nnoremap ,t za

" ,w/,W : make horizontal/vertical splits bigger
nnoremap ,w <C-w>10>
nnoremap ,W <C-w>5+

" Tab : (normal) change splits
nnoremap <Tab> <C-w>w
" Tab : (visual) delete selection, paste into new vertical split buffer
vnoremap <Tab> d:vnew<CR>PGddgg

" +/- : increment/decrement numbers
" ...h/t myfreeweb https://lobste.rs/s/6qp0vo#c_0emhe5
nnoremap - <C-x>
nnoremap + <C-a>

" Enter : insert newline below current line
" buftype check h/t Rich https://vi.stackexchange.com/a/3129/67
" TODO extract to plugin??
nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : ":<C-U>call append('.', repeat([''],v:count1))<CR>"

" Space : enter command-line mode
nnoremap <Space> :
vnoremap <Space> :

" Shift-↑/↓ : move lines vertically
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>

" Ctrl-h/j/k/l : move focus to split
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Ctrl-p : fuzzy-find files (within the current Git repository; with FZF)
nnoremap <C-p> :GFiles<CR>

" Ctrl-w / : expand current split without closing others
" (combo of Ctrl-w | and Ctrl-w _)
nnoremap <C-w>/ <C-w><Bar><C-w>_

" Ctrl-s : search for word under cursor
" h/t https://robots.thoughtbot.com/faster-grepping-in-vim
nnoremap <C-s> :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" (terminal) Ctrl-Space : exit terminal mode
tnoremap <C-Space> <C-\><C-n>

" Leader Leader : list buffers (with FZF)
nnoremap <Leader><Leader> :Buffers<CR>

" Leader Tab : open lf file browser
nnoremap <Leader><Tab> :Lf<CR>

" Leader . : repeat last replacement, and allow further repetition with a bare .
" h/t edanm https://news.ycombinator.com/item?id=26291260
nnoremap <Leader>. :let @/=@"<CR>/<CR>cgn<C-R>.<Esc>

" Leader 2 : jump to next ToDo
nnoremap <leader>2 /TODO<CR>:nohl<CR>

" Leader e : convert colon-delimited emoji name to emoji character
nmap <Leader>e :s/:\([^: ]\+\):/\=emoji#for(submatch(1), submatch(0), 0)/g<CR>:nohl<CR>

nnoremap <Leader>g :GrepQF<Space>

" Leader j/k : jump to next/prev edited area
map <Leader>j :GitGutterNextHunk<CR>
map <Leader>k :GitGutterPrevHunk<CR>

" Leader m : view most recent git message for current line
nmap <Leader>m <Plug>(git-messenger)

" Leader o : shortcut for :only
nnoremap <Leader>o :only<CR>

" Leader qc : "quickfix conflicting", open quickfix listing files which have merge conflicts
" h/t Peter Rincker https://vi.stackexchange.com/questions/13433/how-to-load-list-of-files-in-commit-into-quickfix#comment23027_13435
nnoremap <Leader>qc :call setqflist(map(systemlist("git conflicting"), '{"filename": v:val}'))<CR>

" Leader t : toggle terminal
nnoremap <Leader>t :FloatermToggle<CR>
tnoremap <Leader>t <C-\><C-n>:FloatermToggle<CR>

" Leader u : revert current hunk to git HEAD
nnoremap <Leader>u :GitGutterUndoHunk<CR>

" Leader v : edit vimrc
" ...h/t roryokane https://lobste.rs/s/6qp0vo#c_fu9psh
nnoremap <Leader>v :edit $MYVIMRC<CR>

" Leader w : reveal/hide whitespace markers
nnoremap <Leader>w :set list!<CR>

" Leader x : trim trailing whitespace
nnoremap <Leader>x :s/\s\+$//<CR>:nohl<CR>

" Leader comma : append comma & move down
nnoremap <Leader>,      mzA,<Esc>`zj

" Leader semicolon : append semicolon & move down
nnoremap <Leader>;      mzA;<Esc>`zj

" double-semicolon : append semicolon from insert mode
inoremap ;;        <Esc>mzA;<Esc>`za

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" ...there's a bug in this somewhere?
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

