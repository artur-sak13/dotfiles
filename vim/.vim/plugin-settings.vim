"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use scriptencoding when multibyte char exists
scriptencoding utf-8

" NERDTree Configuration
map <leader>n :NERDTreeToggle<CR>

let NERDTreeShowHidden = 1
let NERDTreeWinSize    = 30
let NERDTreeQuitOnOpen = 1

let NERDTreeIgnore = ['\.vim$', '\~$', '\.git$']

" Ale Linting
" let g:ale_completion_enabled = 1
" let g:ale_sign_column_always = 1
" let g:ale_sign_error = '× '
" let g:ale_sign_warning = '> '
" highlight ALEErrorSign ctermbg=234 ctermfg=magenta

" DelimitMate
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 2
let g:delimitMate_smart_quotes = 1
let g:delimitMate_expand_inside_quotes = 0
let g:delimitMate_jump_expansion = 1
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'
" let g:delimitMate_matchpairs = "(:),[:],{:}"

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_aggregate_errors = 1

let g:terraform_completion_keys = 1
let g:terraform_registry_module_completion = 1

" Neomake
call neomake#configure#automake('nrwi', 500)

" Tabular
" Align equals with `<,>a`
if exists(':Tabularize')
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
  if has('mac')
    let g:python_host_prog = '/usr/local/bin/python2'
    let g:python3_host_prog = '/usr/local/bin/python3'
  else
    let g:python_host_prog = '/usr/bin/python2'
    let g:python3_host_prog = '/usr/bin/python3'
  endif
  
  let g:deoplete#enable_ignore_case = 1
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#ignore_sources = {}
  let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file', 'neosnippet']
  let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
  let g:deoplete#sources#go#align_class = 1
  " let g:deoplete#omni_patterns.terraform = '[^ *\t"{=$]\w*'

  call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy'])
  call deoplete#custom#source('_', 'converters', ['converter_remove_paren'])
  call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
endif

if has('autocmd')
    filetype plugin indent on
    " Omnifuncs
    augroup omnifuncs
        au!
        autocmd FileType text setlocal textwidth=78
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType perl setlocal omnifunc=perlcomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTag
        autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    augroup END
endif

if has('gui_running')
    set transparency=3
    set regexpengine=1
    syntax enable
endif

let b:vcm_tab_complete = 'omni'
set omnifunc=syntaxcomplete#Complete

augroup moved
    au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
augroup END

set completeopt=menuone,menu,longest,preview

augroup filetypedetect
    au BufNewFile,BufRead *.vim setlocal noet ts=4 sw=4 sts=4
    au BufNewFile,BufRead *.yml,*.yaml setlocal expandtab ts=2 sw=2
    au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
    au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
augroup END

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

" Vim Plug options
let g:plug_timeout = 360
let g:plug_retries = 5

" Disable folding for JSON
let g:vim_json_syntax_conceal = 0

" Rainbow
let g:rainbow_active = 1

" Vim-autoformat
noremap <F5> :Autoformat<CR>
