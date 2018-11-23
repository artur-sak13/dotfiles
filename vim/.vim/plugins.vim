"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim PlugIns
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath+=~/.vim/

"Pull in Vim Plug if not there already
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    augroup install
        au VimEnter * PlugInstall --sync | source $MYVIMRC
    augroup END
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
Plug 'tpope/vim-fugitive'				"Nice git integration
Plug 'godlygeek/tabular'                "Regex code alignment
Plug 'Raimondi/delimitMate'             "Autoclose quotes, parenthesis, brackets, etc.
Plug 'Chiel92/vim-autoformat'           "External formatting program integration
Plug 'neomake/neomake'					"Asynchronously run programs
" Plug 'junegunn/vim-easy-align'         Potential substitute for tabular alignment

" Linting
" Plug 'w0rp/ale'                       "Asynchronous lint engine

" Extensions/Additions
Plug 'majutsushi/tagbar'                "Project structure sidebar
Plug 'matze/vim-move'                   "Delete and paste text blocks in as visual drag blocks
Plug 'scrooloose/nerdtree'              "Tree file system explorer for Vim
Plug 'sjl/gundo.vim'                    "Undo tree visualization
Plug 'terryma/vim-multiple-cursors'     "Sublime Text style multiple selection for Vim

"Asynchronous keyword completion
Plug 'Shougo/deoplete.nvim', has('nvim') ? {} : { 'do': [':UpdateRemotePlugins',':set runtimepath+=~/.dotfiles/vim/.vim/plugged/deoplete.nvim/']}

" Git
Plug 'airblade/vim-gitgutter'           "Asynchronously displays a git diff in the sign column
Plug 'Xuyuanp/nerdtree-git-plugin'      "Show git repo status on NERDTree

Plug 'sheerun/vim-polyglot'             "A collection of language packs for Vim

" Themes
Plug 'itchyny/lightline.vim'            "Minimal statusline

" Color
Plug 'luochen1990/rainbow'              "Color codes matching parenthesis and other surroundings
Plug 'lilydjwg/colorizer'               "Colorize all text denoting rgb/rgba colors

" Terraform
Plug 'hashivim/vim-terraform'
Plug 'vim-syntastic/syntastic'
Plug 'juliosueiras/vim-terraform-completion'

call plug#end()
