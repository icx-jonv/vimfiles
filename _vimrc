set nocompatible
if has ("gui_running")
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
else
    source /Program Files\ \(x86\)/Vim/vim73/vimrc_example.vim
    source /Program Files\ \(x86\)/Vim/vim73/mswin.vim
end
call pathogen#infect()
set guifont=Consolas:h11:cANSI
set guioptions-=T " remove the toolbar
set visualbell " stop it from beeping every time you press the wrong key.
behave mswin

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
" setting scroll to 1 allows the <C-D> and <C-U> keys to scroll one line at a
" time.
noremap <c-d> :set scroll=1<cr><c-d>
noremap <c-u> :set scroll=1<cr><c-u>
" Control J and Control K select left and right tabs
noremap <c-j> :tabp<cr>
noremap <c-k> :tabn<cr>

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

let Tlist_Ctags_Cmd="%HOMEDRIVE%%HOMEPATH%/bin/ctags.exe"

command SaveSession mksession! session.vim
command LoadSession source session.vim

inoremap jk <esc>
nnoremap <space> :nohls<CR>
"nnoremap <silent> <CR> :put=''<CR>
nnoremap j gj
nnoremap k gk
" make Y act like C and D
nnoremap Y y$
noremap H ^
noremap L $

let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = {
        \ 'dir': '\.git$',
        \ 'file': '\.exe$\|\.swp$\|\~$',
        \ }
