"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"User Vim settings, rather than Vi settings
set nocompatible

"Security from Vim modeline vulneralibility
set modelines=0

" Change buffer without saving
set hidden

"Record undo history
set undofile
set undodir=~/.vim/undo
set noswapfile

" Turn backup off
set nobackup
set nowb

" Fuzzy find
set path+=**

" Turn on lazy filename tab completion
set wildmode=longest,list,full
set wildmenu
set wildignorecase

" Ignore files vim doesn't use
set wildignore+=.git,.hg,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class,*.pyc
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
set wildignore+=*.mp3,*.oga,*.ogg,*.wav,*.flac
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf,*.cbr,*.cbz
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
set wildignore+=*.swp,.lock,.DS_Store,._*,*~

" Set how many lines of history VIM has to remember
set history=700

" Set to autoread when a file is changed from the outside
set autoread

" Remap vim 0 to jump to the start of text in line
map 0 ^

" Map leader
let mapleader   =','
let g:mapleader =','

" Fast saving
nmap <leader>w :w!<cr>

" Ignore case when searching
set ignorecase
set infercase

" Set backspace
set backspace=indent,start,eol

" Highlight search matches
set hlsearch

" Incremental search as characters are typed
set incsearch

" Don't expand tabs to spaces
set noexpandtab

" Set tabs to have 4 spaces
set shiftwidth=4

" Indention is 4 columns
set tabstop=4

" Backspace deletes indent
set softtabstop=4

" Autoindent
set autoindent

" Wrap text instead of being on one line
set lbr

" Set text width for automatic word wrapping
set tw=500

" Smart indent
set smartindent

"Wrap lines
set wrap

" When vimrc is edited, reload it
autocmd! BufWritePost .vimrc source %

" Set default shell
set shell=$SHELL

" Set xterm2 mouse mode to allow resizing of splits with mouse inside tmux
if !has('nvim')
    set ttymouse=xterm2
end

" Switch from Terminal mode back to normal mode with <ESC> and send escape key with <C-v><Esc>
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-v><Esc> <Esc>
end

" Toggle spellcheck
:map <Leader>s :setlocal spell! spelllang=en_us<CR>

" Use system clipboard
set clipboard=unnamedplus

" Fast reload vimrc
map <leader>vi :so $MYVIMRC<CR>
