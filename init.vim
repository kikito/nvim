" {{{ Plugins
call plug#begin('~/.config/nvim/plugins')
  Plug 'arakashic/nvim-colors-solarized'
  Plug 'neomake/neomake'
  Plug 'scrooloose/nerdcommenter'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-surround'
  Plug 'ctrlpvim/ctrlp.vim'

  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction
  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
call plug#end()
" }}}

" {{{ colorscheme/style options
syntax enable
set synmaxcol=100
set number      " Displays line numbers
set novisualbell
set errorbells
set scrolloff=3 " Show 3 extra lines when scrolling up/down
set cursorline  " Highlight the line where the cursor is
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1 " Changes cursor to a line on insert mode
set textwidth=80
set showbreak=↪
colorscheme solarized
set background=dark
set bg=dark
" }}}

" {{{ Neomake options
:highlight NeomakeSign guifg=Yellow guibg=#dc322f gui=bold
let g:neomake_warning_sign={'text': '⚠', 'texthl': 'NeomakeSign'}
let g:neomake_error_sign={'text': '✖', 'texthl': 'NeomakeSign'}
let g:neomake_open_list = 2
" }}}

" {{{ Misc UI settings
set encoding=utf-8
scriptencoding utf-8

" Be a bit faster when executing command-line shell stuff
set noshelltemp

" hide open buffers instead of closing them, when opening a new one with :e
set hidden

" Deactivate the PRESS ENTER OR TYPE COMMAND TO CONTINUE message
set shortmess=atI

" Allows copy-pasting from other apps
set clipboard=unnamed

" Add some space around the cursor when moving it near the borders of the screen
set sidescrolloff=1
" }}}


" {{{ nerdcommenter options
let g:NERDSpaceDelims = 1
" }}}

" {{{ vim-airline options
let g:airline_theme = 'solarized'
let g:airline_detected_modified = 1
let g:airline_powerline_fonts = 1
let g:airline_detect_iminsert = 0
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }
" By default vim only shows the status line after a split. Show it always
set laststatus=2
" }}}

" {{{ ctrlp options
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$',
    \ 'file': '\.exe$\|\.so$\|\.dll$' }
" Set delay to prevent extra search
let g:ctrlp_lazy_update = 100

" Do not clear filenames cache, to improve CtrlP startup
" You can manualy clear it by <F5>
let g:ctrlp_clear_cache_on_exit = 0

" Set no file limit
let g:ctrlp_max_files = 0

if executable("ag")
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
  let g:ctrlp_use_caching = 0 " Ag is fast enough to not needing caching
else
  let g:ctrlp_user_command = {
      \ 'types': {
          \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
          \ 2: ['.hg', 'hg --cwd %s locate -I .'],
      \ },
      \ 'fallback': 'find %s -type f'
  \ }
endif
" }}}

" {{{ deoplete options
let g:deoplete#enable_at_startup = 1
" }}}

" {{{ Key Settings

let g:mapleader=","              " set the <leader> key to comma

" Map ESC to jk
imap jk <ESC>
imap Jk <ESC>
imap JK <ESC>

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap J gj
nnoremap k gk
nnoremap K gk

" Capslock H and L are just stupid LOL
nnoremap H h
nnoremap L l

" Do not exit visual mode when shifting
vnoremap < <gv
vnoremap > >gv

" comma q quits and saves, comma w saves without warnings
nmap <leader>q :q!<CR>
nmap <leader>w :w!<CR>

" shift key fixes
cmap WQ wq
cmap wQ wq
cmap Q q
cmap Tabe tabe

" Split buffer vertically or horizontally: leader v, leader h
nnoremap <leader>v <C-w>v
nnoremap <leader>h <C-w>s
set splitbelow splitright

" Move between splits with leader-direction instead of c-w direction
nnoremap <C-J> <C-W>J
nnoremap <C-K> <C-W>K
nnoremap <C-L> <C-W>L
nnoremap <C-H> <C-W>H

" Do not overwrite the clipboard when deleting
nnoremap d "_d
vnoremap d "_d

" remap space bar to search
:nmap <Space> /

" deactivate 'Entering Ex mode' prompt
:map Q <Nop>
" }}}

