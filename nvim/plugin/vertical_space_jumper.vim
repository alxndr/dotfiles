" vertical movement through whitespace
" ...h/t WChargin http://vi.stackexchange.com/a/156/67

function! VerticalSpaceJumpUp()
  while line(".") > 1 && (strlen(getline(".")) < col(".") || getline(".")[col(".") - 1] =~ '\s')
    norm k
  endwhile
endfunction
function! VerticalSpaceJumpDown()
  while line(".") > 1 && (strlen(getline(".")) < col(".") || getline(".")[col(".") - 1] =~ '\s')
    norm j
  endwhile
endfunction
