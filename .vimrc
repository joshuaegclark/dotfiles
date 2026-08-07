" ~/.vimrc — deliberately minimal.
"
" termguicolors is OFF, so vim paints from the terminal's ANSI palette. The
" override below targets a palette *slot* (number), not a hex, so it follows
" whichever shell theme is active — see ~/.config/shell-themes and `theme`.
"
" Why this exists: on 256-color terminals vim's default cterm color NAMES don't
" line up with the ANSI palette order, so the "Cyan"-named Comment group lands
" on slot 11 — which is the amber/yellow slot. This drags comments off amber.
" Slots in this palette:  8=grey  11=amber  13=purple  14=cyan  20=muted lavender

syntax on

function! s:BiolumeTweaks() abort
  " Comments off amber (slot 11) onto a readable, secondary muted lavender (20).
  " Swap to 8 (dimmer grey) or 12 (blue) to taste; keywords stay on cyan (14).
  highlight Comment ctermfg=20 cterm=NONE
endfunction

augroup biolume_tweaks
  autocmd!
  autocmd VimEnter,ColorScheme,Syntax * call s:BiolumeTweaks()
augroup END
call s:BiolumeTweaks()
