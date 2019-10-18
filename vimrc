"== Initializations and Behaviour ========================
" Be improved, not vi compatible
" (should come before anything else)
set nocompatible

" To prevent autocommands to appear more than once,
" remove ALL autocommands for the current group before
" defining any autocommands.
autocmd!

" Set <Leader> to something easier to type than '\' like <space>, comma (,)
" or underscore (_)
let mapleader = " "

" Enable backspacing over linebreaks, autoindents etc.
set backspace=2

" Enable mouse only in normal mode
" (makes resizing windows with mouse possible)
set mouse=n

" Set path for file/library search
set path=.,**,/usr/include/**,/usr/local/include/**

" By default, Vim uses cpp filetype for .h files. Make it use c.doxygen
" (c for filetype and doxygen subtype for doxygen documentation highlighting)
augroup cHeaderFiles
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END

" Do not use 'options' and 'globals' in sessionoptions
set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize

" Make a buffer hidden when abandoned. Think twice when using !qa for example.
set hidden

" Do not redraw screen while executing macros, registers etc.
set lazyredraw

" Netrw file browser settings
let g:netrw_banner=0                " disable banner
"let g:netrw_browse_split=4          " open in prior window
"let g:netrw_altv=1                  " open splits to the right
let g:netrw_liststyle=3             " tree view
let g:netrw_usetab=1                " enable <C-Tab> Shrink/Expand
let g:netrw_wiw=2                   " window width when shrinked
let g:netrw_list_hide='.*\.sw.$'    " hiding list (hide vim swap files etc.)

" add node_modules/.bin to $PATH if exists
" (search from current dir upwards)
let s:localnpmbinpath = finddir("node_modules/.bin", ";")
if s:localnpmbinpath !=# ''
    let $PATH = s:localnpmbinpath . ":" . $PATH
endif
unlet s:localnpmbinpath

"== Vundle Plugin Manager Setup ==========================
let s:vundle_path = $HOME . "/.vim/bundle/Vundle.vim"

"---- Function MyInstallVundle ------------------------
function! MyInstallVundle()
    let l:v_autoload_path = s:vundle_path .  "/autoload/vundle.vim"
    if filereadable(l:v_autoload_path)
        return 1    " installed: true (1)
    endif

    if !isdirectory(s:vundle_path)
        silent execute "!mkdir -p " . s:vundle_path
        if v:shell_error !=# 0
            echo "Error: Vundle installation FAILED! Cannot create " . s:vundle_path
            return  " installed: false (0)
        endif
    endif

    echo "Installing Vundle..."
    let l:vundle_repo_url = "https://github.com/VundleVim/Vundle.vim"
    let l:vundle_git_cmd =  "!git clone " . l:vundle_repo_url . " "
    let l:vundle_git_cmd .= s:vundle_path
    silent execute l:vundle_git_cmd
    if v:shell_error !=# 0
        echo "Error: Vundle installation FAILED!"
        return      " installed: false (0)
    endif
    echo "Vundle install successful"
    return 1    " installed: true (1)
endfunction

"---- Setup ------------------------------------------------
let s:vundle_installed = MyInstallVundle()
if s:vundle_installed
    "set nocompatible              " be iMproved, required (already set)
    filetype off                  " required

    " set the runtime path to include Vundle and initialize
    "set rtp+=~/.vim/bundle/Vundle.vim
    let &rtp .= "," . s:vundle_path
    call vundle#begin()

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    ">>> PUT PLUGINS TO INSTALL AFTER THIS >>>

    " Solarized color scheme
    Plugin 'altercation/vim-colors-solarized'

    " Zenburn color scheme
    Plugin 'jnurmine/Zenburn'

    " Lean and mean status/tabline for vim that's light as air
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'

    " Search and load local vimrc files (asks before loading for security)
    Plugin 'embear/vim-localvimrc'

    if "development" ==# $ENVIRONMENT
        " vim-fugitive Git wrapper
        Plugin 'tpope/vim-fugitive'

        " YouCompleteMe auto complete plugin for C
        Plugin 'Valloric/YouCompleteMe'

        " c.vim plugin syntax highlighting,
        " inserting code snippets and comments
        " mainly for C family languages
        Plugin 'c.vim'

        " Syntax highlighting, file detection and more for rust files
        Plugin 'rust-lang/rust.vim'

        " Go language support
        Plugin 'fatih/vim-go'

        " Nim language support
        Plugin 'zah/nim.vim'

        " Asynchronous lint engine
        Plugin 'w0rp/ale'

        " Javascript syntax highlighting
        Plugin 'pangloss/vim-javascript'

        " JSX syntax support
        Plugin 'mxw/vim-jsx'

        " JSON improved syntax support
        Plugin 'leshill/vim-json'

        " Code formatter (uses installed formatters like prettier)
        Plugin 'sbdchd/neoformat'
    else " If $ENVIRONMENT is NOT 'development'
        "TabNine auto complete plugin for ALL languages
        Plugin 'zxqfl/tabnine-vim'
    endif

    "<<< PUT PLUGINS TO INSTALL BEFORE THIS <<<

    " All of your Plugins must be added before the following line
    call vundle#end()            " required

    filetype plugin indent on    " required
    " To ignore plugin indent changes, instead use:
    "filetype plugin on
    "
    " see :h vundle for more details or wiki for FAQ
endif

"== Plugins setup ========================================
"---- YouCompleteMe settings -------------------------------
" Set the global .ycm_extra_conf.py file location
let g:ycm_global_ycm_extra_conf="~/.vim/ycm_extra_conf.py"

" Path to Rust source for Rust semantic completion
" (if not installed with rustup to it's default location)
"let g:ycm_rust_src_path="~/software/rust-1.12/src"

" Use python3
let g:ycm_server_python_interpreter = 'python3'

" Python executable name that will be searched in PATH for
" semantic completion using Jedi for Python 2 or 3
let g:ycm_python_binary_path = 'python3'

" Autoclose preview window after leaving the insert mode
"let g:ycm_autoclose_preview_window_after_insertion=1

" Always populate vim's location list with diagnostics
let g:ycm_always_populate_location_list = 1

" Add <Enter> to the keys that selects a completion from the list
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']

"---- c.vim settings ---------------------------------------
" change leader from '\' to something easier to type
let g:C_MapLeader = ','

"---- solarized settings -----------------------------------
" use 256 colors instead of 16
" (if not using Vim terminal profile)
"let g:solarized_termcolors=256

"---- vim-javascript settings ------------------------------
" add support for Flow and its types
let g:javascript_plugin_flow = 1

"---- vim-jsx settings -------------------------------------
" vim-jsx: do not require .jsx extension
let g:jsx_ext_required = 0

"---- ale async linting engine settings --------------------
" uncomment the following lines to lint only when saved
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'

let g:ale_completion_enabled = 0
let g:ale_echo_msg_error_str = 'ALE Error'
let g:ale_echo_msg_info_str = 'ALE Info'
let g:ale_echo_msg_warning_str = 'ALE Warning'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_echo_delay = 500 " Default is 10 ms

" Disable for c. Let YouCompleteMe do the linting
let g:ale_linters = {'c': [], 'cpp': []}

"---- neoformat code formatter settings --------------------
" apply style to javascript files when saved
"augroup neoformatAutocmds
"    " First, clear the group then define autocmds
"    autocmd!
"    autocmd BufWritePre *.js Neoformat
"augroup END

" use formatprg to be able to set 'prettier' options
" see also 'prettier settings'
let g:neoformat_try_formatprg = 1

"---- prettier settings ------------------------------------
" set formatprg with prettier options
augroup prettierAutocmds
    autocmd!
    autocmd FileType javascript setlocal
            \ formatprg=prettier\ --single-quote\ --trailing-comma\ es5
augroup END

"---- vim-airline settings -----------------------------------
"
" Previous theme was 'dark'. Other alternatives I may try:
" 'deus', 'distinguished', 'solarized', 'hybrid', 'fairyfloss'.
let g:airline_theme = 'distinguished'

" YouCompleteMe diagnostics integration (error/warninig count)
let g:airline#extensions#ycm#enabled = 1

"---- vim-localvimrc settings --------------------------------
" Do not source local vimrc file in sandbox (mainly to be able to set makeprg)
let g:localvimrc_sandbox = 0

"---- nim.vim settings ---------------------------------------
fun! JumpToDef()
    if exists("*GotoDefinition_" . &filetype)
        call GotoDefinition_{&filetype}()
    else
        exe "norm! \<C-]>"
    endif
endf

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
"ino <M-g> <esc>:call JumpToDef()<cr>i

"== User Interface =======================================
" Highlight cursor line
set cursorline

" Show line, column info and % in file
set ruler

" Display file tab-completions in a menu
set wildmenu

" Show a window with possible matches as well as wildmenu
set wildmode=list:full

" Files, extensions to ignore
set wildignore+=.hg,.git,.svn " Version Controls"
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg "Binary Imgs"
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "Compiled Object files"
set wildignore+=*.sw? "Vim swap files"
set wildignore+=*.pyc "Python Object codes"

" Always keep a few lines above and below the cursor for context
set scrolloff=3 " keep 3 lines

" Always display the bottom status line. Also needed for airline plugin
set laststatus=2

" Always display the tabs even for a single tab
set showtabline=2

" Show (partial) commands in the last line (at the right)
set showcmd

" Highlight column to mark the max. width you want to have for wrapping
" Just a visual clue to show how much space left
set colorcolumn=80
highlight ColorColumn ctermbg=240

" Highlight unnecessary whitespace
highlight default TrailingSpace ctermbg=3
augroup HighlightTrailingSpace
    autocmd!
    autocmd BufEnter,BufNewFile,BufRead,ColorScheme *.*
                \ match TrailingSpace /\s\+\_$/ |
                \ highlight TrailingSpace ctermbg=3
augroup END

" Display line numbers
set number relativenumber

"---- Syntax highlighting and colors -----------------------
let s:sol_file = $HOME . "/.vim/bundle/vim-colors-solarized/colors/solarized.vim"
let s:sol_installed = filereadable(s:sol_file)

if has('gui_running')
  " GUI mode settings (gvim)

  syntax enable

  if $VIMCOLORSCHEME !=# ""
      colorscheme $VIMCOLORSCHEME
  elseif s:sol_installed && s:vundle_installed
      " Use Solarized color scheme in GUI mode (gvim).
      " Requires Solarized color scheme plugin.
      colorscheme solarized
  endif

  set background=dark
else
" Terminal mode settings

  syntax enable
  if $VIMCOLORSCHEME !=# ""
      colorscheme $VIMCOLORSCHEME
  elseif s:sol_installed && s:vundle_installed
      " Use Solarized color scheme
      " Requires Solarized color scheme plugin.
      colorscheme solarized
  endif

  set background=dark

  "set background=light
endif

"---- Folding ----------------------------------------------
set foldcolumn=0    " default is 0
set foldnestmax=5   " default is 20
set foldtext=MyFoldText()
hi Folded term=NONE cterm=NONE ctermbg=NONE gui=NONE
let &fillchars="vert:|,fold: " " default is vert:|,fold:-

augroup autoFoldSyntax
    autocmd!
    autocmd FileType javascript "do not use foldmethod=syntax for js. Too slow
        \ setlocal foldmethod=indent foldlevel=1 foldcolumn=3
augroup END

function! MyFoldText()
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    if strchars(foldchar) < 1
        let foldchar = ' '
    endif

    let leftcolwidth = &foldcolumn
    if &number || &relativenumber
        let leftcolwidth += &numberwidth
    endif

    let availablewidth = winwidth(0) - leftcolwidth
    if availablewidth > 95
        let availablewidth = 95
    endif

    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '(' . lines_count . ' lines) '

    let line = getline(v:foldstart)
    let linepre = '+' . repeat('-', v:foldlevel * 2) . ' '

    let linepost= ' ' . lines_count_text
    let foldtextlength = strdisplaywidth(linepre . line . linepost)

    let widthdiff = availablewidth - foldtextlength

    if widthdiff < 1
        return strpart(linepre . line . linepost, 0, availablewidth - 1)
    endif

    return linepre . line . repeat(foldchar, widthdiff) . linepost
endfunction

"== Key Bindings and mappings ============================
" Set timeout in milliseconds (default = 1000). Effects mappings
set timeoutlen=800

" use jk for Escape in Insert mode
inoremap jk <Esc>
" DO NOT try to map something for inserting a line above/below
" without entering the Insert mode. Use ojj or Ojj since jj is
" mapped to <Esc>

" use hjkl with <leader> key to move between windows in Normal mode
nnoremap <leader>h <C-W>h
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l

" use HJKL with <leader> key to move windows in Normal mode
nnoremap <leader>H <C-W>H
nnoremap <leader>J <C-W>J
nnoremap <leader>K <C-W>K
nnoremap <leader>L <C-W>L

" In normal mode, use ")" for "Ctrl + ]"
nnoremap ) <C-]>

" Surround with " in normal mode
nnoremap Ş" ciW""<Esc>P
nnoremap ş" ciw""<Esc>P

" Surround with ' in normal mode
nnoremap Ş' ciW''<Esc>P
nnoremap ş' ciw''<Esc>P

" Edit my .vimrc file in new tab
nnoremap <leader>ev :tabnew $MYVIMRC<cr>

" Source my .vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>

" In insert mode, convert current WORD (WORD before cursor) to uppercase
inoremap ,u <esc>gUiW`]a

" In normal mode, convert WORD before cursor to uppercase
nnoremap ,U gUiW

" In normal mode, increment the value under cursor (changing from <C-A>
" because tmux uses it.
nnoremap <C-B> <C-A>

" In norma mode, shrink/expand netrw explorer window
" (g:netrw_usetab must be set)
nmap <unique> <F2> <Plug>NetrwShrink

" In normal mode, open/close netrw Left Explore window
nmap <unique> <F3> :32Lexplore<CR>

"== Coding Style and Formatting ==========================
" General tab and indentation rules
set tabstop=4   " default is 8 and too much for my taste
set softtabstop=4
set shiftwidth=4
set expandtab

" Indentation rules for html, javascript etc.
augroup smallIndentation
    autocmd!
    autocmd FileType javascript,html,sh,yaml setlocal
                \ tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

