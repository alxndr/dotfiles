local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<Leader>o', ':only<CR>')
map('n', ',n', ':nohl<CR>')
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

map('v', '<Space>', ':')
