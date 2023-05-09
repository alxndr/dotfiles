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
