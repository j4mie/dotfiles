source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

set nocompatible

filetype on
filetype plugin on
filetype indent on

set cindent
set smartindent
set autoindent
set copyindent
set shiftwidth=4
set tabstop=4
set expandtab
set number
set directory=~/.vim/tmp
set nobackup
set nowritebackup
set ruler
set list
scriptencoding utf-8
set listchars=tab:>-,trail:·,extends:#,nbsp:.
set cursorcolumn
set cursorline

highlight SpecialKey guifg=lightgray ctermfg=lightgray

if &t_Co > 2 || has("gui_running")
    syntax on
endif

au BufNewFile,BufRead *.less set filetype=less
