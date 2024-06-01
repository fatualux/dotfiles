map <C-f> :Explore<CR>
map <C-s> :split <CR>
map <C-t> :tabnew <CR>
map <C-w> :tabclose <CR>
map <Tab> :tabnext <CR>
map <C-q> :wq <CR>
map <C-d> :NextColorScheme <CR>
" enable/disable CodeiumCompletion
map <C-x> :Codeium Enable <CR>
map <C-z> :Codeium Disable <CR>
" Control+a to select all.
map <C-a> <esc>ggVG<CR>
" map C-u to Ack + current word under cursor  + case insensitive + current dir
" Prefer `ag` over `rg`.
let g:FerretExecutable='git grep,ag,grep'
" search current object under the cursor
nmap <C-u> :Ack <C-R><C-W><CR>
