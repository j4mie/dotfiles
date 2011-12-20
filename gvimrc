" http://www.abbeyworkshop.com/howto/osx/osxVim/index.html

syntax on
set ai
set nu
set ts=4
set laststatus=2
"set nocompatible
set vb
win 150 50

set showtabline=2

" Show a vertical column at 80 characters in Python files and
" highlight anything after column 80 in grey.
if exists('+colorcolumn')
    autocmd FileType * set colorcolumn=
    autocmd FileType python set colorcolumn=80|match ColorColumn '\%>80v.\+'
    highlight ColorColumn ctermbg=lightgray guibg=#073642
endif
