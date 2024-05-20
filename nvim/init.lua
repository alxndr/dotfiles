require 'options'
require 'plugins'
require 'functions'
require 'mappings'

local mappings = require'which-key'

mappings.register({
  [' '] = { ':', 'start a vim command' },
}, {silent=false})
mappings.register{
  ['<CR>'] = { [[:put=nr2char(10)|'[-1<CR>]], 'insert newline below current line' },
  ['<TAB>'] = { '<C-w><C-w>', 'move to next split window' },
  H = { 'zh', 'shift window to the left' },
  L = { 'zl', 'shift window to the right' },
  r = { function() vim.diagnostic.goto_next() end, 'move to next error / diagnostic issue' },
  Q = { '<CMD>Bdelete<CR>', 'close buffer' },
  ['-'] = { '<C-x>', 'decrement numerical value under cursor' },
  ['+'] = { '<C-a>', 'increment numerical value under cursor' },
  ['!'] = { '@@', 'repeat last-executed macro' },
}

mappings.register({
  [','] = { 'mmA,<Esc>`mj', 'append comma to line and move down'},
  [';'] = { 'mmA;<Esc>`mj', 'append semicolon to line and move down'},
  v = { -- h/t roryokane for this idea https://lobste.rs/s/6qp0vo#c_fu9psh
    name = 'vim',
    f = { '<CMD>edit ~/workspace/dotfiles/nvim/lua/functions.lua<CR>', 'edit vim functions file' },
    m = { '<CMD>edit ~/workspace/dotfiles/nvim/lua/mappings.lua<CR>', 'edit vim mappings file' },
    o = { '<CMD>edit ~/workspace/dotfiles/nvim/lua/options.lua<CR>', 'edit vim options file' },
    p = { '<CMD>edit ~/workspace/dotfiles/nvim/lua/plugins.lua<CR>', 'edit vim plugins file' },
    v = { '<CMD>edit $MYVIMRC<CR>', 'edit vim config file' },
  },
  w = { '<CMD>set list!<CR>', 'toggle non-printing chars' },
  y = { '<CMD>only<CR>', 'clear all other splits' },
  ['2'] = { '/TODO<CR><CMD>nohl<CR>', 'jump to next TODO' },
}, {prefix = '<Leader>'})

mappings.register({
  d = { function() vim.diagnostic.open_float() end, 'open diagnostics' },
  f = { [[zcj0/{\n<CR><CMD>nohl<CR>zz]], 'fold braces and jump to next' },
  m = { [[/\v^(\<|\||\=|\>){7}(.+)?$<CR><CMD>nohl<CR>zz]], 'jump to next git merge conflict marker' },
  n = { '<CMD>nohl<CR>', 'no highlight search text' },
  s = { '<CMD>w<CR>', 'save current file' },
  t = { 'za', 'toggle fold' },
  w = { '10<C-w>>', 'widen split' },
  W = {  '5<C-w>+', 'tallify split' },
}, {prefix=','})
