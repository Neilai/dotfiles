inoremap  <C-h>   <Left>
inoremap  <C-j>   <Down>
inoremap  <C-k>   <Up>
inoremap  <C-l>   <Right>
inoremap  <C-d>   <DELETE>
imap hh <C-y>,
let mapleader=";"

inoremap jj <ESC>
nnoremap <Leader>w :w<cr> 
nnoremap <Leader>q :q<cr> 
nnoremap <Leader>ww :wa<cr>  
"air line config
let g:airline#extensions#tabline#enabled = 1


"easymotion config
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" 重复上一次操作, 类似repeat插件, 很强大
map <Leader><leader>. <Plug>(easymotion-repeat)



set nocompatible              " required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'vim-airline/vim-airline'
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Yggdroot/LeaderF'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'itchyny/vim-cursorword'
Plugin 'scrooloose/nerdcommenter'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-fugitive'
Plugin 'posva/vim-vue'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
call vundle#end()            " required
filetype plugin indent on    " required

colorscheme molokai


"leaderf config
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>'
noremap <c-n> :LeaderfMru<cr>
noremap <m-p> :LeaderfFunction!<cr>
noremap <m-n> :LeaderfBuffer<cr>
noremap <m-m> :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}



" ycm config
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black
set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }





"asyncrun config
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
"nnoremap <silent> <F4> :AsyncRun -cwd=<root> cmake . <cr>
"let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 
"nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>
"nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>
"nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
                exec "AsyncRun gcc % -o %< && ./%<"
        elseif &filetype == 'cpp'
                exec "AsyncRun g++ % -o %< && ./%<"
        elseif &filetype == 'java'
                exec "!javac %"
                exec "!time java %<"
        elseif &filetype == 'sh'
                :!time bash %
        elseif &filetype == 'python'
                exec "AsyncRun python %"
        elseif &filetype == 'html'
                exec "!open %"
        elseif &filetype == 'javascript'
                exec "AsyncRun node %"
        endif
endfunc



"gutentags config
set tags=./.tags;,.tags
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif




" Tagbar
let g:tagbar_width=35
let g:tagbar_autofocus=1
let g:tagbar_right=1
nmap <F3> :TagbarToggle<CR>




" NERDTree config
" open a NERDTree automatically when vim starts up
autocmd vimenter * NERDTree
"open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"map F2 to open NERDTree
map <F2> :NERDTreeToggle<CR>
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"cpp enhance highlight config
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

set backspace=indent,eol,start
set clipboard=unnamed
syntax on
set showmode
set mouse=a
set encoding=utf-8 
set t_Co=256
filetype indent on

set autoindent
set tabstop=2
set shiftwidth=4
set expandtab
set softtabstop=2

set number
set textwidth=80

set showmatch
set hlsearch
set incsearch

set incsearch
set noswapfile
set undofile

set directory=~/.vim/.swp//
set undodir=~/.vim/.undo// 

set autochdir
set noerrorbells
set visualbell
set history=1000
set autoread
set wildmenu
set wildmode=longest:list,full


autocmd BufNewFile *.c,*.cpp,*.sh,*.py exec ":call SetTitle()"
func SetTitle()
        if (&filetype == 'c' || &filetype == 'cpp')
                call setline(1, "/*************************************************************************")
                call setline(2, "\ @Author: Neil<laijingzhi@foxmail.com>")
                call setline(3, "\ @Created Time : ".strftime("%Y-%m-%d %T"))
                call setline(4, " ************************************************************************/")
                call setline(5,"")
        endif
        if &filetype == 'sh'
                call setline(1, "\#!/bin/sh")
                call setline(2, "\# Author: Neil<laijingzhi@foxmail.com>")
                call setline(3, "\# Created Time : ".strftime("%Y-%m-%d %T"))
                call setline(4,"")
        endif
        if &filetype == 'python'
                call setline(1, "\#!/usr/bin/python")
                call setline(2, "\# -*- coding=utf8 -*-")
                call setline(3, "\"\"\"")
                call setline(4, "\ Author: Neil<laijingzhi@foxmail.com>")
                call setline(5, "\ Created Time : ".strftime("%Y-%m-%d %T"))
                call setline(6, "\"\"\"")
                call setline(7,"")
        endif
endfunc
autocmd BufNewfile * normal G
