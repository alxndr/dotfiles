vim.g.mapleader = [[\]]

-- opts: nowait=false, silent=false, script=false, expr=false, unique=false, noremap, desc, callback, replace_keycodes
local function mapNormal (sequence, mapping, opts)
  if opts == nil then opts = {} end
  vim.api.nvim_set_keymap('n', sequence, mapping, opts)
end

--[[       | ]] vim.cmd [[noremap <expr> \| v:count ? '\|' : '<CMD>lua vim.wo.cursorline, vim.wo.cursorcolumn = not vim.wo.cursorline, not vim.wo.cursorline<CR>']]
      --[[ j ]] vim.cmd [[noremap <expr> j v:count ? 'j' : 'g<Down>']] -- using `g<Down>` so as to not conflict with mapping `gj`
      --[[ k ]] vim.cmd [[noremap <expr> k v:count ? 'k' : 'g<Up>']]   -- using `g<Up>` so as to not conflict with mapping `gk`
mapNormal('<C-d>', vim.api.nvim_replace_termcodes([[(winheight(0)/3).'<C-d>']], true, false, false), {noremap = true, expr = true, desc = 'jump-down a third of the window-height'})
mapNormal('<C-u>',  vim.api.nvim_replace_termcodes([[(winheight(0)/3).'<C-u>']], true, false, false), {noremap = true, expr = true, desc = 'jump-up a third of the window-height'} )


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
  ['<S-Down>'] = { 'ddp', 'shift current line down'},
  ['<S-Up>'] = { 'ddkP', 'shift current line up' }, -- TODO bug: when on last line of file, will shift current line up by two lines
}

-- Leader prefix...
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
-- insert mode

mappings.register({
  ['qq']        = { function() print('use <C-r> now...') end, 'reminder to use `<C-r>` now' },
  ['<LEADER>,'] = { '<Esc>mmA,<Esc>`ma', 'append COMMA to line' },
  ['<LEADER>;'] = { '<Esc>mmA;<Esc>`ma', 'append SEMICOLON to line' },
  ['<C-a>']     = { '<Esc>A', 'move cursor to end of line (i.e. Append)' },
  ['<C-e>']     = { '<Esc><C-e>a', 'shift window up (i.e. normal mode `<C-e>`)' },
  ['<C-l>']     = { 'λ', 'shorthand to insert a Lambda [^k:l*]' },
  ['<C-r>']     = { '<Esc>gqqa', 'Reformat current line' },
  ['<C-y>']     = { '<Esc><C-y>a', 'shift window up (i.e. normal mode `<C-y>`)' },
  ['<S-Down>']  = { '<Esc>mmddp`ma', 'shift current line down' },
  ['<S-Up>']    = { '<Esc>mmddkP`ma', 'shift current line up' },
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
