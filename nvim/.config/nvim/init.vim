set nocompatible        " required
filetype off            " required

call plug#begin("~/.vim/plugged")

" Language Server Protocol {{{
" Copied from https://github.com/autozimu/LanguageClient-neovim
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" Automatically start language servers.
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'python': ['~/.local/bin/pyls'],
    \ 'cpp': ['clangd-13'],
    \ 'sh': ['bash-language-server', 'start'],
    \ }

" Fuzzy Matching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Shellcheck plugin
Plug 'koalaman/shellcheck'

" Code Completion engine
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" Show Function Signatures
" Plug 'Shougo/echodoc.vim'

" Color schemes {{{
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'dikiaap/minimalist'
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = 'medium'
" }}}

" Multiple Languages for Highlighting {{{
Plug 'sheerun/vim-polyglot'
" }}}

" Using Tab for everything {{{
Plug 'ervandew/supertab'
" }}}

" better folding, cause vim reks sometimes {{{
Plug 'tmhedberg/SimpylFold'
" }}}

" Dockerfiles {{{
Plug 'ekalinin/Dockerfile.vim'
" }}}

" rustlang support {{{
Plug 'rust-lang/rust.vim'
" }}}

" ION Shell support {{{
Plug 'vmchale/ion-vim'
" }}}

" Gentoo Ebuild Plugin {{{
Plug 'gentoo/gentoo-syntax'
" }}}

" syntax checking {{{
Plug 'scrooloose/syntastic'
" }}}

" PlantUML Syntax {{{
Plug 'aklt/plantuml-syntax'
" }}}

" snippets, better then snipmate {{{
" Track the engine.
" Snippets are separated from the engine. Add this if you want them:
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" }}}

" git integration {{{
Plug 'tpope/vim-fugitive'
" }}}

" better status bar {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'       " show list of all buffers
" }}}

" LaTeX Plugin {{{
Plug 'lervag/vimtex'
" }}}

" Kubernetes integration {{{
Plug 'rottencandy/vimkubectl'
" }}}

" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on  " required

" LaTeX Settings {{{
let g:tex_flavor = "latex"
" }}}

" AutoCompletion Engine {{{
call deoplete#custom#option({
            \ 'auto_complete_delay': 1,
            \ 'smart_case': v:true,
            \ 'camel_case': v:true, 
            \ })

set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

" Always draw the signcolumn. Warnings from clangd
set signcolumn=yes
set hidden

function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>le :call LanguageClient#textDocument_codeAction()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>

  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c,python,rust call SetLSPShortcuts()
augroup END
" }}}

" }}}
"
let g:UltiSnipsEditSplit="vertical"

" Color Scheme Configuration {{{
syntax enable
" colorscheme PaperColor
" colorscheme minimalist
colorscheme gruvbox
set background=dark
" colorscheme vombatidae
set t_Co=256
" let g:solarized_termcolors=256
" fix screen background color issue
set t_ut=

set laststatus=2
let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline_section_c = ''
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1 " enable branch writeout
let g:airline#extensions#branch#displayed_head_limit = 15
let g:airline#extensions#whitespace#enabled = 0 " we dont want to see whitesace information
" }}}

" Python {{{
au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set colorcolumn=80
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set autoindent
au BufNewFile,BufRead *.py set fileformat=unix
" }}}

" Markdown for .md files {{{
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
au BufNewFile,BufFilePre,BufRead *.md set foldmethod=marker
au BufNewFile,BufFilePre,BufRead *.md set foldlevel=0
au BufNewFile,BufFilePre,BufRead *.md set textwidth=79
" }}}

" Folding for CMakeLists {{{
au BufNewFile,BufFilePre,BufRead CMakeLists.txt set foldmethod=marker
" }}}

" syntastic recommended settings {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

map <C-D> :SyntasticCheck<CR>
imap <C-D> :SyntasticCheck<CR>

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Multiple checkers in one report
let g:syntastic_aggregate_errors = 1

" Make python checker passive, so it must be called directly with
" `:SyntasticCheck`
let g:syntastic_mode_map = {
            \ "mode": "active",
            \ "active_filetypes": ["rust", "sh"],
            \ "passive_filetypes": ["python", "cpp", "c"] }

" C++
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '--std=c++17'

" TODO Experimental
let g:syntastic_cpp_checkers = ['cpplint', 'gcc', 'clang-tidy-10.0']
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_clang_tidy_args = '-checks=*,-google-*'

" Python
let g:syntastic_python_checkers = ["flake8", "pylint", "pycodestyle"]
let g:syntastic_python_pylint_args = "--extension-pkg-whitelist=cv2"
" }}}

" Fortran Settings {{{
au BufNewFile,BufFilePre,BufRead *.f08 set shiftwidth=2
au BufNewFile,BufFilePre,BufRead *.f08 set tabstop=2

au BufNewFile,BufFilePre,BufRead *.f03 set shiftwidth=2
au BufNewFile,BufFilePre,BufRead *.f03 set tabstop=2

au BufNewFile,BufFilePre,BufRead *.f95 set shiftwidth=2
au BufNewFile,BufFilePre,BufRead *.f95 set tabstop=2

au BufNewFile,BufFilePre,BufRead *.f90 set shiftwidth=2
au BufNewFile,BufFilePre,BufRead *.f90 set tabstop=2

au BufNewFile,BufFilePre,BufRead *.f set shiftwidth=2
au BufNewFile,BufFilePre,BufRead *.f set tabstop=2
" }}}


" General usability settings {{{
" underline the current line
set cursorline

" show autocompletion menue for e.g. file name :e .vim<TAB> -> menu
set wildmenu

" more efficient redrawing
set lazyredraw

" match parantheses
set showmatch

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" turn off search highlight
nnoremap m :nohlsearch<CR>

" move cursor by visual lines
nnoremap j gj
nnoremap k gk

" leader = , for frequently used macros
let mapleader=","

" save session, reopen with vim -S
nnoremap <leader>s :mksession<CR>

" comment on end of a file to configure vim fpr this specific file
set modelines=1

" fold everything maximal
"set foldlevel=0

set encoding=utf-8
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Display leader in the bottom to see fast macro input
set showcmd

" https://jeffkreeftmeijer.com/vim-number/
set number relativenumber

set wrap
set linebreak
set nolist
set colorcolumn=101
" }}}

" vim:foldmethod=marker:foldlevel=0
