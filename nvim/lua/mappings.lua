local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<Leader>j', '<cmd>lua require"gitsigns.actions".next_hunk()<CR>')
map('n', '<Leader>k', '<cmd>lua require"gitsigns.actions".prev_hunk()<CR>')
map('n', '<Leader>o', ':only<CR>')
map('n', '<Leader>t', ':FloatermToggle<CR>')
map('n', '<Leader>v', ':edit $MYVIMRC<CR>') -- h/t roryokane https://lobste.rs/s/6qp0vo#c_fu9psh
map('n', '<Leader>w', ':set list!<CR>')
map('n', '<Leader>,', 'm`A,<Esc>``j') -- append comma to line and move down
map('n', '<Leader>;', 'm`A;<Esc>``j') -- append semicolon to line and move down
map('n', ',gc', ':Git commit<CR>')
map('n', ',gp', ':Git push')
map('n', ',gP', ':Git push --force')
map('n', ',gs', ':Git<CR>')
map('n', ',n', ':nohl<CR>')
map('n', 'Q', ':BufDel<CR>')
map('n', ',w', '10<C-w>>')
map('n', ',W', '5<C-w>+')
map('n', '<Space>', ':')
map('n', '<CR>', 'm`o<Esc>``')
map('n', '<Tab>', '<C-w><C-w>')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('n', '-', '<C-x>')
map('n', '+', '<C-a>')

map('i', 'jk', '<Esc>')
map('i', 'kj', '<Esc>')

map('t', '<Leader>t', '<C-\\><C-n>:FloatermToggle<CR>')
map('t', '<C-Space>', '<C-\\><C-n>')

map('v', '<Space>', ':')
