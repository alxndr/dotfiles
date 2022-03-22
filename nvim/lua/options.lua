vim.opt.expandtab = true
vim.opt.fileformat = 'unix'
vim.opt.fillchars = 'fold: '
vim.opt.foldlevelstart = 99
vim.opt.ignorecase = true
vim.opt.joinspaces = false
vim.opt.list = true
vim.opt.listchars = "tab:␉\\ ,trail:␠,nbsp:⎵,extends:⋯"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.updatetime = 333
vim.opt.wrap = false

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- line number tweaks
--  * "hybrid" style: normal mode shows absolute & insert mode shows absolute
--    for current line, relative for others
--    h/t https://jeffkreeftmeijer.com/vim-number/
vim.cmd [[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]]

-- colorscheme tweaks
vim.cmd [[
  au VimEnter * highlight Whitespace guifg=red
  au BufEnter * highlight Folded guibg=NONE
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Underlined", timeout=500})
]]

-- markdown tweaks
vim.cmd [[
  autocmd filetype markdown setlocal wrap spell nonumber
]]

-- gitcommit tweaks
vim.cmd [[
  autocmd filetype gitcommit setlocal spell
]]

-- disable syntax highlighting in large files
-- h/t `/u/Narizocracia` https://www.reddit.com/r/neovim/comments/pz3wyc/comment/heyy4qf
-- function definition in `functions.lua`
vim.cmd [[
  augroup BigFileDisable
    autocmd!
    autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 512 * 1024 | exec DisableSyntaxTreesitter() | endif
  augroup END
]]
