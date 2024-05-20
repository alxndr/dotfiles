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
local function mapVisual (sequence, mapping, opts)
  if opts == nil then opts = {} end
  vim.api.nvim_set_keymap('v', sequence, mapping, opts)
end


-- custom order: Leader, nonprinting chars, punctuation, alnum, modifiers (alphabetic where possible)

-- normal mode
mapNormal('<Space>', ':') -- note that this means using <CMD> over : in other mappings, or using noremap
mapNormal('<CR>', [[:put=nr2char(10)|'[-1<CR>]])
mapNormal('<Tab>', '<C-w><C-w>')
mapNormal('!', '@@')
--[[      '|' uses expr ==>]] vim.cmd [[noremap <expr> \| v:count ? '\|' : '<CMD>lua vim.wo.cursorline, vim.wo.cursorcolumn = not vim.wo.cursorline, not vim.wo.cursorline<CR>']]
mapNormal('-', '<C-x>')
mapNormal('+', '<C-a>')
--         gb   = numToStr/Comment.nvim blockwise comment action/toggle
--         gc   = numToStr/Comment.nvim linewise comment action/toggle
      --[[ j ]] vim.cmd [[noremap <expr> j v:count ? 'j' : 'g<Down>']] -- using `g<Down>` so as to not conflict with mapping `gj`
      --[[ k ]] vim.cmd [[noremap <expr> k v:count ? 'k' : 'g<Up>']]   -- using `g<Up>` so as to not conflict with mapping `gk`
mapNormal('r', '<CMD>lua vim.diagnostic.goto_next()<CR>')
mapNormal('H', 'zh')
mapNormal('L', 'zl')
mapNormal('Q', '<CMD>Bdelete<CR>')
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

-- visual mode
mapVisual('<Leader>a', ':Tab /', {desc = '_a_lign'})
mapVisual('<Space>', ':')
mapVisual('<Tab>', 'd<CMD>vnew<CR>PGddgg', {desc = 'extract selection from current file & paste into new buffer'})
--         gb  = numToStr/Comment blockwise comment toggle
--         gc  = numToStr/Comment linewise comment toggle
mapVisual('L', '<CMD>lua require("syntax-tree-surfer").surf("next", "visual", true)<CR>')
mapVisual('H', '<CMD>lua require("syntax-tree-surfer").surf("prev", "visual", true)<CR>')
mapVisual('Y', '"+y', {desc = 'copy selection to system clipboard'})
mapVisual('<C-c>s', ':Scn<CR>', {desc = 'convert Chinese characters to simplified version'})
mapVisual('<C-c>t', ':Tcn<CR>', {desc = 'convert Chinese characters to traditional version'})
mapVisual('<S-Up>', [[<CMD>move '<-2<CR>]], {desc = 'shift current line up'})
mapVisual('<S-Down>', [[<CMD>move '>+1<CR>]], {desc = 'shift current line down'})
