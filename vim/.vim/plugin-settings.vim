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
  let g:python_host_prog = "$HOME/.pyenv/versions/neovim2/bin/python"
  let g:python3_host_prog = "$HOME/.pyenv/versions/neovim3/bin/python3"
  let g:deoplete#enable_ignore_case = 1
end

" Omnifuncs
augroup omnifuncs
  au!
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType perl setlocal omnifunc=perlcomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup end

let b:vcm_tab_complete = 'omni'
set omnifunc=syntaxcomplete#Complete

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
" Use ^{h,j} to move lines
let g:move_key_modifier = 'A'               

" Haskell
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell set softtabstop=4
autocmd FileType haskell set tabstop=4
autocmd FileType haskell set shiftwidth=4
autocmd FileType haskell set shiftround

" Vim Plug options
let g:plug_timeout = 360
let g:plug_retries = 5

" Disable folding for JSON
let g:vim_json_syntax_conceal = 0

" Rainbow
let g:rainbow_active = 1

" Vim-autoformat
noremap <F5> :Autoformat<CR>
