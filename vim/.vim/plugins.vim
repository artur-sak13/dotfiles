"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim PlugIns
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath+=~/.vim/

"Pull in Vim Plug if not there already
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

"Accessibility and fixes
Plug 'sjl/vitality.vim'                 "Make Vim play nicely with iTerm2 and Tmux
Plug 'mhinz/vim-startify'               "Nice alternate start screen for Vim
Plug 'simeji/winresizer'                "Easy window resizing
Plug 'roxma/vim-tmux-clipboard'         "Vim and Tmux clipboard integration

" Code Formatting
Plug 'tpope/vim-surround'               "Easily delete, add, or replace surroundings (i.e. parenthesis, brackets, etc.)
Plug 'tpope/vim-endwise'                "End certain structures automatically (i.e. end after if, do, def, etc.)
Plug 'godlygeek/tabular'                "Regex code alignment
Plug 'Raimondi/delimitMate'             "Autoclose quotes, parenthesis, brackets, etc.
Plug 'Chiel92/vim-autoformat'           "External formatting program integration
" Plug 'junegunn/vim-easy-align'         Potential substitute for tabular alignment

" Linting
Plug 'w0rp/ale'                         "Asynchronous lint engine

" Extensions/Additions
Plug 'majutsushi/tagbar'                "Project structure sidebar using tags
Plug 'matze/vim-move'                   "Delete and paste text blocks in as visual drag blocks
Plug 'scrooloose/nerdtree'              "Tree file system explorer for Vim
Plug 'sjl/gundo.vim'                    "Undo tree visualization
Plug 'nathanaelkane/vim-indent-guides'  "Display indent levels in Vim
Plug 'terryma/vim-multiple-cursors'     "Sublime Text style multiple selection for Vim

"Asynchronous keyword completion
Plug 'Shougo/deoplete.nvim', has('nvim') ? {} : { 'do': ':UpdateRemotePlugins'}

" Git
Plug 'airblade/vim-gitgutter'           "Asynchronously displays a git diff in the sign column
Plug 'Xuyuanp/nerdtree-git-plugin'      "Show git repo status on NERDTree

Plug 'sheerun/vim-polyglot'             "A collection of language packs for Vim

" Markdown
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" LaTeX
Plug 'donRaphaco/neotex', { 'for': 'tex' }

" Haskell
Plug 'eagletmt/neco-ghc'                "Completion plugin for Haskell, using ghc-mod
Plug 'neovimhaskell/haskell-vim'        "Improved syntax highlighting and indentation for Haskell and Cabal

" Elm
Plug 'pbogut/deoplete-elm'				"Completion plugin for Elm

" Rust
Plug 'sebastianmarkow/deoplete-rust'    "Completion plugin for Rust (Note: run cargo install racer)

" Themes
Plug 'vim-airline/vim-airline'          "Status/tabline for Vim
Plug 'vim-airline/vim-airline-themes'   "Themes for airline status line

" Color
Plug 'luochen1990/rainbow'              "Color codes matching parenthesis and other surroundings
Plug 'lilydjwg/colorizer'               "Colorize all text denoting rgb/rgba colors
Plug 'chriskempson/base16-vim'          "Base16 color schemes for Vim

call plug#end()