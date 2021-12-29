" 
"  __        __           ___           __                    ____________
" |  |      |  |         / | \         |  |  |  |            |            |
" |  |      |  |        / / \ \        |  |  |  |            |   _________|
" |  |      |  |       / /   \ \       |  |  |  |            |  |
" |  |      |  |      / /_____\ \      |  |  |  |            |  |______
" |  |------|  |     / /       \ \     |  |  |  |            |  |      |
" |            |    / /_________\ \    |  |  |  |            |  |______|
" |  |------|  |   / /           \ \   |  |  |  |            |  |
" |  |      |  |  / /             \ \  |  |  |  |_________   |  |________
" |  |      |  | / /               \ \ |  |  |            |  |           |
" |__|      |__|/_/                 \_\|__|  |____________|  |___________|
"
"
" Vim customize by HaiLe
"
"
" =================================
"  # VimPlug for managing Plugins
" =================================

call plug#begin('~/.config/nvim/plugged')

" Theme For Vim
Plug 'dracula/vim'
Plug 'EdenEast/nightfox.nvim'

" File Explorer
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" File Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}



" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" UI Tabline
Plug 'ap/vim-buftabline'

Plug 'prettier/vim-prettier'
Plug 'othree/xml.vim'
Plug 'othree/html5.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'tpope/vim-surround'

" GIT
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Terminal
Plug 'voldikss/vim-floaterm'

" Ruby 
Plug 'tpope/vim-rails'
Plug 'tpope/vim-cucumber'
Plug 'vim-ruby/vim-ruby'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-endwise'
Plug 'ngmy/vim-rubocop'

" Javascript
Plug 'sbdchd/neoformat'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'dense-analysis/ale'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ludovicchabant/vim-gutentags'
Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}


call plug#end()

" ============================
"  # General Config Vim
" ============================
"
let mapleader=','
if (has("termguicolors"))
 set termguicolors
endif
set listchars=tab:\ \ ,trail:·,eol:¬,nbsp:_
set backspace=indent,eol,start
syntax enable
colorscheme nightfox
set encoding=UTF-8
set termguicolors
set foldmethod=marker
set mouse=a
set nowrap
set number
set ttyfast
set ruler
set ls=2	" show status bar always
set hlsearch	" highlight search
set showtabline=0
set relativenumber
set numberwidth=5
highlight LineNr ctermfg=gray
highlight Pmenu ctermbg=gray guibg=gray " popup autocomplete menu color
set background=dark
set textwidth=80
set shiftwidth=2
set tabstop=2
set guifont=FiraCode-Retina:h12
"" Remove hightligh
map <C-u> :nohl<CR>

" Setting package Tagbar
nmap <C-m> :TagbarToggle<CR>


" ============================
" # NERDTree Config
" ===========================
autocmd StdinReadPre * let s:std_in=1
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
" Set ignore extension file 
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

" Change arrow to expand/collapse tree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Setting open tab 1 file
let g:nerdtree_tabs_focus_on_files=1

" Mapping customize icon for git status
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }


" =========================
" # Coc Config
" =========================
let g:coc_global_extensions = ['coc-tabnine', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

" ========================

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h


"" Split
noremap <leader>h :<C-u>split<CR>
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


"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


"" Setup Multiple cursor
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_config_present = 1

" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0

autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync


" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab
" Emmet
let g:user_emmet_leader_key='<C-z>'
" javascript
autocmd FileType javascript,*.jsx,*.js,*.tsx,*.ts,*.css,*.scss,*.json,*.yaml setl tabstop=2|setl shiftwidth=2|setl expandtab softtabstop=2

" html slim for ruby
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
autocmd Filetype slim setlocal ts=2 sw=2 expandtab

" Prettier
let g:neoformat_try_node_exe = 1

autocmd FileType javascript, javascriptreact setlocal formatprg=prettier\ --single-quote\ --trailing-comma\ es5
" Use formatprg when available
let g:neoformat_try_formatprg = 1

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'ruby': ['rubocop']
\}

let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma all'
let g:ale_set_highlights = 0 
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1 

autocmd FileType css,scss let b:prettier_exec_cmd = "prettier-stylelint"
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
nnoremap gp :silent %!prettier --stdin-filepath %<CR>
" Javascript
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-v>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Rubocop
let g:vimrubocop_config = '/Users/haingoc/.rbenv/shims/rubocop'

"Close tag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx,*.js,*.ts'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,js,ts,tsx'
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }

"===========================
"  # Extension Setting
" ===========================
let nvim_setting_dir = '~/.config/nvim/settings/'

execute 'source '.nvim_setting_dir.'fzf.vim'
execute 'source '.nvim_setting_dir.'float_term.vim'
execute 'source '.nvim_setting_dir.'airline.vim'

