" 此文件为VIM的配置文件

set softtabstop=4
" 使用tab时 tab空格数

set shiftwidth=4
" 默认缩进4个空格

set expandtab
" 使用空格替换tab

set autoindent
" 自动缩进

set nu
" nu用于显示行号

set ts=4
" ts用于设置tab键表示的空格数

colorscheme molokai
" 配色模式

syn on
" 语法高亮

filetype on
" 文件类型

set encoding=utf-8
" 文件编码为UTF-8

" :map! <F5> <Esc>:r !date<CR> -i
iab xtime <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
" 配置在插入模式下输入xtime再回车时插入当前日期和时间
