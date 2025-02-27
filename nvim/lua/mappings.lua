vim.g.mapleader = [[\]]

vim.cmd [[
  noremap <expr> \| v:count ? '\|' : '<CMD>lua vim.wo.cursorline, vim.wo.cursorcolumn = not vim.wo.cursorline, not vim.wo.cursorline<CR>'
  noremap <expr>  j v:count ?  'j' : 'g<DOWN>'
  noremap <expr>  k v:count ?  'k' : 'g<UP>'
]]
vim.api.nvim_set_keymap('n', '<C-d>', vim.api.nvim_replace_termcodes([[(winheight(0)/3).'<C-d>']], true, false, false), {noremap=true, expr=true, desc='jump-down a third of the window-height'})
vim.api.nvim_set_keymap('n', '<C-u>', vim.api.nvim_replace_termcodes([[(winheight(0)/3).'<C-u>']], true, false, false), {noremap=true, expr=true, desc='jump-up a third of the window-height'})
vim.api.nvim_set_keymap('v', '<LEADER>p', 'S]%a()<ESC>"+P', {}) -- TODO sort out why using `S` here (from vim-surround) doesn't work via which-key


local mappings = require'which-key'

----------------
-- normal mode
mappings.add({
  {' ', ':', desc='start a vim command', silent=false},
  {'<CR>', [[:put=nr2char(10)|'[-1<CR>]], desc='insert newline below current line' },
  {'<TAB>', '<C-w><C-w>', desc='move to next split window' },
  {'H', 'zh', desc='shift window to the left' },
  {'L', 'zl', desc='shift window to the right' },
  {'Q', '<CMD>Bdelete<CR>', desc='close buffer' },
  {'U', '<CMD>redo<CR>',    desc='Un-undo (i.e. redo, normally `<C-r>`)' },
  {'-', '<C-x>', desc='decrement numerical value under cursor' },
  {'+', '<C-a>', desc='increment numerical value under cursor' },
  {'!', '@@',    desc='repeat last-executed macro' },
  {'<C-h>', '<C-w>h', desc='move left to split window' },
  {'<C-f>', 'zaw/{$<CR>:noh<CR>', desc='Fold and jump to next open-brace'},
  {'<C-j>', '<C-w>j', desc='move down to split window' },
  {'<C-k>', '<C-w>k', desc='move up to split window' },
  {'<C-l>', '<C-w>l', desc='move right to split window' },
  {'<C-n>', '<CMD>cn<CR>', desc='next quickfix entry' },
  {'<C-r>', vim.diagnostic.goto_next, desc='move to next error / diagnostic issue (use `U` for redo)' },
  {'<C-w>/', '<C-w>|<C-w>_', desc='maximize current split window' },
  {'<S-DOWN>', 'ddp', desc='shift current line down'},
  {'<S-UP>', 'ddkP',  desc='shift current line up' }, -- TODO bug: when on last line of file, will shift current line up by two lines
  -- {'|', function() vim.wo.cursorline, vim.wo.cursorcolumn = not vim.wo.cursorline, not vim.wo.cursorline end, desc='toggle cursorline/cursorcolumn visibility' },
  -- {'<C-d>', function() vim.api.nvim_replace_termcodes([[(winheight(0)/3).'<C-d>']], true, false, false) end,  desc='jump-Down by 1/3 of window-height' }
  {'<LEADER>,', 'mmA,<ESC>`mj', desc='append comma to line and move down'},
  {'<LEADER>;', 'mmA;<ESC>`mj', desc='append semicolon to line and move down'},
  {'<LEADER>2', '/TODO<CR><CMD>nohl<CR>', desc='jump to next TODO' },
  {'<LEADER>p', '<CMD>let @+ = expand("%")<CR>', desc='copy filePath to system clipboard'},
  {'<LEADER>v', group='vim'}, -- h/t roryokane for this idea https://lobste.rs/s/6qp0vo#c_fu9psh
  {'<LEADER>vf', '<CMD>edit ~/workspace/dotfiles/nvim/lua/functions.lua<CR>', desc='edit vim functions file' },
  {'<LEADER>vm', '<CMD>edit ~/workspace/dotfiles/nvim/lua/mappings.lua<CR>',  desc='edit vim mappings file' },
  {'<LEADER>vo', '<CMD>edit ~/workspace/dotfiles/nvim/lua/options.lua<CR>',   desc='edit vim options file' },
  {'<LEADER>vp', '<CMD>edit ~/workspace/dotfiles/nvim/lua/plugins.lua<CR>',   desc='edit vim plugins file' },
  {'<LEADER>vv', '<CMD>edit $MYVIMRC<CR>', desc='edit vim config file' },
  {'<LEADER>w', '<CMD>set list!<CR>', desc='toggle non-printing chars' },
  {'<LEADER>y', '<CMD>only<CR>', desc='clear all other splits' },
  {',d', vim.diagnostic.open_float, desc='open diagnostics' },
  -- {',f', [[zcj0/{\n<CR><CMD>nohl<CR>zz]], desc='fold braces and jump to next' },
  {',m', [[/\v^(\<|\||\=|\>){7}(.+)?$<CR><CMD>nohl<CR>zz]], desc='jump to next git merge conflict marker' },
  {',n', '<CMD>nohl<CR>', desc='no highlight search text' },
  {',s', '<CMD>w<CR><CR>', desc='save current buffer' },
  {',S', '<CMD>wa<CR><CR>', desc='save all open buffers' },
  {',t', 'za', desc='toggle fold'},
  {',w', '10<C-w>>', desc='widen split'},
  {',W',  '5<C-w>+', desc='tallify split'},
})


----------------
-- insert mode
mappings.add({
  { mode='i',
    {'qq', function() print('use <C-r> now...') end, desc='reminder to use `<C-r>` now'},
    {'<LEADER>,', '<ESC>mmA,<ESC>`ma', desc='append COMMA to line'},
    {'<LEADER>;', '<ESC>mmA;<ESC>`ma', desc='append SEMICOLON to line'},
    {'<C-a>', '<ESC>A', desc='move cursor to end of line (i.e. Append)'},
    {'<C-e>', '<ESC><C-e>a', desc='shift window up (i.e. normal mode `<C-e>`)'},
    {'<C-l>', 'λ', desc='shorthand to insert a Lambda [^k:l*]'},
    {'<C-r>', '<ESC>gqqa', desc='Reformat current line'},
    {'<C-y>', '<ESC><C-y>a', desc='shift window up (i.e. normal mode `<C-y>`)'},
    {'<S-Down>', '<ESC>mmddp`ma', desc='shift current line down'},
    {'<S-Up>', '<ESC>mmddkP`ma', desc='shift current line up'},
  },
})


----------------
-- visual mode
mappings.add({
  { mode='v',
    {' ', ':', desc='start command for selected range', silent=false},
    {'<TAB>', 'd<CMD>vnew<CR>PGddgg', desc='extract selection from current file & paste into new buffer'},
    {'Y', '"+y', desc='copy selection to system clipboard'},
    {'<C-c>', group='Chinese character conversion (via plugin: jianfan)'},
    {'<C-c>s', ':Scn<CR>', desc='convert Chinese characters to simplified version'},
    {'<C-c>t', ':Tcn<CR>', desc='convert Chinese characters to traditional version'},
  },
})
