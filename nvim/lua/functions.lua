vim.cmd [[

function DOSNewlinesToUnix()
  set fileformat=unix
endfunction

" disable syntax highlighting in big files
" h/t `/u/Narizocracia` https://www.reddit.com/r/neovim/comments/pz3wyc/comment/heyy4qf
function DisableSyntaxTreesitter()
  if exists(':TSBufDisable')
    exec 'TSBufDisable autotag'
    exec 'TSBufDisable highlight'
  endif
  syntax off
  filetype off
  set   foldmethod=manual
  set noloadplugins
  set noswapfile
  set noundofile
endfunction


]]
