" Highlight the cursorline only in the active window
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

augroup Term
  au!
  au VimLeavePre * CloseInactiveTerminals
augroup END
