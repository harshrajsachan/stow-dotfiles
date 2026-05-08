" =========================
" Minimal .vimrc
" =========================

" Enable syntax highlighting
" Line numbers
set number
set relativenumber
set shortmess+=I
set fillchars=eob:-
            

" Mouse support
set mouse=a

" Better indentation
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" Search settings
set ignorecase
set smartcase
set incsearch
set hlsearch

" Better scrolling
set scrolloff=8

" Show matching brackets
set showmatch

" Enable clipboard
set clipboard=unnamedplus

" Faster updates
set updatetime=300

" Split behavior
set splitbelow
set splitright

" Better backspace behavior
set backspace=indent,eol,start

" Remove swap/backup files
set nobackup
set nowritebackup
set noswapfile

" Status line

" Leader key
let mapleader=" "

" Quick save
nnoremap <leader>w :w<CR>

" Quick quit
nnoremap <leader>q :q!<CR>

nnoremap <leader>wq :wq<CR>


" Clear search highlight
nnoremap <leader>h :nohlsearch<CR>
