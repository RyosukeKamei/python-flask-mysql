setl expandtab
setl tabstop=4
setl shiftwidth=4
setl softtabstop=0
autocmd BufWritePre * :%s/\s\+$//ge
setlocal textwidth=80
