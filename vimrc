syntax on
set number relativenumber
set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a

call plug#begin()

Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/dylanaraps/wal.vim'

set encoding=UTF-8

call plug#end()

:colorscheme wal


inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
