"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h


"" Split
noremap <leader>s :<C-u>split<CR>
noremap <leader>v :<C-u>vsplit<CR>


" Resize pane
nmap <M-Right> :vertical resize +1<CR> 		
nmap <M-Left> :vertical resize -1<CR>
nmap <M-Down> :resize +1<CR>
nmap <M-Up> :resize -1<CR>

"" Get off my law
nnoremap <Left> :echoe "Use h"<CR> 
nnoremap <Right> :echoe "Use l"<CR> 
nnoremap <Up> :echoe "Use k"<CR> 
nnoremap <Down> :echoe "Use j"<CR>

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
