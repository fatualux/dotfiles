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
let g:ale_fixers = {
\   'python': [
\       'add_blank_lines_for_python_control_statements',
\       'autoflake',
\       'autoimport',
\       'autopep8',
\       'black',
\       'isort',
\       'pycln',
\       'pyflyby',
\       'reorder-python-imports',
\       'ruff',
\       'ruff_format',
\       'yapf'
\   ],
\   '*': [
\       'remove_trailing_lines',
\       'trim_whitespace'
\   ]
\}


