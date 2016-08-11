"--------------------------------------------------
" Character encoding
set termencoding=utf-8
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936,gbk,big5,latin1

"--------------------------------------------------
" Base settings
set guifont=Fixedsys\ 10
set nocompatible          " We're running Vim, not Vi!
syntax on                 " syntax highlingt
set autoindent            " automatical code indent
set cindent
set smartindent
set backspace=2           " backspace del all
set history=50            " history of commands
set hlsearch              " highlignt search fraze
filetype plugin on        " file type based syntax highliht
filetype indent on
filetype on
set ts=4                  " tab stop
set sw=4                  " shift width (with autoindent)
set ai!
set textwidth=2048        " text witdth
set nu                    " show numbers
set lcs=tab:>.,eol:$      " show non printed chars
set whichwrap+=<,>,[,]    " where wrap long lines
set gdefault              " /g default on s///
set showcmd               " show typed commands
"set wildmenu              " show menu (bash-like) on tab
set wildignore=*.o,*~     " ignor on wildmenu
set incsearch             " show what is typed on /
"set viminfo='1000,f1,:1000,/1000  " big viminfo :)
set history=500
set lazyredraw
set wmh=0
set t_Co=256              " color numbers
set nowrap                " do not wrap lines
" 代码折叠
set foldmethod=marker

"--------------------------------------------------
" Open in last edit place
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

"--------------------------------------------------
" Syntax coloring (/usr/share/vim/vim73/colors/)
" colorscheme herald

"---------------------------------------------------
" Tab size
:set tabstop=4        " Force tabs to be displayed/expanded to 2 spaces (instead of default 8).
:set softtabstop=4    " Make Vim treat <Tab> key as 2 spaces, but respect hard Tabs.
                      " I don't think this one will do what you want.
:set expandtab        " Turn Tab keypresses into spaces.  Sounds like this is happening to you.
                      " You can still insert real Tabs as [Ctrl]-V [Tab].
:set shiftwidth=4     " When auto-indenting, indent by this much.
                      " (Use spaces/tabs per "expandtab".)
:retab                " Change all the existing tab characters to match the current tab settings

let g:EnhCommentifyUseSyntax = 'Yes'         "自动按照类型进行不同的注释
let g:EnhCommentifyMultiPartBlocks = 'yes'   "注释多行时不要每行都加注释符
let g:EnhCommentifyAlignRight = 'yes'        "注释自动对齐
" let g:EnhCommentifyRespectIndent = 'Yes'    "注释靠近代码
let g:EnhCommentifyPretty = 'Yes'             "注释和文字中间加空格

"只有在是PHP文件时，才启用PHP补全
au FileType php call AddPHPFuncList()
function AddPHPFuncList()
  ""http://svn.php.net/viewvc/phpdoc/doc-base/trunk/funclist.txt
  "php字典下载地址
  set dictionary=/Users/baidu/.vim/php.dict
  set complete-=k complete+=k
endfunction
" Word completion on <TAB>
function! InsertTabWrapper(direction)
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  elseif "backward" == a:direction
    return "\<c-p>"
  else
    return "\<c-n>"
  endif
endfunction
inoremap <Tab> <C-R>=InsertTabWrapper("backward")<CR>
inoremap <S-Tab> <C-R>=InsertTabWrapper("forward")<CR>

"自动php语法
"let php_sql_query=1
"let php_htmlInStrings=1

"php自动生成文档
"au BufRead,BufNewFile *.php nnoremap <buffer> <C-P> :call PhpDoc()<CR>
"au BufRead,BufNewFile *.php vnoremap <buffer> <C-P> :call PhpDocRange()<CR>
"au BufRead,BufNewFile *.php inoremap <buffer> <C-P> :call PhpDoc()<CR>

"状态行颜色
hi statusline term=underline ctermbg=darkgray ctermfg=gray
"在状态行上显示光标所在位置的行号和列号
set ruler
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)
set laststatus=2             " 开启状态栏信息
set cmdheight=1              " 命令行的高度，默认为1，这里设为2
set statusline=%F%m%r%h%w\ (%{&encoding})\[POS=%l,%v][%p%%]\%{strftime(\"%Y/%m/%d\ %H:%M\")}

"多标签浏览设置标签颜色
highlight TabLine term=underline ctermbg=darkgray ctermfg=gray
highlight TabLineSel term=bold cterm=bold ctermbg=darkgreen ctermfg=white
"高亮光标所在行
" set cursorline
hi CursorLine cterm=NONE ctermbg=darkgray
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white

""""""""""""""""""""""""""""""PLUGIN""""""""""""""""""""""""""""
" Pathogen
call pathogen#infect()
call pathogen#helptags()

" NERDTree
"autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | wincmd p | endif
let NERDTreeIgnore=['\.pyc$', '\~$']


"---快捷键-----------------------------------------------
nmap <C-i> :%s/[ \t\r]\+$//g<CR>
