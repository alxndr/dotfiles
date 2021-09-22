vim.g.mapleader = '\\'

local map = require 'cartographer'
local snap = require 'snap'

-- normal mode
snap.register.map({'n'}, {'<Leader><Leader>'}, snapFindBuffer)
snap.register.map({'n'}, {'<Leader>g'}, snapSearchWithGrep)
map.n.nore['<Leader>j'] = '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'
map.n.nore['<Leader>k'] = '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'
map.n.nore[',m'] = '/\\v^(\\<|\\||\\=|\\>){7}(.+)?$<CR>:nohl<CR>'
map.n.nore['<Leader>t'] = ':FloatermToggle<CR>'
map.n.nore['<Leader>u'] = ':lua require"gitsigns".reset_hunk()<CR>'
map.n.nore['<Leader>v'] = ':edit $MYVIMRC<CR>' -- h/t roryokane https://lobste.rs/s/6qp0vo#c_fu9psh
map.n.nore['<Leader>vm'] = ':edit ~/workspace/dotfiles/nvim/lua/mappings.lua<CR>'
map.n.nore['<Leader>vo'] = ':edit ~/workspace/dotfiles/nvim/lua/options.lua<CR>'
map.n.nore['<Leader>vp'] = ':edit ~/workspace/dotfiles/nvim/lua/plugins.lua<CR>'
map.n.nore['<Leader>w'] = ':set list!<CR>'
map.n.nore['<Leader>y'] = ':only<CR>'
map.n.nore['<Leader><Tab>'] = ':NvimTreeToggle<CR>'
map.n.nore['<Space>'] = ':'
map.n.nore['<CR>'] = 'm`o<Esc>``'
map.n.nore['<Tab>'] = '<C-w><C-w>'
map.n.nore.expr['<C-d>'] = "(winheight(0)/3).'<C-d>'"
map.n.nore['<C-h>'] = '<C-w>h'
map.n.nore['<C-j>'] = '<C-w>j'
map.n.nore['<C-k>'] = '<C-w>k'
map.n.nore['<C-l>'] = '<C-w>l'
map.n.nore['<C-w>/'] = '<C-w>|<C-w>_'
snap.register.map({'n'}, {'<C-p>'}, snapFindFile)
map.n['<C-s>'] = 'viw<C-s>' -- grep for word under cursor; h/t https://robots.thoughtbot.com/faster-grepping-in-vim
map.n.nore.expr['<C-u>'] = "(winheight(0)/3).'<C-u>'"
map.n.nore['gj'] = ':call VerticalSpaceJumpDown()<CR>'
map.n.nore['gk'] = ':call VerticalSpaceJumpUp()<CR>'
map.n.nore[',gc'] = ':Git commit<CR>'
map.n.nore[',gl'] = ':Git pull<CR>'
map.n.nore[',go'] = ':Git checkout '
map.n.nore[',gp'] = ':Git push'
map.n.nore[',gP'] = ':Git push --force'
map.n.nore[',g'] = ':Git<CR>'
map.n.nore[',r'] = '<cmd>lua require\"jester\".run()<CR>'
map.n.nore[',n'] = ':nohl<CR>'
map.n.nore[',t'] = 'za'
map.n.nore['Q'] = ':BufDel<CR>'
map.n.nore[',w'] = '10<C-w>>'
map.n.nore[',W'] = '5<C-w>+'
map.n.nore[',,'] = 'm`A,<Esc>``j' -- append comma to line and move down
map.n.nore[';;'] = 'm`A;<Esc>``j' -- append semicolon to line and move down
map.n.nore['-'] = '<C-x>'
map.n.nore['+'] = '<C-a>'
map.n['#'] = '#zz' -- "find word under cursor" centers the next match
map.n['*'] = '*zz' -- "find word under cursor" centers the next match

-- insert mode
map.i.nore['jk'] = '<Esc>'
map.i.nore['kj'] = '<Esc>'
map.i.nore['qq'] = '<Esc>m`gqq``a' -- wrap current line and return to position
map.i.nore[',,'] = '<Esc>m`A,<Esc>``a' -- append comma to line and return to position
map.i.nore[';;'] = '<Esc>m`A;<Esc>``a' -- append semicolon to line and return to position

-- terminal mode
map.t.nore['<Leader>n'] = '<C-\\><C-n>:FloatermNew<CR>'
map.t.nore['<Leader>t'] = '<C-\\><C-n>:FloatermToggle<CR>'
map.t.nore['<Leader>['] = '<C-\\><C-n>:FloatermPrev<CR>'
map.t.nore['<Leader>]'] = '<C-\\><C-n>:FloatermNext<CR>'
map.t.nore['<C-Space>'] = '<C-\\><C-n>'
map.t.nore['<C-t>'] = '<C-\\><C-n>:FloatermToggle<CR>'
map.t.nore['<C-[>'] = '<C-\\><C-n>:FloatermPrev<CR>'
map.t.nore['<C-]>'] = '<C-\\><C-n>:FloatermNext<CR>'

-- visual mode
map.v.nore['<Space>'] = ':'
map.v.nore['Y'] = '"+y'
map.v.nore['<Tab>'] = 'd:vnew<CR>PGddgg'
map.v['<C-s>'] = 'y\\g<C-r>"' -- grep for selection using Snap; h/t https://robots.thoughtbot.com/faster-grepping-in-vim
