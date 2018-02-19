"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show matching brackets/parenthesis
set showmatch

" Enable language-specific syntax highlighting
syntax on

" Enable filetype plugin
filetype plugin on
filetype indent on

" Don't redraw while executing macros
set lazyredraw

" Set magic on, for RegExp
set magic

"Always 5 lines above/below the cursor
set scrolloff=5

" No sound on errors
set noerrorbells
set novisualbell
set tm=500

" Fold options
set nofoldenable
set foldlevel=99
set foldminlines=99
set foldlevelstart=99

" Disable hightlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Show line numbers
set number

" Highlight cursor
set cursorline

" Fix TERM
set t_Co=256

" 256 colorspace
let base16colorspace=256  

" Set UTF-8 as standard encoding and en_US as the standard language
set encoding=utf8
try
    lang en_US
catch
endtry