" {{{ Folding settings
set foldmethod=syntax " Use syntax-provided folding when available
set foldlevel=99      " Folds are open by default
set foldlevelstart=99 " Folds are open by default (new way)
" }}}

" {{{ Whitespace settings
set nowrap                          " don't wrap lines
set tabstop=2                       " a tab is two spaces
set shiftwidth=2                    " an autoindent (with <<) is two spaces
set expandtab                       " use spaces, not tabs
set backspace=indent,eol,start      " backspace through everything in insert mode
set list                    " Show invisible characters using listchars
set listchars=""            " Reset the listchars
set listchars=tab:›\        " show tabs as lsaquos
set listchars+=trail:·      " show trailing spaces as dots
set listchars+=nbsp:·       " show trailing non-breaking-spaces as dots
set listchars+=extends:❯    " The character in the last column when the line continues right
set listchars+=precedes:❮   " The character in the first column when the line continues left
" }}}

" {{{ Search settings
set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter
set gdefault    " by default, replace globally (you can ommit /g at the end of a search-and-replace
" }}}

" {{{ Wildmenu settings
set wildmenu wildmode=longest:full
set wildignorecase
" Ignore these files when auto-completing with tab (for example when opening with :e)
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem          " general programming
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz                      " compressed files
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/* " vendor and sass
set wildignore+=*/node_modules/*
set wildignore+=*.swp,*~,._*
" }}}

" {{{ Matching closing character settings
set showmatch     " Display matching parent
set matchtime=3   " Time to display matching parent, in tens of second
" }}}

" {{{ Grep settings
if executable("ag")
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
endif

" The :G command is like :grep, but silent, and opens the quickfix window
" instead of the first matching result
command! -nargs=+ G execute 'silent grep! <args>' | copen 42 | redraw!

" Auto-adjust the quickfix window height
au FileType qf call AdjustWindowHeight(3, 10)
 function! AdjustWindowHeight(minheight, maxheight)
     let l = 1
     let n_lines = 0
     let w_width = winwidth(0)
     while l <= line('$')
         " number to float for division
         let l_len = strlen(getline(l)) + 0.0
         let line_width = l_len/w_width
         let n_lines += float2nr(ceil(line_width))
         let l += 1
     endw
     exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
 endfunction
" }}}

" {{{ Undo settings
set undofile                     " Save undo's after file closes
set undolevels=1000              " How many undos
set undoreload=10000             " number of lines to save for undo
set undodir=~/.config/nvim/_undo         " where to save undo histories
set backupdir=~/.config/nvim/_backup/    " where to put backup files.
set directory=~/.config/nvim/_swap/      " where to put swap files.
" }}}

" {{{ Autocommands
if has("autocmd")
  filetype plugin indent on           " allow for individual indentations per file type

  augroup WhiteSpace
    autocmd!

    " before writing a buffer, remove trailing spaces (respecting cursor position) when saving files
    autocmd BufWritePre * kz|:%s/\s\+$//e|'z
  augroup end

  augroup Cursor
    autocmd!

    " After opening, jump to last known cursor position unless it's invalid or in an event handler
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    " When entering a window, activate cursorline
    autocmd WinEnter * setlocal cursorline

    " When leaving a window, deactivate cursorline
    autocmd WinLeave * setlocal nocursorline
  augroup end

  augroup Golang
    autocmd!

    " Use tabs, and make them 4-spaces long
    autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4
    " reformat the file before each save
    autocmd FileType go autocmd BufWritePre <buffer> Fmt
  augroup end

  augroup Markdown
    autocmd!

    " Enable spell checking for markdown files
    autocmd BufRead *.md setlocal spell
    autocmd BufRead *.markdown setlocal spell
  augroup end

  augroup Mkdir
    autocmd!

    " before writing a buffer, if the current directory does not exist, create it
    autocmd BufWritePre *
      \ if !isdirectory(expand("<afile>:p:h")) |
      \   call mkdir(expand("<afile>:p:h"), "p") |
      \ endif
  augroup end

  augroup Neomake
    autocmd!

    autocmd BufWritePost * Neomake
    autocmd BufReadPost  * Neomake

  augroup end

endif
" }}}

