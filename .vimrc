" =========== VARIABLES
let mapleader = ","
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

function! TmuxSharedYank()
  " Send the contents of the 't' register to a temporary file, invoke
  " copy to tmux using load-buffer, and then to xclip
  " FIXME for some reason, the 'tmux load-buffer -' form will hang
  " when used with 'system()' which takes a second argument as stdin.
  let tmpfile = tempname()
  call writefile(split(@t, '\n'), tmpfile, 'b')
  call system('tmux load-buffer '.shellescape(tmpfile).';tmux show-buffer')
  call delete(tmpfile)
endfunction

function! TmuxSharedPaste()
  " put tmux copy buffer into the t register, the mapping will handle
  " pasting into the buffer
  let @t = system('tmux show-buffer')
endfunction



" ========== PLUGIN
call plug#begin()

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-startify'
Plug 'Valloric/YouCompleteMe'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'ntpeters/vim-better-whitespace'
Plug 'wellle/targets.vim'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdcommenter'

Plug 'NLKNguyen/papercolor-theme'
Plug 'vim-airline/vim-airline-themes'

Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'kchmck/vim-coffee-script'
Plug 'ekalinin/Dockerfile.vim'
Plug 'sheerun/vim-haml'
Plug 'CH-DanReif/haproxy.vim'
Plug 'othree/html5.vim'
Plug 'elzr/vim-json'
Plug 'digitaltoad/vim-pug'
Plug 'vim-ruby/vim-ruby'
Plug 'cakebaker/scss-syntax.vim'
Plug 'posva/vim-vue'
Plug 'stephpy/vim-yaml'

call plug#end()



" =========== THEME
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 <https://github.com/neovim/neovim/pull/2198>
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 <https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162>
  "Based on Vim patch 7.4.1770 (`guicolors` option) <https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd>
  " <https://github.com/neovim/neovim/wiki/Following-HEAD#20160511>
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax enable
" set background=dark
set number
colorscheme PaperColor
set background=dark
filetype on
filetype plugin on
filetype indent on

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='distinguished'
let g:airline_powerline_fonts=1



" =========== KEY BINDING
map <C-n> :NERDTreeToggle<CR>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <C-p> :FZF<CR>
nnoremap <C-r> :History<CR>
nnoremap <C-f> :Ag<space>
nnoremap <C-y> :redo<CR>

nnoremap <F7> gg=G<C-o><C-o>
nmap <silent> // :nohlsearch<CR>

"inoremap <esc> <C-c>l
nnoremap H 0
nnoremap L $

vnoremap <silent> <esc>y "ty:call TmuxSharedYank()<cr>
nnoremap <silent> <esc>p :call TmuxSharedPaste()<cr>"tp
vnoremap <silent> <esc>p d:call TmuxSharedPaste()<cr>h"tp
set clipboard= " Use this or vim will automatically put deleted text into x11 selection('*' register) which breaks the above map

nnoremap <C-t>  :tabnew<CR>
inoremap <C-t>  <Esc>:tabnew<CR>



" ============ VISUAL
set splitbelow
set splitright
set statusline+=%F
set virtualedit=onemore
set nocompatible
set nowrap
set autoindent
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch
set linespace=0
set nu
set backspace=indent,eol,start
set cursorline

highlight clear LineNr
highlight clear SignColumn

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

let g:indentLine_enabled = 1
let g:indentLine_char = '|'

set timeoutlen=300
inoremap kj <Esc>l
inoremap jk <Esc>l



" ============ AUDIO
autocmd GUIEnter * set visualbell t_vb=




" ============ CODE CONVENTION
set tabstop=2 shiftwidth=2 expandtab
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set showbreak=···
