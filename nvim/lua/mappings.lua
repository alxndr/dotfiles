local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

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
map('n', '<Leader>j', ':GitGutterNextHunk<CR>')
map('n', '<Leader>k', ':GitGutterPrevHunk<CR>')
map('n', '<Leader>n', ':only<CR>')
map('n', '<Leader>t', ':FloatermToggle<CR>')
map('n', '<Leader>u', ':GitGutterUndoHunk<CR>')
map('n', '<Leader>v', ':edit $MYVIMRC<CR>') -- h/t roryokane https://lobste.rs/s/6qp0vo#c_fu9psh
map('n', '<Leader>w', ':set list!<CR>')
map('n', '<Leader>y', ':only<CR>')
map('n', '<Leader>,', 'm`A,<Esc>``j') -- append comma to line and move down
map('n', '<Leader>;', 'm`A;<Esc>``j') -- append semicolon to line and move down
map('n', '<Leader><Tab>', ':NvimTreeToggle<CR>')
map('n', '<Space>', ':')
map('n', '<CR>', 'm`o<Esc>``')
map('n', '<Tab>', '<C-w><C-w>')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
snap.register.map({'n'}, {'<C-p>'}, findFile)
map('n', '<C-s>', 'viw<C-s>', {noremap=false}) -- grep for word under cursor; h/t https://robots.thoughtbot.com/faster-grepping-in-vim
map('n', ',gc', ':Git commit<CR>')
map('n', ',gp', ':Git push')
map('n', ',gP', ':Git push --force')
map('n', ',gs', ':Git<CR>')
map('n', ',n', ':nohl<CR>')
map('n', ',t', 'za')
map('n', 'Q', ':BufDel<CR>')
map('n', ',w', '10<C-w>>')
map('n', ',W', '5<C-w>+')
map('n', '-', '<C-x>')
map('n', '+', '<C-a>')
map('n', '#', '#N', {noremap=false}) -- "find word under cursor" remains on current word
map('n', '*', '*N', {noremap=false}) -- "find word under cursor" remains on current word

-- insert mode
map('i', 'jk', '<Esc>')
map('i', 'kj', '<Esc>')

-- terminal mode
map('t', '<Leader>n', '<C-\\><C-n>:FloatermNew<CR>')
map('t', '<Leader>t', '<C-\\><C-n>:FloatermToggle<CR>')
map('t', '<Leader>[', '<C-\\><C-n>:FloatermPrev<CR>')
map('t', '<Leader>]', '<C-\\><C-n>:FloatermNext<CR>')
map('t', '<C-Space>', '<C-\\><C-n>')
map('t', '<C-t>', '<C-\\><C-n>:FloatermToggle<CR>')
map('t', '<C-[>', '<C-\\><C-n>:FloatermPrev<CR>')
map('t', '<C-]>', '<C-\\><C-n>:FloatermNext<CR>')

-- visual mode
map('v', '<Space>', ':')
map('v', 'Y', '"+y')
map('v', '<C-s>', 'y\\g<C-r>"', {noremap=false}) -- grep for selection using Snap; h/t https://robots.thoughtbot.com/faster-grepping-in-vim
