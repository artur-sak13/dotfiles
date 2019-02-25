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
set wildignore+=.git,.hg,.svn                                                   " Version control
set wildignore+=*.aux,*.out,*.toc                                               " LaTeX intermediate files
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class,*.pyc            " Byte code and compiled object files
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp          " Binary images
set wildignore+=*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg " Multimedia files
set wildignore+=*.mp3,*.oga,*.ogg,*.wav,*.flac                                  " Audio files
set wildignore+=*.eot,*.otf,*.ttf,*.woff                                        " Fonts
set wildignore+=*.doc,*.pdf,*.cbr,*.cbz                                         " Document files
set wildignore+=*.swp,.lock,.DS_Store,._*,*~                                    " Misc files

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

" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Center screen
nmap <space> zz

" Ignore case when searching
set ignorecase
set smartcase
set ttyfast

" Set backspace
set backspace=indent,start,eol

" Highlight search matches
set hlsearch

" Incremental search as characters are typed
set incsearch

" Expand tabs to spaces
set expandtab

set nrformats-=octal
set shiftround

" Time out on keycodes but not mappings.
set notimeout
set ttimeout
set ttimeoutlen=10

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
set textwidth=79
set formatoptions=qrn1

set complete-=i
set complete=.,w,b,u,t
set completeopt=longest,menuone

set showmatch
set smarttab

if !empty(&viminfo)
	set viminfo^=!
endif

" Split vertical windows right
set splitright

" Split horizontal windows below
set splitbelow

" When vimrc is edited, reload it
augroup cfg
    au!
    au! BufWritePost $VIMRC source %
augroup END

" Set default shell
set shell=$SHELL

" Allow saving of files when forgetting to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

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
nnoremap <leader>s :setlocal spell! spell?<CR>

" Use system clipboard
set clipboard=unnamedplus

" Fast reload vimrc
map <leader>vi :so $MYVIMRC<CR>

set nocursorcolumn
set nocursorline

syntax sync minlines=256
set synmaxcol=300
set re=1
