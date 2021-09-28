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
Plug 'joshdick/onedark.vim'

" Sidebar File Browser
Plug 'preservim/nerdtree'				" File browser
Plug 'Xuyuanp/nerdtree-git-plugin'			" Git status
Plug 'ryanoasis/vim-devicons'				" Icon
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' 

" Find file and folder 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Tagbar show method in file

" Float terminal
Plug 'voldikss/vim-floaterm'

" Code intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'

" Code syntax highlight
Plug 'yuezk/vim-js'                                 " For JavaScript
Plug 'HerringtonDarkholme/yats.vim'                 " For TypeScript
Plug 'maxmellon/vim-jsx-pretty'                     " For React 

" Plugin Syntax Javascript
Plug 'jelera/vim-javascript-syntax'
" React and TypeScript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'ianks/vim-tsx'
Plug 'preservim/tagbar'

" Plugin Syntax Ruby
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh', }

" Source code version control
Plug 'tpope/vim-fugitive'

" Multiple cursor
Plug 'terryma/vim-multiple-cursors'

" Auto save
Plug '907th/vim-auto-save'

" Surround
Plug 'tpope/vim-surround'

" Commentary
Plug 'tpope/vim-commentary'

" Prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/0.x'
  \ }


call plug#end()

" ============================
"  # General Config Vim
" ============================
syntax on
let mapleader=','
let g:auto_save = 1 
set encoding=UTF-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast
set ruler
set number
set noswapfile
set list
set listchars=tab:\ \ ,trail:·,eol:¬,nbsp:_
set backspace=indent,eol,start
set textwidth=80
set showcmd
set incsearch
set autowrite
set foldmethod=indent 
set foldlevelstart=99
set ignorecase
set relativenumber
set numberwidth=5

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" Enable hidden buffers
set hidden

"" Remove hightligh
map <C-u> :nohl<CR>

"" Tabs. May be overridden by autocmd rules
set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab
" ============================
"  # Config Theme
" ============================
colorscheme onedark
set background=dark

" ============================
"  # Config Package
" ============================

" Setting package Tagbar
nmap <F8> :TagbarToggle<CR>

" Setting for emmet
let g:user_emmet_mode='i'

" Ruby
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

augroup vimrc-ruby
  autocmd!
  autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal filetype=ruby
  autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2
augroup END

let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }

" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab


" javascript
let g:javascript_enable_domhtmlcss = 1

" vim-javascript
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript setl tabstop=4|setl shiftwidth=4|setl expandtab softtabstop=4
augroup END

au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

" Coc Global Extension
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']
"===========================
"  # Extension Setting
" ===========================
let nvim_setting_dir = '~/.config/nvim/settings/'

execute 'source '.nvim_setting_dir.'airline.vim'
execute 'source '.nvim_setting_dir.'close_tag.vim'
execute 'source '.nvim_setting_dir.'window_config.vim'
execute 'source '.nvim_setting_dir.'package_config.vim'
execute 'source '.nvim_setting_dir.'fzf.vim'
execute 'source '.nvim_setting_dir.'cursor.vim'
execute 'source '.nvim_setting_dir.'coc.vim'
execute 'source '.nvim_setting_dir.'float_term.vim'
execute 'source '.nvim_setting_dir.'nerdtree.vim'
" execute 'source '.nvim_setting_dir.'prettier.vim'
" execute 'source '.nvim_setting_dir.'typescript_config.vim'

