" Use Vim settings, rather than Vi settings.
if &compatible
  set nocompatible
endif

" want Vim to use these default values.
if exists('skip_defaults_vim')
  finish
endif

set autoindent
set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set directory-=.                                             " don't store swapfiles in the current directory
set encoding=utf-8
set expandtab                                                " expand tabs to spaces
set ignorecase                                               " case-insensitive search
set laststatus=2                                             " always show statusline
set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set shiftwidth=2                                             " normal mode indentation commands use 2 spaces
set smartcase                                                " case-sensitive search if any caps
set softtabstop=2                                            " insert mode tab and backspace use 2 spaces
set tabstop=8                                                " actual tabs occupy 8 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP

let g:codeium_enabled = v:true

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=200         " keep 200 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set ttimeout            " time out for key codes
set ttimeoutlen=100     " wait up to 100ms after Esc for special key

" Show a few lines of context around the cursor. Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Install vim-plug if it doesn't exist
function! InstallVimPlugIfNeeded()
    let autoload_dir = expand('~/.vim/autoload')
    let plug_vim_path = autoload_dir . '/plug.vim'

    " Check if vim-plug is installed
    if !filereadable(plug_vim_path)
        " If not installed, prompt user to install
        if has('unix')
            execute '!curl -fLo ' . plug_vim_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        elseif has('win32') || has('win64')
            execute '!powershell -command "iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni ' . $HOME . '/vimfiles/autoload/plug.vim -Force"'
        else
            echoerr 'Unsupported platform'
            return
        endif
        echom 'vim-plug installed successfully!'
    endif
endfunction

call InstallVimPlugIfNeeded()

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on
  set number

  " Highlight strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

  " Only do this part when compiled with support for autocommands.
  if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

      augroup END

      endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

" configure Vim so that it sets the working directory to the current file's directory
autocmd BufEnter * lcd %:p:h

autocmd BufEnter * :syntax sync fromstart

" Setting folding method to 'indent'
:setlocal foldmethod=manual

inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" fuzzy finder
fu! Fuzzy()
    enew
    read !find -type f
    cnoremap <buffer> / \/
    nnoremap <buffer> <cr> gf:bd! #<cr>
endf

" Mappings for markdown-preview
let vim_markdown_preview_hotkey='<C-m>'

" settings for Ale Linting for Python
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
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

