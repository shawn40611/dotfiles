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
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'tpope/vim-fugitive'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tmhedberg/matchit'
Plugin 'dart-lang/dart-vim-plugin'
    autocmd FileType html,htmldjango let b:closetag_html_style=1
    autocmd FileType html,xhtml,xml,htmldjango source ~/.vim/bundle/closetag.vim/plugin/closetag.vim
    let g:ale_echo_msg_format = '%linter% says %s'
    let g:ale_fixers = {
          \ 'python': ['autopep8'],
          \ }
Plugin 'w0rp/ale'  " Syntax linter
Plugin 'pugjs/pug-lint'  " default pug linter for ALE
Plugin 'hynek/vim-python-pep8-indent'  " Python indent
Plugin 'tell-k/vim-autopep8'
Plugin 'digitaltoad/vim-pug'  " pug
Plugin 'iamcco/markdown-preview.nvim'


" ==== Plugins END
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
set cindent
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
let g:syntastic_pug_checkers = ['pug_lint']
let g:syntastic_javascript_checkers = ['eslint']

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
" autocmd CursorMoved * exe printf('match Underlined /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" Remove extra trailling spaces
autocmd BufWritePre * :%s/\s\+$//e

" turn on pug linter
let g:syntastic_pug_checkers = ['pug_lint']
" tabs
set expandtab
set ttyfast
set softtabstop=2
set tabstop=2
set shiftwidth=2
set number relativenumber
" map to clipboard
set clipboard=unnamed

" Markdown preview related
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }
" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']
