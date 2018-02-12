"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree Configuration
map <leader>n :NERDTreeToggle<CR>

let NERDTreeWinSize    = 30
let NERDTreeQuitOnOpen = 1

" Ale Linting
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '× '
let g:ale_sign_warning = '> '
highlight ALEErrorSign ctermbg=234 ctermfg=magenta

" DelimitMate
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 2
let delimitMate_jump_expansion = 1
let delimitMate_matchpairs = "(:),[:],{:}"

" Tabular
" Align equals with `<,>a`
if exists(":Tabularize")
    nmap <leader>a= :Tabularize /=<CR>
    vmap <leader>a= :Tabularize /=<CR>
    nmap <leader>a: :Tabularize /:<CR>
    vmap <leader>a: :Tabularize /:<CR>
endif

" Auto-align | delimited table borders while typing
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction

" Gundo
nnoremap <leader>gu :GundoToggle<CR>
let g:gundo_close_on_revert = 1

" Deoplete
if has('nvim')
  let g:python_host_prog = "/Users/Artur/.pyenv/versions/neovim2/bin/python"
  let g:python3_host_prog = "/Users/Artur/.pyenv/versions/neovim3/bin/python"
end

" Omnifuncs
augroup omnifuncs
  au!
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType perl setlocal omnifunc=perlcomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup end


let b:vcm_tab_complete = 'omni'
set omnifunc=syntaxcomplete#Complete

" Select completions with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Close preview when completion completes
augroup completionhide
  au!
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup end

" Enable Deoplete on startup, ignore case, and capture patterns
if has('nvim')
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_ignore_case = 1
  if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
  endif
  inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
endif

" Vim Airline
set timeoutlen=1000 ttimeoutlen=50
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = -1
let g:airline_theme='base16_spacemacs'

" Vim indent guides
let indent_guides_enable_on_vim_startup = 1

" Markdown
let g:vim_markdown_folding_disabled=1

" Gitgutter
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
let g:gitgutter_max_signs = 1500
let g:gitgutter_diff_args = '-w'

" Gitgutter color overrides
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green ctermbg=234
highlight GitGutterChange ctermfg=yellow ctermbg=234
highlight GitGutterDelete ctermfg=red ctermbg=234
highlight GitGutterChangeDelete ctermfg=red ctermbg=234

" Vim-Move
let g:move_key_modifier = 'A'               "Use ^{h,j} to move lines

" Haskell
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell set softtabstop=4
autocmd FileType haskell set tabstop=4
autocmd FileType haskell set shiftwidth=4
autocmd FileType haskell set shiftround

" Rust
let g:deoplete#sources#rust#racer_binary='/Users/Artur/.cargo/bin/racer'
let g:deoplete#sources#rust#show_duplicates=1

" Go
autocmd FileType go set shiftwidth=8
autocmd FileType go set tabstop=8
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Vim Plug options
let g:plug_timeout = 360
let g:plug_retries = 5

" Disable folding for JSON
let g:vim_json_syntax_conceal = 0

" Rainbow
let g:rainbow_active=1

" Vim-autoformat
noremap <F5> :Autoformat<CR>
