set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" ==== Plugins START
Plugin 'morhetz/gruvbox'
Plugin 'ctrlpvim/ctrlp.vim'  " Contrl-P
Plugin 'bling/vim-airline'  " status bar
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-sleuth'  " Auto detect indentation with space or tab
Plugin 'docunext/closetag.vim'  " auto close html tag
Plugin 'ap/vim-css-color'
Plugin 'tpope/vim-fugitive'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
    autocmd FileType html,htmldjango let b:closetag_html_style=1
    autocmd FileType html,xhtml,xml,htmldjango source ~/.vim/bundle/closetag.vim/plugin/closetag.vim

    let g:ale_fixers = {
          \ 'python': ['autopep8'],
          \ }
Plugin 'w0rp/ale'  " Syntax linter
Plugin 'pugjs/pug-lint'  " default pug linter for ALE
Plugin 'hynek/vim-python-pep8-indent'  " Python indent
Plugin 'tell-k/vim-autopep8'
Plugin 'digitaltoad/vim-pug'  " pug

" ==== Plugins END
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ==== Custom Functions START
" Converts unicode escaped strings to unicode
function! UnicodeUnescape()
  :%s#\\u[0-9a-f]*#\=eval('"'.submatch(0).'"')#g
endfunction
" ==== Custom Functions END

" === Configs START
syntax on
colorscheme gruvbox
let g:gruvbox_undercurl=0
let g:gruvbox_underline=0
let g:airline_theme="gruvbox"

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=darkgray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black


" set highlight
set hls

" Setup backspace
set backspace=indent,eol,start
" === Configs END

" === ag settings
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" CtrlP fast fuzzy file open
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.*,env,*.pyc,lib,Users
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_user_command = 'ag %s -l -g ""'
endif

" Fast direcotry search
" nmap <leader>apy :Ag --python "<c-r><c-w>"
" nmap <leader>a :Ag "<c-r><c-w>"

" Highlight the occurance of current word, use following command to select color
" :so $VIMRUNTIME/syntax/hitest.vim
autocmd CursorMoved * exe printf('match Underlined /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" Remove extra trailling spaces
autocmd BufWritePre * :%s/\s\+$//e

" tabs
set expandtab
set ttyfast
set softtabstop=2
set tabstop=2
set shiftwidth=2
set number relativenumber
set clipboard=unnamed
