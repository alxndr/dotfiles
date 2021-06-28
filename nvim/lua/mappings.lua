local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- normal mode
map('n', '<Leader>j', ':GitGutterNextHunk<CR>')
map('n', '<Leader>k', ':GitGutterPrevHunk<CR>')
map('n', '<Leader>o', ':only<CR>')
map('n', '<Leader>t', ':FloatermToggle<CR>')
map('n', '<Leader>u', ':GitGutterUndoHunk<CR>')
map('n', '<Leader>v', ':edit $MYVIMRC<CR>') -- h/t roryokane https://lobste.rs/s/6qp0vo#c_fu9psh
map('n', '<Leader>w', ':set list!<CR>')
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
-- map('n', '<C-s>', ':grep! "\\b<C-R><C-W>\\b"<CR>:cw<CR>') -- grep for word under cursor; h/t https://robots.thoughtbot.com/faster-grepping-in-vim
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
