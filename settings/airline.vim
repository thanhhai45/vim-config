" Enable Extension
let g:airline#extensions#tabline#enabled = 1
" Font
let g:airline_powerline_fonts = 1

" Setup themes
let g:airline_theme='onedark'

" Tabline define straight tabs
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_statusline_ontop=0
let g:airline#extensions#whitespace#enabled = 0 
