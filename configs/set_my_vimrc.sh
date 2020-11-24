#!/bin/bash

set -e 

if [ -f ~/.vimrc ];then
    rm ~/.vimrc
fi

IFS=$'\n'
while read -r line;do
    for val in $line; do
        echo $val >> ~/.vimrc
    done
done << "EOF"
set smartindent
set tabstop=4
set expandtab
set shiftwidth=4
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0"
EOF
unset IFS
