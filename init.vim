" {{{ Plugins
call plug#begin('~/.config/nvim/plugins')
  Plug 'ishan9299/nvim-solarized-lua'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'neomake/neomake'
  Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-surround'
  Plug 'alvan/vim-closetag'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim',
  Plug 'itchyny/lightline.vim',
  Plug 'editorconfig/editorconfig-vim'
  Plug 'rust-lang/rust.vim'
  Plug 'wagnerf42/vim-clippy'
  Plug 'Townk/vim-autoclose'
  Plug 'vitalk/vim-shebang'

  " Teal language support
  Plug 'teal-language/vim-teal'
  Plug 'dense-analysis/ale', { 'for': 'teal' }
  Plug 'tpope/vim-endwise', { 'for': 'teal' }

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Recommended updating the parsers on update
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
call plug#end()
" }}}

" {{{ colorscheme/style options
syntax enable
set nocp " not compatible with old vi
set backspace=indent,eol,start " normal backspace behaviour
let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " forces true color
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1 " Changes cursor to a line on insert mode
set termguicolors " Enables truecolor in neovim >= 0.1.5
set number        " Displays line numbers
set novisualbell  " No bell
set errorbells    " Really, no bell
set t_vb=         " Also, no bell
set scrolloff=3   " Show 3 extra lines when scrolling up/down
set cursorline    " Highlight the line where the cursor is
set showbreak=↪
colorscheme solarized
set background=dark
set bg=dark
set showcmd " show incomplete commands
" Make syntax errors in SCREAM
" (otherwise a missing comma in JSON is bold red vs regular red - not visible)
:highlight Error term=reverse cterm=bold ctermfg=7 ctermbg=1 guifg=White guibg=Red

" {{{ nvim-web-devicons
lua << EOF
require'nvim-web-devicons'.setup {
  default = true;
}
EOF
" }}}

" {{{ nvim-compe
set completeopt=menuone,noselect

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
" }}}

" {{{ rust.vim options
let g:rustfmt_autosave = 1
" }}}

" {{{ Neomake options
:highlight NeomakeSign guifg=Yellow guibg=#dc322f gui=bold
let g:neomake_warning_sign={'text': '•', 'texthl': 'NeomakeSign'}
let g:neomake_error_sign={'text': '!', 'texthl': 'NeomakeSign'}
" }}}

" {{{ vim-autoclose
" Don't interfere with vim-compte
let g:AutoClosePumvisible = {"ENTER": "<C-Y>", "ESC": "<ESC>"}
" }}}

" {{{ vim-shebang
" Highlight resty scripts as Lua
AddShebangPattern! lua ^#!.*/bin/env\s\+resty\>
" }}}


" {{{ Misc UI settings
set encoding=utf-8
scriptencoding utf-8

" Enable mouse in console mode
set mouse=a

" Be a bit faster when executing command-line shell stuff
set noshelltemp

" hide open buffers instead of closing them, when opening a new one with :e
set hidden

" Deactivate the PRESS ENTER OR TYPE COMMAND TO CONTINUE message
set shortmess=atI

" Allows copy-pasting from other apps
set clipboard^=unnamed

" Add some space around the cursor when moving it near the borders of the screen
set sidescrolloff=1

" Redraw the screen a bit less (helps when editing ruby files)
set lazyredraw

" Set space as the Leader key
let mapleader=" " " map leader to Space
" }}}


" {{{ nerdcommenter options
let g:NERDSpaceDelims = 1
" }}}

"{{{ lightline options
" Makes sure the status line is drawn in all buffers, not only the active one
set laststatus=2
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ],
      \             [ 'neomake' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightlineModified',
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'neomake': 'LightlineNeomake'
      \ },
      \ 'compopent_type': {
      \   'neomake': 'error'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }
function! LightlineModified()
  return &filetype =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? "\ue0a2" : ''
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? "\ue0a0".branch : ''
  endif
  return ''
endfunction

function LightlineNeomake()
  if !exists(':Neomake')
    return ''
  endif
  let counts = neomake#statusline#LoclistCounts()
  let warnings = get(counts, 'W', 0)
  let errors = get(counts, 'E', 0)
  if warnings == 0 && errors == 0
    return ''
  else
    let loclist = getloclist(0)
    if len(loclist) > 0
      let first = ' ['.loclist[0].lnum.']'
      if errors == 0
        return 'W:'.warnings.first
      else
        return 'E:'.errors.first
      endif
    endif
  endif
endfunction

function! LightlineFilename()
  let filename = expand('%')
  if len(filename) > 0
    let filename = len(filename) < winwidth(0) - 25 ? filename : pathshorten(filename)
  else
    let filename = '[No Name]'
  endif

  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ (&ft == 'fzf' ? 'FZF' : filename) .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

"}}}

" {{{ vim-closetag options
let g:closetag_filenames = "*.html,*.html.erb"
" }}}

" {{{ Key Settings

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

" ctrl q quits and saves, ctrl s saves, ctrl w saves without warnings
nnoremap <C-q> :q!<CR>
nnoremap <C-w> :w!<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-x> c<CR>

" shift key fixes
cmap WQ wq
cmap wQ wq

" Split buffer horizontally (ctrl t) and vertically (ctrl g)
nnoremap <C-g> <C-w>s
nnoremap <C-t> <C-w>v
set splitbelow splitright

" Move between splits with ctrl-direction instead of c-w + direction
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" Search text with ctrl-f
:nnoremap <C-f> /\v

" deactivate 'Entering Ex mode' prompt
:nnoremap Q <Nop>
" }}}

" {{{ Folding settings
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99      " Folds are open by default
set foldlevelstart=99 " Folds are open by default (new way)
let ruby_fold=0
let go_fold=0
let lua_fold=1
let javascript_fold=1
" }}}

" {{{ Whitespace settings
set nowrap                          " don't wrap lines
set tabstop=2                       " a tab is two spaces
set autoindent
set smartindent
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
set inccommand= " incremental everything
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
set matchtime=4   " Time to display matching parent, in tens of second
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

" {{{ Deoplete config
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 400

" Use tab instead of the default deoplete mapping
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" }}}

" {{{ FZF config
set rtp+=/usr/local/opt/fzf

" Show FZF when pressing ctrl-p
noremap <c-p> :FZF<CR>
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
" }}}
