set nocompatible
filetype off

" Plugin pre-setup
let s:bundle_path="~/.vim/bundles"
let s:bundler_path=s:bundle_path . "/neobundle.vim"
let s:bundler_exists=filereadable(expand(s:bundler_path . "/README.md"))
let s:bundler_install="git clone https://github.com/Shougo/neobundle.vim "
let s:bundler_install.=expand(s:bundler_path)
if !s:bundler_exists
  echo "Installing plugin manager..."
  silent! exec mkdir(expand(s:bundle_path), "p")
  call system(s:bundler_install)
endif
exec "set rtp+=" . s:bundler_path
call neobundle#begin(expand(s:bundle_path))

" Plugins
NeoBundleFetch "Shougo/neobundle.vim"
NeoBundle "airblade/vim-gitgutter"
NeoBundle "bling/vim-airline"
NeoBundle "jiangmiao/auto-pairs"
NeoBundle "reedes/vim-colors-pencil"
NeoBundle "scrooloose/nerdtree"
NeoBundle "tpope/vim-endwise"
NeoBundleLazy "elzr/vim-json", {"autoload": {"filetypes": ["json"]}}
NeoBundleLazy "mattn/emmet-vim", {"autoload": {"filetypes": ["html"]}}
NeoBundleLazy "tpope/vim-markdown", {"autoload": {"filetypes": ["markdown"]}}

" Plugin post-setup
call neobundle#end()
if s:bundler_exists
  NeoBundleCheck
else
  NeoBundleInstall
  echo "\nDone! Restart vim."
  qa!
end
filetype plugin indent on

" General remapping
nnoremap ; :
vnoremap ; :

" Buffer
set hidden
nmap <leader>bd :ene<CR>:bw #<CR>
nnoremap <C-j> :bp!<CR>
nnoremap <C-k> :bn!<CR>

" Esc
imap <C-c> <Esc>
vmap <C-c> <Esc>
vno v <Esc>

" Tab
imap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Editing
set smartindent
set backspace=indent,eol,start
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set fileformats=unix,dos
set shiftwidth=2
set softtabstop=2
set tabstop=2
autocmd BufWritePre * :%s/\s\+$//e

" Stop moving cursor back
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

" Folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" Mouse
set ttyfast
set mouse=a
set ttymouse=xterm2

" Search
set ignorecase
set incsearch
set nohlsearch
set smartcase

" Appearance
syntax on
set relativenumber
set number
set splitright
set splitbelow
set scrolloff=1000
set list!
set list listchars=trail:·
set term=xterm
set t_Co=256
set background=dark
set cursorline cursorcolumn
colorscheme pencil
autocmd FileType javascript,ruby,vim call matchadd('ColorColumn', '\%81v', 100)
autocmd FileType cs,java call matchadd('ColorColumn', '\%121v', 100)
autocmd BufEnter,BufNew *.swig setlocal syntax=html
autocmd BufEnter,BufNew *.gradle setlocal syntax=groovy

" netrw
let g:loaded_netrw=0
let g:loaded_netrwPlugin=0

" Neosnippet
xmap <C-l> <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory="~/.dotfiles/vim/snippets"

" Airline
set laststatus=2
set noshowmode
set timeoutlen=1000 ttimeoutlen=0
let g:airline_theme="pencil"
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_tab_nr=0
if !has("gui_macvim")
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''
  let g:airline_left_sep=''
  let g:airline_right_sep=''
endif

" NERDTree
let g:NERDTreeAutoCenter=1
let g:NERDTreeMinimalUI=1
nnoremap <C-h> :NERDTreeToggle<CR>

" Markdown
" let g:markdown_fenced_languages = ["javascript", "ruby", ...]
