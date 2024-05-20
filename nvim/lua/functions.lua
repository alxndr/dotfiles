-- move cursor vertically, to next printable character
-- ...h/t kenorb https://vi.stackexchange.com/a/693/67
vim.cmd [[
  function! VerticalSpaceJumpUp()
    call search('\%' . virtcol('.') . 'v\S', 'bW')
  endfunction
  function! VerticalSpaceJumpDown()
    call search('\%' . virtcol('.') . 'v\S', 'W')
  endfunction
]]
require'which-key'.register({
  j = {'<CMD>call VerticalSpaceJumpDown()<CR>', 'move up to next printable character'},
  k = {'<CMD>call VerticalSpaceJumpUp()<CR>', 'move down to next printable character'},
}, {prefix='<Leader>'})
