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

" Automatic installation of vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"PLUGINS
call plug#begin('~/.vim/bundle')
Plug 'terryma/vim-multiple-cursors'
Plug 'lilydjwg/colorizer'
Plug 'jiangmiao/auto-pairs'
Plug 'Exafunction/codeium.vim'
Plug 'alvan/vim-closetag'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'python-mode/python-mode'
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
call plug#end()

let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

let g:codeium_enabled = v:true

" multi-cursor mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = '<C-n>'
let g:multi_cursor_select_all_key      = '<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Color settings
let g:solarized_termcolors=256
set t_Co=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
set background=dark

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
  set nocompatible
silent! endwhile

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=200         " keep 200 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set ttimeout            " time out for key codes
set ttimeoutlen=100     " wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor. Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

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

" Paste to system clipboard
set clipboard=unnamedplus

"settings for WildMenu
set wildmenu               " display completion matches in a status lines
set wildmode=longest:list,full
:set guioptions+=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar
set shortmess=I "disable intro messages

let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <S-h> :call ToggleHiddenAll()<CR>

" KEYBINDINGS
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

" Bash completion
function MakeCommandCompletion(ArgLead, CmdLine, CursorPos)
    let l:words = split(a:CmdLine)
    let l:words[0] = 'make'
    let l:command = join(l:words)
    return bash#complete(l:command)
endfunction
:command -nargs=* -complete=customlist,MakeCommandCompletion Make make <args>

" configure Vim so that it sets the working directory to the current file's directory
autocmd BufEnter * lcd %:p:h

" Disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
if &term =~ '256color'
    set t_ut=
endif

autocmd BufEnter * :syntax sync fromstart

" SETTINGS FOR VIM_CLOSETAG

" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xml,*.php'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml,xml,php'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1

" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'

" Setting folding method to 'indent'
:setlocal foldmethod=manual

" Map shortcut to toggle fold/unfold
map f za
map F zf
map T :term

inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" fuzzy finder
fu! Fuzzy()
    enew
    read !find -type f
    cnoremap <buffer> / \/
    nnoremap <buffer> <cr> gf:bd! #<cr>
endf

" Settings for pymode
let g:pymode = 1
let g:pymode_warnings = 1
let g:pymode_trim_whitespaces = 1
let g:pymode_options_max_line_length = 79
let g:pymode_options_colorcolumn = 1
let g:pymode_indent = 1
let g:pymode_lint = 1
let g:pymode_lint_on_write = 1
let g:pymode_lint_message = 1
let g:pymode_lint_checkers = ['pyflakes', 'pycodestyle', 'mccabe', 'pep257', 'pylint', 'pyflake8']
let g:pymode_lint_signs = 1

" show git branch
fun! GitBranch(file)
    let l:dir = fnamemodify(system('readlink -f ' . a:file), ':h')
    let l:cmd = 'git -C ' . l:dir . ' branch --show-current 2>/dev/null'
    let b:git_current_branch = trim(system(l:cmd))
endfun

augroup GitBranch
    autocmd!
    autocmd BufEnter,ShellCmdPost,FileChangedShellPost * call GitBranch(expand('%'))
augroup END

set rulerformat=%32(%=%{b:git_current_branch}%=%8l,%-6(%c%V%)%=%4p%%%)

" Autodetect file changes when written and git commit
function! AutoGit()
  let file_name = expand('%')
  let choice = inputdialog('Changes detected in ' . file_name . '. Do you want to add the file to the repository? ')
  if choice == 'y' || choice == 'Y' || choice == 'yes' || choice == 'Yes' || choice == 'YES'
    execute ':!git pull && git add %'
    let additional_comments = inputdialog('Add additional comments (leave empty to skip): ')
    if !empty(additional_comments)
      let commit_message = additional_comments
      let escaped_commit_message = substitute(commit_message, '"', '\"', 'g')
      execute ':!git commit -m """' . escaped_commit_message . '"""'
      let push_choice = inputdialog('Commit successful. Do you want to push the changes? ')
      if push_choice == 'Yes' || push_choice == 'yes' || push_choice == 'y' || push_choice == 'Y' || push_choice == 'YES'
        execute ':!git push'
      endif
    endif
  elseif choice == 'n' || choice == 'N' || choice == 'no' || choice == 'No' || choice == 'NO'
    return
  endif
endfunction

autocmd BufWritePost * call AutoGit()

map <C-g> :call ToggleAutoGit()<CR>

let g:detect_line_changes_enabled = 1

function! ToggleAutoGit()
  if g:detect_line_changes_enabled
    autocmd! BufWritePost *
    let g:detect_line_changes_enabled = 0
    echo "AutoGit disabled"
  else
    autocmd BufWritePost * call AutoGit()
    let g:detect_line_changes_enabled = 1
    echo "AutoGit enabled"
  endif
endfunction

" Mappings for markdown-preview
let vim_markdown_preview_hotkey='<C-m>'

" Wayland shortcuts to yank and paste to the system clipboard
nnoremap <C-p> :call setreg('"', system('wl-paste'))<CR>p
xnoremap Y y:call system('wl-copy', getreg('"'))<CR>
