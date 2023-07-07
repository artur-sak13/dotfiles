"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => IMPORT ALL THE THINGS!!!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let configs = [
\  'general',
\  'ui',
\  'plugins',
\  'plugin-settings'
\]
for file in configs
  let x = expand('~/.vim/'.file.'.vim')
  if filereadable(x)
    execute 'source' x
  endif
endfor
