"---------------------------
" Start Neobundle Settings.
"---------------------------
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
  
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'nvie/vim-flake8'

call neobundle#end()
" Required:
filetype plugin indent on

NeoBundleCheck


"-------------------------
" End Neobundle Settings.
"-------------------------

syntax on
