" Setup size and position show terminal
let g:floaterm_position = 'botright'
let g:floaterm_width = 0.6
let g:floaterm_height = 0.3
let g:floaterm_title = 'Terminal $1/$2'
let g:floaterm_wintype = 'split'
let g:floaterm_rootmarkers = ['.pro']
let g:floaterm_name = "Default"
" Set color
hi Floaterm guibg=Grey15
hi FloatermBorder guifg=Orange guibg=DarkGreen

nnoremap <C-t> :FloatermNew --title='Terminal' zsh<CR>

nnoremap <silent> <F12> :FloatermToggle<CR>
tnoremap <silent> <F12> <C-\><C-n>:FloatermToggle<CR>
