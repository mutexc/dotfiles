set number
set noswapfile
set shiftwidth=4
set smarttab
set expandtab
set nobackup
set scrolloff=7
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmatch
set hlsearch
set history=1000
set cursorline
let &t_SI = "\e[6 q]"
let &t_EI = "\e[2 q]"
set mouse=a
set relativenumber
set clipboard="unnamedplus"
set colorcolumn=80
colorscheme torte
syntax on

let mapleader = " "
call plug#begin()
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
call plug#end()
nnoremap <Leader>f :FZF<CR>
