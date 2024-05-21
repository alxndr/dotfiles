vim.g.mapleader = [[\]]

vim.cmd [[
  noremap <expr> \| v:count ? '\|' : '<CMD>lua vim.wo.cursorline, vim.wo.cursorcolumn = not vim.wo.cursorline, not vim.wo.cursorline<CR>'
  noremap <expr>  j v:count ?  'j' : 'g<DOWN>'
  noremap <expr>  k v:count ?  'k' : 'g<UP>'
]]
vim.api.nvim_set_keymap('n', '<C-d>', vim.api.nvim_replace_termcodes([[(winheight(0)/3).'<C-d>']], true, false, false), {noremap=true, expr=true, desc='jump-down a third of the window-height'})
vim.api.nvim_set_keymap('n', '<C-u>', vim.api.nvim_replace_termcodes([[(winheight(0)/3).'<C-u>']], true, false, false), {noremap=true, expr=true, desc='jump-up a third of the window-height'})


local mappings = require'which-key'

----------------
-- normal mode

-- unprefixed...
mappings.register({
  [' '] = { ':', 'start a vim command' },
}, {silent=false})
mappings.register{
  ['<CR>'] = { [[:put=nr2char(10)|'[-1<CR>]], 'insert newline below current line' },
  ['<TAB>'] = { '<C-w><C-w>', 'move to next split window' },
  H = { 'zh', 'shift window to the left' },
  L = { 'zl', 'shift window to the right' },
  Q = { '<CMD>Bdelete<CR>', 'close buffer' },
  U = { '<CMD>redo<CR>', 'Un-undo (i.e. redo, normally `<C-r>`)' },
  ['-'] = { '<C-x>', 'decrement numerical value under cursor' },
  ['+'] = { '<C-a>', 'increment numerical value under cursor' },
  ['!'] = { '@@', 'repeat last-executed macro' },
  ['<C-h>'] = { '<C-w>h', 'move left to split window' },
  ['<C-j>'] = { '<C-w>j', 'move down to split window' },
  ['<C-k>'] = { '<C-w>k', 'move up to split window' },
  ['<C-l>'] = { '<C-w>l', 'move right to split window' },
  ['<C-n>'] = { '<CMD>cn<CR>', 'next quickfix entry' },
  ['<C-r>'] = { vim.diagnostic.goto_next, 'move to next error / diagnostic issue (use `U` for redo)' },
  ['<C-w>/'] = { '<C-w>|<C-w>_', 'maximize current split window' },
  ['<S-DOWN>'] = { 'ddp', 'shift current line down'},
  ['<S-UP>'] = { 'ddkP', 'shift current line up' }, -- TODO bug: when on last line of file, will shift current line up by two lines
}
-- mappings.register({
--   -- ['|'] = { function() vim.wo.cursorline, vim.wo.cursorcolumn = not vim.wo.cursorline, not vim.wo.cursorline end, 'toggle cursorline/cursorcolumn visibility' },
--   -- ['<C-d>'] = { function() vim.api.nvim_replace_termcodes([[(winheight(0)/3).'<C-d>']], true, false, false) end, 'jump-Down by 1/3 of window-height' }
-- }, {})

-- Leader prefix...
mappings.register({
  [','] = { 'mmA,<ESC>`mj', 'append comma to line and move down'},
  [';'] = { 'mmA;<ESC>`mj', 'append semicolon to line and move down'},
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
}, {prefix = '<LEADER>'})

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
-- insert mode

mappings.register({
  ['qq']        = { function() print('use <C-r> now...') end, 'reminder to use `<C-r>` now' },
  ['<LEADER>,'] = { '<ESC>mmA,<ESC>`ma', 'append COMMA to line' },
  ['<LEADER>;'] = { '<ESC>mmA;<ESC>`ma', 'append SEMICOLON to line' },
  ['<C-a>']     = { '<ESC>A', 'move cursor to end of line (i.e. Append)' },
  ['<C-e>']     = { '<ESC><C-e>a', 'shift window up (i.e. normal mode `<C-e>`)' },
  ['<C-l>']     = { 'λ', 'shorthand to insert a Lambda [^k:l*]' },
  ['<C-r>']     = { '<ESC>gqqa', 'Reformat current line' },
  ['<C-y>']     = { '<ESC><C-y>a', 'shift window up (i.e. normal mode `<C-y>`)' },
  ['<S-Down>']  = { '<ESC>mmddp`ma', 'shift current line down' },
  ['<S-Up>']    = { '<ESC>mmddkP`ma', 'shift current line up' },
}, {mode='i'})


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
