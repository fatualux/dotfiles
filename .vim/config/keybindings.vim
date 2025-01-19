map <C-f> :Explore<CR>
map <C-s> :vsplit <CR>
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

" settings for Ale Linting for Python
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
map <C-k> :ALEFix <CR>
let g:ale_python_flake8_options = '--max-line-length=79'
map T :term

" Wayland shortcuts to yank and paste to the system clipboard
nnoremap <C-p> :call setreg('"', system('wl-paste'))<CR>p
xnoremap Y y:call system('wl-copy', getreg('"'))<CR>

