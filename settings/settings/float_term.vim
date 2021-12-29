" Setup size and position show terminal
let g:floaterm_position = 'topright'
let g:floaterm_width = 0.6
let g:floaterm_height = 0.6
let g:floaterm_title = 'Terminal $1/$2'
let g:floaterm_wintype = 'float'
let g:floaterm_rootmarkers = ['.pro']
let g:floaterm_name = "Default"
" Set color
hi Floaterm guibg=Grey15
hi FloatermBorder guifg=Orange guibg=DarkGreen

" nnoremap <C-t> :FloatermNew --title='Terminal' zsh<CR>

nnoremap <silent> <C-t> :FloatermToggle<CR>
tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>
