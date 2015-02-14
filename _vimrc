set guioptions-=T " remove the toolbar
set visualbell " stop it from beeping every time you press the wrong key.

set shiftwidth=4
set tabstop=4
set softtabstop=4
" expand the tab to spaces
set expandtab
" Sets the chars used in list mode.
set listchars=tab:»·,trail:·
set list
" keep x number of lines above/below cursor while scrolling
set so=4
" display the line numbers
set number
set autoindent
" Set nowrap
set nowrap
" Set searches to ignore case by default
set ic
set smartcase
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
" make enter open the line below
nnoremap <cr> o
autocmd BufReadPost quickfix nnoremap <buffer> <cr> <cr>

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

nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>t :tabnew<cr>
nnoremap <leader>v :vnew<cr>
nnoremap <leader>l :TlistToggle<cr>

set backspace=indent,eol,start whichwrap+=<,>,[,]
set history=50      " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch       " do incremental searching

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" set the default create mode to unix
set ffs=unix,dos,mac

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Add system verilog as a verilog highlight
au BufNewFile,BufRead *.sv set filetype=verilog

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
        \ 'dir': '\.git$',
        \ 'file': '\.exe$\|\.swp$\|\~$',
        \ }
nnoremap <c-o> :CtrlPFunky<cr>

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

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
augroup end

" This lets you search for the following occurance of your current
" visual selection
" To use it, make a visual selection using v then then press *
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

set laststatus=2
let g:airline_powerline_fonts=1

" Command line completion
set wildmenu
set wildmode=list:longest,full

" Gundo
nnoremap <F5> :GundoToggle<CR>

let g:airline#extensions#hunks#enabled = 0

" Toggle relative line number ruler
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set nonumber
        set relativenumber
    endif
endfunc

nnoremap <F6> :call NumberToggle()<CR>

" Make cscope use the quickfix window
set cscopequickfix=s-,c-,d-,i-,t-,e-


"| register notes
"| from http://vimcasts.org/blog/2013/11/registers-the-good-the-bad-and-the-ugly-parts/
"|
"| operation   "" (default)    "0 (yank)   "1 (numbered)   "a (named)  "- (small delete)
"|    yw             X             X               -           -               -
"|    yy             X             X               -           -               -
"|    "ayw           X             -               -           X               -
"|    ""ayy          X             -               -           X               -
"|    dw             X             -               -           -               X
"|    dd             X             -               X           -               -
"|    "adw           X             -               X           X               -
"|    ""add          X             -               X           X               -
