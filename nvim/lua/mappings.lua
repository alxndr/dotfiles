vim.g.mapleader = [[\]]

vim.api.nvim_set_keymap('n', '<C-d>', vim.api.nvim_replace_termcodes([[(winheight(0)/3).'<C-d>']], true, false, false), {noremap=true, expr=true, desc='jump-down a third of the window-height'})
vim.api.nvim_set_keymap('n', '<C-u>', vim.api.nvim_replace_termcodes([[(winheight(0)/3).'<C-u>']], true, false, false), {noremap=true, expr=true, desc='jump-up a third of the window-height'})
vim.api.nvim_set_keymap('v', '<LEADER>p', 'S]%a()<ESC>"+P', {desc='wrap selection in markdown link with Pasted url'})


local mappings = require'which-key'

----------------
-- normal mode
mappings.add({
  {' ', ':', desc='start a vim command', silent=false},
  {'<CR>', [[:put=nr2char(10)|'[-1<CR>]], desc='insert newline below current line' },
  {'<TAB>', '<C-w><C-w>', desc='move to next split window' },
  {'j', function() return vim.v.count > 0 and 'j' or 'gj' end, expr=true, desc='move down (respects soft-wrapped lines)'},
  {'k', function() return vim.v.count > 0 and 'k' or 'gk' end, expr=true, desc='move up (respects soft-wrapped lines)'},
  -- 'K' up for grabs...
  {'H', 'zh', desc='shift window to the left' },
  {'L', 'zl', desc='shift window to the right' },
  {'Q', '<CMD>Bdelete<CR>', desc='close buffer' },
  {'U', '<CMD>redo<CR>',    desc='Un-undo (i.e. redo, normally `<C-r>`)' },
  {'-', '<C-x>', desc='decrement numerical value under cursor' },
  {'+', '<C-a>', desc='increment numerical value under cursor' },
  {'!', '@@',    desc='repeat last-executed macro' },
  {'|',          desc='toggle cursorline/cursorcolumn or jump to column', function()
    if vim.v.count > 0 then -- standard behavior: move to specified column
      vim.cmd('normal! ' .. vim.v.count .. '|')
    else -- custom behavior: toggle cursorline/column
      local new_val = not vim.wo.cursorline
      vim.g.cursorline_enabled = new_val
      vim.g.cursorcolumn_enabled = new_val
      vim.opt_local.cursorline = new_val
      vim.opt_local.cursorcolumn = new_val
    end
  end},
  -- {'<C-d>', function() vim.api.nvim_replace_termcodes([[(winheight(0)/3).'<C-d>']], true, false, false) end,  desc='jump-Down by 1/3 of window-height' }
  {'<C-h>', '<C-w>h', desc='move left to split window' },
  {'<C-f>', 'zaw/{$<CR>:noh<CR>', desc='Fold and jump to next open-brace'},
  {'<C-j>', '<C-w>j', desc='move down to split window' },
  {'<C-k>', '<C-w>k', desc='move up to split window' },
  {'<C-l>', '<C-w>l', desc='move right to split window' },
  {'<C-n>', '<CMD>write<CR><CMD>cn<CR>', desc='save current buffer and go to Next quickfix entry' },
  {'<C-r>', vim.diagnostic.goto_next, desc='move to next error / diagnostic issue (use `U` for redo)' },
  {'<C-m>', '<C-w>>', desc='widen split (More space)'},
  {'<C-S-M>', '<C-w>+', desc='tallify split (More space)'},
  {'<S-DOWN>', 'ddp', desc='shift current line down'},
  {'<S-UP>', 'ddkP',  desc='shift current line up' }, -- TODO bug: when on last line of file, will shift current line up by two lines
  {'<LEADER>,', 'mmA,<ESC>`mj', desc='append comma to line and move down'},
  {'<LEADER>;', 'mmA;<ESC>`mj', desc='append semicolon to line and move down'},
  {'<LEADER>2', '/TODO<CR><CMD>nohl<CR>', desc='jump to next TODO' },
  {'<LEADER>m', 'g<', desc='show last page of vim Messages'},
  {'<LEADER>p', '<CMD>let @" = expand("%")<CR>', desc='copy filePath to unnamed register'},
  {'<LEADER>P', '<CMD>let @+ = expand("%:p")<CR>', desc='copy filePath to system clipboard'},
  {'<LEADER>u', '<CMD>UpdateAll<CR>', desc='Update all plugins and tools (Paq, Mason, Treesitter)' },
  {'<LEADER>v', group='vim'}, -- h/t roryokane for this idea https://lobste.rs/s/6qp0vo#c_fu9psh
  {'<LEADER>vf', '<CMD>edit ~/workspace/dotfiles/nvim/lua/functions.lua<CR>', desc='edit vim functions file' },
  {'<LEADER>vm', '<CMD>edit ~/workspace/dotfiles/nvim/lua/mappings.lua<CR>',  desc='edit vim mappings file' },
  {'<LEADER>vo', '<CMD>edit ~/workspace/dotfiles/nvim/lua/options.lua<CR>',   desc='edit vim options file' },
  {'<LEADER>vp', '<CMD>edit ~/workspace/dotfiles/nvim/lua/plugins.lua<CR>',   desc='edit vim plugins file' },
  {'<LEADER>vv', '<CMD>edit $MYVIMRC<CR>', desc='edit vim config file' },
  {'<LEADER>w', '<CMD>set wrap!<CR>', desc='toggle Wrap setting' },
  {'<LEADER>y', '<CMD>only<CR>', desc='clear all other splits' },
  {'zZ', function() -- analogue of `zz`: center window horizontally around cursor column
    local view = vim.fn.winsaveview()
    view.leftcol = math.max(0, vim.fn.virtcol('.') - math.floor(vim.api.nvim_win_get_width(0) / 2))
    vim.fn.winrestview(view)
  end, desc='center window horiZontally on cursor column (perpendicular analogue of `zz`)'},
  {',,', 'zM', desc='collapse all folds'},
  {',c', '<CMD>%y+<CR><CR>', desc='copy entire file to system clipboard'},
  {',cn', '<CMD>cnext<CR>', desc='Next quiCkfix item'},
  {',cp', '<CMD>cprev<CR>', desc='Previous quiCkfix item'},
  {',d', vim.diagnostic.open_float, desc='open Diagnostics' },
  -- {',f', [[zcj0/{\n<CR><CMD>nohl<CR>zz]], desc='fold braces and jump to next' },
  {',l', '<CMD>set list!<CR>', desc='toggle non-printing characters (show only Letters)' },
  {',L', '<CMD>w|luafile %<CR>', desc='save and load with Luafile' },
  {',m', [[/\v^(\<|\||\=|\>){7}(.+)?$<CR><CMD>nohl<CR>zz]], desc='jump to next git merge conflict marker' },
  {',n', '<CMD>nohl<CR>', desc='do Not highlight search text' },
  {',s', '<CMD>write<CR><CR>', desc='Save current buffer' },
  {',S', '<CMD>wall<CR><CR>', desc='Save all open buffers/files' },
  {',t', 'za', desc='toggle fold'},
  {',w', '10<C-w>>', desc='expand Window Wider'},
  {',W',  '5<C-w>+', desc='expand Window upWards'},
})


----------------
-- insert mode
mappings.add({
  { mode='i',
    {'qq', function() print('use <C-r> now...') end, desc='reminder to use `<C-r>` now'},
    {'<LEADER>,', '<ESC>mmA,<ESC>`ma', desc='append COMMA to line'},
    {'<LEADER>;', '<ESC>mmA;<ESC>`ma', desc='append SEMICOLON to line'},
    {'<C-a>', '<ESC>A', desc='move cursor to end of line (i.e. Append)'},
    {'<C-g>', 'g', desc='count characters/words/lines'},
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
    {'!', '@@', desc='repeat last-executed macro' },
    {'Y', '"+y', desc='copy selection to system clipboard'},
    {'<C-c>', group='Chinese character conversion (via plugin: jianfan)'},
    {'<C-c>s', ':Scn<CR>', desc='convert Chinese characters to simplified version'},
    {'<C-c>t', ':Tcn<CR>', desc='convert Chinese characters to traditional version'},
  },
})
