vim.g.mapleader = [[\]]

-- opts: nowait=false, silent=false, script=false, expr=false, unique=false, noremap, desc, callback, replace_keycodes
local function mapInsert (sequence, mapping, opts)
  if opts == nil then opts = {} end
  vim.api.nvim_set_keymap('i', sequence, mapping, opts)
end
local function mapNormal (sequence, mapping, opts)
  if opts == nil then opts = {} end
  vim.api.nvim_set_keymap('n', sequence, mapping, opts)
end
local function mapTerminal (sequence, mapping, opts)
  if opts == nil then opts = {} end
  vim.api.nvim_set_keymap('t', sequence, mapping, opts)
end

--[[       | ]] vim.cmd [[noremap <expr> \| v:count ? '\|' : '<CMD>lua vim.wo.cursorline, vim.wo.cursorcolumn = not vim.wo.cursorline, not vim.wo.cursorline<CR>']]
      --[[ j ]] vim.cmd [[noremap <expr> j v:count ? 'j' : 'g<Down>']] -- using `g<Down>` so as to not conflict with mapping `gj`
      --[[ k ]] vim.cmd [[noremap <expr> k v:count ? 'k' : 'g<Up>']]   -- using `g<Up>` so as to not conflict with mapping `gk`
mapNormal('<C-d>', vim.api.nvim_replace_termcodes([[(winheight(0)/3).'<C-d>']], true, false, false), {noremap = true, expr = true, desc = 'jump-down a third of the window-height'})
mapNormal('<C-h>', '<C-w>h')
mapNormal('<C-j>', '<C-w>j')
mapNormal('<C-k>', '<C-w>k')
mapNormal('<C-l>', '<C-w>l')
mapNormal('<C-n>', '<CMD>cn<CR>', {desc = 'next quickfix entry'})
mapNormal('<C-u>',  vim.api.nvim_replace_termcodes([[(winheight(0)/3).'<C-u>']], true, false, false), {noremap = true, expr = true, desc = 'jump-up a third of the window-height'} )
mapNormal('<C-w>/', '<C-w>|<C-w>_')
mapNormal('<S-Down>', 'ddp', {desc = 'shift current line down'})
mapNormal('<S-Up>', 'ddkP', {desc = 'shift current line up'})

-- insert mode
mapInsert('<Leader>e', '<CMD>EmojiPicker<CR>', {silent=true})
mapInsert('<Leader>,', '<Esc>mmA,<Esc>`ma', {desc = 'append comma to line and return to position'})
mapInsert('<Leader>;', '<Esc>mmA;<Esc>`ma', {desc = 'append semicolon to line and return to position'})
mapInsert('qq', '<Esc>mmgqq`ma', {desc = 'wrap current line and return to position'})
mapInsert('<C-a>', [[<Esc>A]], {desc = 'append (e.g. to hop over autocompleted characters)'})
mapInsert('<C-e>', '<Esc><C-e>a', {desc = 'preserve `<C-e>` scroll behavior in insert mode'})
mapInsert('<C-l>', 'λ', {desc = 'shorthand to insert a lambda [^k:l*]'})
mapInsert('<C-y>', '<Esc><C-y>a', {desc = 'preserve `<C-y>` scroll behavior in insert mode'})
mapInsert('<S-Down>', '<Esc>mmddp`ma', {desc = 'shift current line down and return to position'})
mapInsert('<S-Up>', '<Esc>mmddkP`ma', {desc = 'shift current line up and return to position'})

-- term mode
mapTerminal('<Leader>[', [[<C-\><C-n><CMD>FloatermPrev<CR>]])
mapTerminal('<Leader>)', [[<C-\><C-n><CMD>FloatermNext<CR>]])
mapTerminal('<Leader>n', [[<C-\><C-n><CMD>FloatermNew<CR>]])
mapTerminal('<Leader>t', [[<C-\><C-n><CMD>FloatermToggle<CR>]])
mapTerminal('<C-Space>', [[<C-\><C-n>]])
mapTerminal('<C-[>', [[<C-\><C-n><CMD>FloatermPrev<CR>]])
mapTerminal('<C-)>', [[<C-\><C-n><CMD>FloatermNext<CR>]])
mapTerminal('<C-t>', [[<C-\><C-n><CMD>FloatermToggle<CR>]])

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
  r = { vim.diagnostic.goto_next, 'move to next error / diagnostic issue' },
  Q = { '<CMD>Bdelete<CR>', 'close buffer' },
  ['-'] = { '<C-x>', 'decrement numerical value under cursor' },
  ['+'] = { '<C-a>', 'increment numerical value under cursor' },
  ['!'] = { '@@', 'repeat last-executed macro' },
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
