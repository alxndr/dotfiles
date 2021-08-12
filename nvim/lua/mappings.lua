vim.g.mapleader = '\\'

local map = require 'cartographer'
local snap = require 'snap'

local findFile = function ()
  snap.run {
    producer = snap.get'consumer.fzf'(snap.get'producer.ripgrep.file'),
    select = snap.get'select.file'.select,
    multiselect = snap.get'select.file'.multiselect,
    views = {snap.get'preview.file'}
  }
end
local findBuffer = function ()
  snap.run {
    producer = snap.get'consumer.fzf'(snap.get'producer.vim.buffer'),
    select = snap.get'select.file'.select,
    multiselect = snap.get'select.file'.multiselect,
    views = {snap.get'preview.file'}
  }
end
local searchWithGrep = function ()
  snap.run {
    producer = snap.get'consumer.limit'(100000, snap.get'producer.ripgrep.vimgrep'),
    select = snap.get'select.vimgrep'.select,
    multiselect = snap.get'select.vimgrep'.multiselect,
    views = {snap.get'preview.vimgrep'}
  }
end

-- normal mode
snap.register.map({'n'}, {'<Leader><Leader>'}, findBuffer)
snap.register.map({'n'}, {'<Leader>g'}, searchWithGrep)
map.n.nore['<Leader>j'] = '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'
map.n.nore['<Leader>k'] = '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'
map.n.nore['<Leader>n'] = ':only<CR>'
map.n.nore['<Leader>t'] = ':FloatermToggle<CR>'
map.n.nore['<Leader>u'] = ':lua require"gitsigns".reset_hunk()<CR>'
map.n.nore['<Leader>v'] = ':edit $MYVIMRC<CR>' -- h/t roryokane https://lobste.rs/s/6qp0vo#c_fu9psh
map.n.nore['<Leader>w'] = ':set list!<CR>'
map.n.nore['<Leader>y'] = ':only<CR>'
map.n.nore['<Leader>,'] = 'm`A,<Esc>``j' -- append comma to line and move down
map.n.nore['<Leader>;'] = 'm`A;<Esc>``j' -- append semicolon to line and move down
map.n.nore['<Leader><Tab>'] = ':NvimTreeToggle<CR>'
map.n.nore['<Space>'] = ':'
map.n.nore['<CR>'] = 'm`o<Esc>``'
map.n.nore['<Tab>'] = '<C-w><C-w>'
map.n.nore.expr['<C-d>'] = "(winheight(0)/3).'<C-d>'"
map.n.nore['<C-h>'] = '<C-w>h'
map.n.nore['<C-j>'] = '<C-w>j'
map.n.nore['<C-k>'] = '<C-w>k'
map.n.nore['<C-l>'] = '<C-w>l'
snap.register.map({'n'}, {'<C-p>'}, findFile)
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
map.n.nore['-'] = '<C-x>'
map.n.nore['+'] = '<C-a>'
map.n['#'] = '#N' -- "find word under cursor" remains on current word
map.n['*'] = '*N' -- "find word under cursor" remains on current word

-- insert mode
map.i.nore['jk'] = '<Esc>'
map.i.nore['kj'] = '<Esc>'

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
