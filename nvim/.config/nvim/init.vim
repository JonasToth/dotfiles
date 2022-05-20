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

" Create a floating window for interface documentation instead of a
" preview-window.
let g:LanguageClient_hoverPreview = "Auto"
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_diagnosticsList = "Location"
let g:LanguageClient_hasSnippetSupport = 1

" Fuzzy Matching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Shellcheck plugin
Plug 'koalaman/shellcheck'
" }}}

" Code Completion engine and snippets {{{
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" }}}

" Color schemes {{{
Plug 'NLKNguyen/papercolor-theme'
" Plug 'dikiaap/minimalist'
" Plug 'morhetz/gruvbox'
" let g:gruvbox_contrast_dark = 'medium'
" }}}

" Multiple Languages for Highlighting {{{
Plug 'sheerun/vim-polyglot'
" }}}

" better folding, cause vim reks sometimes {{{
Plug 'tmhedberg/SimpylFold'
" }}}

" Tabularize Text {{{
Plug 'godlygeek/tabular'
" }}}

" Dockerfiles {{{
Plug 'ekalinin/Dockerfile.vim'
" }}}

" rustlang support {{{
Plug 'rust-lang/rust.vim'
" }}}

" CMake plugin {{{
Plug 'pboettch/vim-cmake-syntax'
" }}}

" ION Shell support {{{
Plug 'vmchale/ion-vim'
" }}}

" Gentoo Ebuild Plugin {{{
Plug 'gentoo/gentoo-syntax'
" }}}

" PlantUML Syntax {{{
Plug 'aklt/plantuml-syntax'
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
" Completions through those markers do not work well with LSP snippets for
" completions.
" \ 'candidate_marks': ['A', 'S', 'D', 'F', 'G'],

" Autocompletion from LSP can provide snippets for all the arguments.
" It does not work as desired, so just make it usable for now without the
" snippets.
let g:neosnippet#enable_complete_done = 1
let g:neosnippet#enable_completed_snippet = 0
" autocmd CompleteDone * call neosnippet#complete_done()

" Make the first 5 possible completions selectable with the left hand.
" Conflicts with snippets from the language server for completions.
" inoremap <expr>A   pumvisible() ? deoplete#insert_candidate(0) : 'A'
" inoremap <expr>S   pumvisible() ? deoplete#insert_candidate(1) : 'S'
" inoremap <expr>D   pumvisible() ? deoplete#insert_candidate(2) : 'D'
" inoremap <expr>F   pumvisible() ? deoplete#insert_candidate(3) : 'F'
" inoremap <expr>G   pumvisible() ? deoplete#insert_candidate(4) : 'G'

" Dont show the preview window during auto completions.
set completeopt-=preview

" Snippet mappings
imap <C-h> <Plug>(neosnippet_expand_or_jump)
smap <C-h> <Plug>(neosnippet_expand_or_jump)
xmap <C-h> <Plug>(neosnippet_expand_target)

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

" Color Scheme Configuration {{{
syntax enable
colorscheme PaperColor
" colorscheme minimalist
" colorscheme gruvbox
set background=dark
" colorscheme vombatidae
set t_Co=256
" let g:solarized_termcolors=256
" fix screen background color issue
set t_ut=

" Write the status line only if there at least 2 windows
set laststatus=1
set noshowmode
set noshowcmd
set noruler

" Put the list of buffers in the status-line (airline)
let g:bufferline_echo = 1
" Show the number of the buffer for each buffer
let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
" let g:airline_section_c = ''
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#branch#enabled = 1 " enable branch writeout
let g:airline#extensions#branch#displayed_head_limit = 15
let g:airline#extensions#whitespace#enabled = 0 " we dont want to see whitesace information
let g:airline#extensions#searchcount#enabled = 1
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

" move cursor right in insert mode
" inoremap <C-k> <up>
" inoremap <C-j> <down>
" inoremap <C-h> <left>
" Keep this mapping because snippet-completion does not work smooth enough to
" jump after a completed function. This mapping allows fast moving to the
" right to add the semicolon.
inoremap <C-l> <right>

" move lines with <Alt-j> and <Alt-k>, even if visually selected
" https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines
nnoremap <C-A-j> :m .+1<CR>==
nnoremap <C-A-k> :m .-2<CR>==
inoremap <C-A-j> <Esc>:m .+1<CR>==gi
inoremap <C-A-k> <Esc>:m .-2<CR>==gi
vnoremap <C-A-j> :m '>+1<CR>gv=gv
vnoremap <C-A-k> :m '<-2<CR>gv=gv

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
