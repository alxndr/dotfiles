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
  r = { vim.diagnostic.goto_next, 'move to next error / diagnostic issue' },
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

-- Comma prefix...
mappings.register({
  d = { vim.diagnostic.open_float, 'open diagnostics' },
  f = { [[zcj0/{\n<CR><CMD>nohl<CR>zz]], 'fold braces and jump to next' },
  m = { [[/\v^(\<|\||\=|\>){7}(.+)?$<CR><CMD>nohl<CR>zz]], 'jump to next git merge conflict marker' },
  n = { '<CMD>nohl<CR>', 'no highlight search text' },
  s = { '<CMD>w<CR><CR>', 'save current file' },
  t = { 'za', 'toggle fold' },
  w = { '10<C-w>>', 'widen split' },
  W = {  '5<C-w>+', 'tallify split' },
}, {prefix=','})


----------------
-- visual mode

mappings.register({
  [' '] = { ':', 'start command for selected range' },
}, {mode='v', silent=false})
mappings.register({
  ['<TAB>'] = { 'd<CMD>vnew<CR>PGddgg', 'extract selection from current file & paste into new buffer' },
  Y = { '"+y', 'copy selection to system clipboard' },
}, {mode='v'})
mappings.register({
  name = 'Chinese character conversion (via plugin: jianfan)',
  s = { ':Scn<CR>', 'convert Chinese characters to simplified version' },
  t = { ':Tcn<CR>', 'convert Chinese characters to traditional version' },
}, {mode='v', prefix='<C-c>'})
