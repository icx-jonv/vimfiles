set nocompatible
call pathogen#infect()
set guifont=Consolas:h11:cANSI
set guioptions-=T " remove the toolbar
set visualbell " stop it from beeping every time you press the wrong key.

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

set shiftwidth=4
set tabstop=4
set softtabstop=4
" expand the tab to spaces
set expandtab
" keep x number of lines above/below cursor while scrolling
set so=4
" display the line numbers
set number
set autoindent
" Set nowrap
set nowrap
" Set searches to ignore case by default
set ic
" set window minimum width so if you use ^W| unfocused windows won't crunch
" too small
set winminwidth=10
" setting scroll to 1 allows the <C-D> and <C-U> keys to scroll one line at a
" time.
noremap <c-d> :set scroll=1<cr><c-d>
noremap <c-u> :set scroll=1<cr><c-u>
" Control J and Control K select left and right tabs
noremap <c-j> :tabp<cr>
noremap <c-k> :tabn<cr>
" remap the cursor move keys to easily move from top to bottom to middle of
" the screen
nnoremap <c-h> H
nnoremap <c-l> L
nnoremap <c-m> M
" remap H and L to go to the soft beginning of the line, or end of the line
noremap H ^
noremap L $
" make Y act like C and D
nnoremap Y y$

" tab completion! :) thanks Marco!
"function! InsertTabWrapper(direction)
      "let col = col('.') - 1
      "if !col || getline('.')[col - 1] !~ '\k'
          "return "\<tab>"
      "elseif "backward" == a:direction
          "return "\<c-p>"
      "else
          "return "\<c-n>"
      "endif
"endfunction

"inoremap <tab> <c-r>=InsertTabWrapper("forward")<cr>
"inoremap <s-tab> <c-r>=InsertTabWrapper("backward")<cr>

"let g:CommandTMaxFiles=50000
"let g:CommandTMaxDepth=9

syntax enable
if has ("gui_running")
    set background=dark
    let g:solarized_contrast="high"
    colorscheme solarized
" commented out, no longer want the session files left everywhere
"    augroup sessiongrp
"        au!
"        autocmd sessiongrp VimLeave * mksession! session.vim
"    augroup END
    " autocmd VimEnter * source session.vim

    " Sets the chars used in list mode.
    set listchars=tab:»·,trail:·
    " Set the window size on startup
    set lines=40 columns=120
else
    "terminal mode colors
    colorscheme koehler
    "set background=dark

    " solarized colorscheme settings
    "let g:solarized_termcolors=88
    "call togglebg#map("<C-F5>")

    " IMPORTANT: Uncomment one of the following lines to force
    " using 256 colors (or 88 colors) if your terminal supports it,
    " but does not automatically use 256 colors by default.
    set t_Co=256
    "set t_Co=88
    let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
endif

command SaveSession mksession! session.vim
command LoadSession source session.vim

inoremap jk <esc>
nnoremap <space> :nohls<CR>
"nnoremap <silent> <CR> :put=''<CR>
nnoremap j gj
nnoremap k gk

" set the default create mode to unix
set ffs=unix,dos,mac

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = {
        \ 'dir': '\.git$',
        \ 'file': '\.exe$\|\.swp$\|\~$',
        \ }

if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif
set history=50      " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch       " do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif
