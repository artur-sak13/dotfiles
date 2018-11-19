"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2
let g:lightline = {
  \ 'colorscheme': 'darcula',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch',  'filename' ] ],
  \   'right': [ [ 'syntastic', 'lineinfo' ],
  \				 [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'modified': 'Modified',
  \   'readonly': 'Readonly',
  \   'gitbranch': 'GitBranch',
  \   'filename': 'FileName',
  \   'fileformat': 'FileFormat',
  \   'filetype': 'FileType',
  \   'fileencoding': 'Encoding',
  \   'mode': 'Mode',
  \ },
  \ 'component_expand': {
  \   'syntastic': 'SyntasticStatuslineFlag',
  \ },
  \ 'component_type': {
  \   'syntastic': 'error',
  \ },
  \ 'subseparator': { 'left': '|', 'right': '|' }
  \ }

function! Modified()
  return &filetype =~ 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : ''
endfunction

function! Readonly()
  return &readonly && &filetype !~# '\v(help|vimfiler|unite)' ? '× ' : ''
endfunction

function! GitBranch()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! FileFormat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! FileName()
  let l:name = expand('%:t')
  if l:name =~ 'NetrwTreeListing'
    return ''
  endif
  return ('' != Readonly() ? Readonly() : Modified()) .
        \ ('' != expand('%:t') ? expand('%:t') : '[none]') 
endfunction

function! FileType()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : '') : ''
endfunction

function! Encoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &enc : &enc) : ''
endfunction

function! Mode()
	return winwidth(0) > 30 ? lightline#mode() : ''
endfunction

function! s:syntastic()
	SyntasticCheck
	call lightline#update()
endfunction

"function! LintErrors() abort
"  let l:counts = ale#statusline#Count(bufnr(''))
"  return l:counts.total == 0 ? '' : printf('×%d', l:counts.total)
"endfunction
