" vimrc
" Author: Zaiste! <oh@zaiste.net>
" Source: https://github.com/zaiste/vimified
"
" Have fun!
"

set nocompatible
filetype off

" Load external configuration before anything else {{{
if filereadable(expand("~/.vim/before.vimrc"))
  source ~/.vim/before.vimrc
endif
" }}}

let mapleader = ","
let maplocalleader = "\\"

" Local vimrc configuration {{{
let s:localrc = expand($HOME . '/.vim/local.vimrc')
if filereadable(s:localrc)
    exec ':so ' . s:localrc
endif
" }}}

" PACKAGE LIST {{{
" Use this variable inside your local configuration to declare 
" which package you would like to include
if ! exists('g:vimified_packages')
    let g:vimified_packages = ['general', 'fancy', 'os', 'coding', 'python', 'ruby', 'html', 'css', 'js', 'coffeescript', 'clojure', 'haskell', 'color', 'hex', 'pdf']
endif
" }}}

" VUNDLE {{{
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'mbadran/headlights'
" }}}

" PACKAGES {{{

" _. General {{{
if count(g:vimified_packages, 'general')
    Bundle "mileszs/ack.vim"
    nnoremap <leader>a :Ack!<space>

    Bundle 'matthias-guenther/hammer.vim' 
    nmap <leader>p :Hammer<cr>

    Bundle 'tsaleh/vim-align'
    Bundle 'tpope/vim-endwise'
    Bundle 'tpope/vim-repeat'
    Bundle 'tpope/vim-speeddating'
    Bundle 'tpope/vim-surround'
    Bundle 'tpope/vim-unimpaired'
    Bundle 'scrooloose/nerdtree' 
    nmap <C-u> :NERDTreeToggle<CR>
    " Disable the scrollbars (NERDTree)
    set guioptions-=r
    set guioptions-=L

    Bundle 'kana/vim-textobj-user'
    Bundle 'vim-scripts/YankRing.vim'
    let g:yankring_replace_n_pkey = '<leader>['
    let g:yankring_replace_n_nkey = '<leader>]'
    let g:yankring_history_dir = '~/.vim/tmp'
    nmap <leader>y :YRShow<cr>

    Bundle 'michaeljsmith/vim-indent-object'
    let g:indentobject_meaningful_indentation = ["haml", "sass", "python", "yaml", "markdown"]

    Bundle 'kien/ctrlp.vim'
    Bundle 'vim-scripts/scratch.vim'

    Bundle 'vim-scripts/bufexplorer.zip'

    "Bundle 'vim-scripts/Gundo'
    "nnoremap <F5> :GundoToggle<CR>
    "let g:gundo_preview_bottom=1
endif
" }}}

" _. Fancy {{{
if count(g:vimified_packages, 'fancy')
    Bundle 'Lokaltog/vim-powerline'
    let g:Powerline_symbols = 'fancy'
    let g:Powerline_cache_enabled = 1
endif
" }}}

" _. Utils {{{
if count(g:vimified_packages, 'utils')
    Bundle 'gregsexton/VimCalc'
endif
" }}}

" _. OS {{{
if count(g:vimified_packages, 'os')
    Bundle 'zaiste/tmux.vim'
    Bundle 'benmills/vimux' 
    map <Leader>rp :PromptVimTmuxCommand<CR>
    map <Leader>rl :RunLastVimTmuxCommand<CR>

    vmap <LocalLeader>rs "vy :call RunVimTmuxCommand(@v . "\n", 0)<CR>
    nmap <LocalLeader>rs vip<LocalLeader>rs<CR>
endif
" }}}

" _. Coding {{{
if count(g:vimified_packages, 'coding')
    Bundle 'majutsushi/tagbar' 
    nmap <leader>t :TagbarToggle<CR>

    Bundle 'gregsexton/gitv'

    Bundle 'scrooloose/nerdcommenter' 
    nmap <leader># :call NERDComment(0, "invert")<cr>
    vmap <leader># :call NERDComment(0, "invert")<cr>

    " - Bundle 'msanders/snipmate.vim'
    Bundle 'sjl/splice.vim'

    Bundle 'tpope/vim-fugitive' 
    nmap <leader>g :Ggrep
    " ,f for global git serach for word under the cursor (with highlight)
    nmap <leader>f :let @/="\\<<C-R><C-W>\\>"<CR>:set hls<CR>:silent Ggrep -w "<C-R><C-W>"<CR>:ccl<CR>:cw<CR><CR>
    " same in visual mode
    :vmap <leader>f y:let @/=escape(@", '\\[]$^*.')<CR>:set hls<CR>:silent Ggrep -F "<C-R>=escape(@", '\\"#')<CR>"<CR>:ccl<CR>:cw<CR><CR>

    Bundle 'scrooloose/syntastic'
    let g:syntastic_enable_signs=1
    let g:syntastic_auto_loc_list=2
	let g:syntastic_javascript_jshint_conf='~/.jshintrc'
    let g:syntastic_javascript_checker="jshint"
    let g:syntastic_python_checker="pylint"
	let g:syntastic_error_symbol = '✗'
	let g:syntastic_warning_symbol = '!'

    " --
    Bundle 'mattn/webapi-vim'
    Bundle 'mattn/gist-vim'
    let g:gist_clip_command = 'pbcopy'
    let g:gist_detect_filetype = 1
    let g:gist_open_browser_after_post = 1

    autocmd FileType gitcommit set tw=68 spell
endif
" }}}

" _. Python {{{
if count(g:vimified_packages, 'python')
    Bundle 'nvie/vim-flake8'
    let g:flake8_max_line_length=99
    "autocmd BufWritePost *.py call Flake8()

    "Bundle 'orenhe/pylint.vim'
    Bundle 'nvie/vim-pyunit'

    Bundle 'sontek/rope-vim'
    map <leader>j :RopeGotoDefinition<CR>
    map <leader>r :RopeRename<CR>

    inoremap <F5> <esc>:upd\|!python %<cr>
    nnoremap <F5> :upd\|!python %<cr>
    nnoremap <leader>8 :w\|call Flake8()<cr>

    autocmd FileType python set tw=80 ai sw=4 sts=4 et
    "autocmd FileType python set tw=80 ai sw=4 sts=4 ts=4 et
endif
augroup ft_python
    au!
    " Code Folding
    au FileType python setlocal foldmethod=indent
    au FileType python setlocal foldlevelstart=0
    au FileType python setlocal foldlevel=99
augroup END
" }}}
"
" _. Ruby {{{
if count(g:vimified_packages, 'ruby')
    Bundle 'vim-ruby/vim-ruby'
    Bundle 'tpope/vim-rails'
    Bundle 'nelstrom/vim-textobj-rubyblock'
    Bundle 'ecomba/vim-ruby-refactoring'

    autocmd FileType ruby,eruby,yaml set tw=80 ai sw=2 sts=2 et
endif
" }}}

" _. HTML {{{
if count(g:vimified_packages, 'html')
    Bundle 'tpope/vim-haml'
    Bundle 'juvenn/mustache.vim'
    Bundle 'tpope/vim-markdown'
endif
" }}}

" _. CSS {{{
" }}}

" _. JS {{{
if count(g:vimified_packages, 'js')
    " If commented this out as it was a little slow and I didn't like the extra
    " colors scattered around the screen for additional syntax highlights.
    "Bundle 'jelera/vim-javascript-syntax'

    Bundle 'alfredodeza/jacinto.vim'
    Bundle 'vim-scripts/JavaScript-syntax'
    au FileType javascript setlocal foldmethod=syntax
    au FileType javascript setlocal foldlevelstart=0
    au FileType javascript setlocal foldlevel=99
    au FileType javascript setlocal expandtab

    " always run jacinto on json files:
    autocmd BufNewFile,BufRead *.json call jacinto#syntax()

	setlocal makeprg=node\ %
	Bundle 'pydave/AsyncCommand'
	nmap <F4> :w<CR>:<C-U>make<CR>:copen<CR><leader>hb<C-K>
	"nmap <F4> :w<CR>:AsyncMake<CR>:cw<CR>
	autocmd BufRead *.js nmap <F5> :!node %<CR>

	if count(g:vimified_packages, 'os')
		function! AsyncNodeMake(query) 
			" echo hello and the parameter 
			let hello_cmd = "node ".a:query 
			" just load the file when we're done 
			let vim_func = asynchandler#split() 
		 
			" call our core function to run in the background and then load the 
			" output file on completion 
			call asynccommand#run(hello_cmd, vim_func) 
		endfunction 
	endif
endif
" }}}

" _. pdf {{{
if count(g:vimified_packages, 'pdf')
    Bundle 'pdf/ftplugin/pdftk.vim'
    augroup ft_pdf
        au!
        au FileType pdf setlocal foldmethod=indent
    augroup END
endif
" }}}

" _. hex {{{
if count(g:vimified_packages, 'hex')
    " helper function to toggle hex mode
    function ToggleHex()
        " Hide the 'Hit Enter to Continue' prompt
      "set cmdheight=2
      " hex mode should be considered a read-only operation
      " save values for modified and read-only for restoration later,
      " and clear the read-only flag for now
      let l:modified=&mod
      let l:oldreadonly=&readonly
      let &readonly=0
      let l:oldmodifiable=&modifiable
      let &modifiable=1
      if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd
      else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
          setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
      endif
      " restore values for modified and read only state
      let &mod=l:modified
      let &readonly=l:oldreadonly
      let &modifiable=l:oldmodifiable
        " Hide the 'Hit Enter to Continue' prompt
      "set cmdheight=5
    endfunction

    " ex command for toggling hex mode - define mapping if desired
    command -bar Hexmode call ToggleHex()
    command! Hex call ToggleHex()
    nnoremap <leader>hb :Hexmode<CR>
    inoremap <leader>hb <Esc>:Hexmode<CR>
    vnoremap <leader>hb :<C-U>Hexmode<CR>

    " autocmds to automatically enter hex mode and handle file writes properly
    if has("autocmdsupersuper")
      " vim -b : edit binary using xxd-format!
      augroup Binary
        au!

        au BufReadPre * setlocal nobinary
        " set binary option for all binary files before reading them
        au BufReadPre *.bin,*.hex,*.ttf setlocal binary

        " if on a fresh read the buffer variable is already set, it's wrong
        au BufReadPost *
              \ if exists('b:editHex') && b:editHex |
              \   let b:editHex = 0 |
              \ endif

        " convert to hex on startup for binary files automatically
        au BufReadPost *
              \ if &binary | Hexmode | endif

        " When the text is freed, the next time the buffer is made active it will
        " re-read the text and thus not match the correct mode, we will need to
        " convert it again if the buffer is again loaded.
        au BufUnload *
              \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
              \   call setbufvar(expand("<afile>"), 'editHex', 0) |
              \ endif

        " before writing a file when editing in hex mode, convert back to non-hex
        au BufWritePre *
              \ if exists("b:editHex") && b:editHex && &binary |
              \  let oldro=&ro | let &ro=0 |
              \  let oldma=&ma | let &ma=1 |
              \  silent exe "%!xxd -r" |
              \  let &ma=oldma | let &ro=oldro |
              \  unlet oldma | unlet oldro |
              \ endif

        " after writing a binary file, if we're in hex mode, restore hex mode
        au BufWritePost *
              \ if exists("b:editHex") && b:editHex && &binary |
              \  let oldro=&ro | let &ro=0 |
              \  let oldma=&ma | let &ma=1 |
              \  silent exe "%!xxd" |
              \  exe "set nomod" |
              \  let &ma=oldma | let &ro=oldro |
              \  unlet oldma | unlet oldro |
              \ endif

      augroup END
    endif

    command! -nargs=? -range Dec2hex call s:Dec2hex(<line1>, <line2>, '<args>')
    function! s:Dec2hex(line1, line2, arg) range
      if empty(a:arg)
        if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
          let cmd = 's/\%V\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
        else
          let cmd = 's/\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
        endif
        try
          execute a:line1 . ',' . a:line2 . cmd
        catch
          echo 'Error: No decimal number found'
        endtry
      else
        echo printf('%x', a:arg + 0)
      endif
    endfunction

    command! -nargs=? -range Hex2dec call s:Hex2dec(<line1>, <line2>, '<args>')
    function! s:Hex2dec(line1, line2, arg) range
      if empty(a:arg)
        if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
          let cmd = 's/\%V0x\x\+/\=submatch(0)+0/g'
        else
          let cmd = 's/0x\x\+/\=submatch(0)+0/g'
        endif
        try
          execute a:line1 . ',' . a:line2 . cmd
        catch
          echo 'Error: No hex number starting "0x" found'
        endtry
      else
        echo (a:arg =~? '^0x') ? a:arg + 0 : ('0x'.a:arg) + 0
      endif
    endfunction
    nnoremap <leader>hd :Hex2dex<CR>
    inoremap <leader>hd <Esc>:Hex2dex<CR>
    vnoremap <leader>hd :<C-U>Hex2dex<CR>

    " Convert each ASCII character in a string to hex bytes.
    " Example: ":Str2hex ABC 123" displays "41 42 43 20 31 32 33".
    command! -nargs=* Str2hex echo Str2hex(<q-args>)
    function! Str2hex(arg)
      return join(map(split(a:arg, '\zs'), 'printf("%02x", char2nr(v:val))'))
    endfunction
    nnoremap <leader>hs :Str2hex<CR>
    inoremap <leader>hs <Esc>:Str2hex<CR>
    vnoremap <leader>hs :<C-U>Str2hex<CR>

endif
" }}}

" _. CoffeeScript {{{
if count(g:vimified_packages, 'coffeescript')
    Bundle 'kchmck/vim-coffee-script'
endif
" }}}

" _. Clojure {{{ 
if count(g:vimified_packages, 'clojure')
    Bundle 'zaiste/VimClojure'

    let vimclojure#HighlightBuiltins=1
    let vimclojure#ParenRainbow=0
endif
" }}}

" _. Haskell {{{
if count(g:vimified_packages, 'haskell')
    Bundle 'Twinside/vim-syntax-haskell-cabal'
    Bundle 'lukerandall/haskellmode-vim'

    au BufEnter *.hs compiler ghc

    let g:ghc = "/usr/local/bin/ghc"
    let g:haddock_browser = "open"
endif
" }}}

" _. Color {{{
if count(g:vimified_packages, 'color')
    Bundle 'sjl/badwolf'
    Bundle 'altercation/vim-colors-solarized'
    Bundle 'tomasr/molokai'
    Bundle 'zaiste/Atom'
endif
" }}}
" }}}

" General {{{
filetype plugin indent on
colorscheme badwolf 
syntax on

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}

" Mappings {{{

map Y y$

" bracket match using tab
map <tab> %

" clear highlight after search
noremap <silent><Leader>/ :nohls<CR>

" better ESC
inoremap jk <Esc>

nmap <silent> <leader>h :set invhlsearch<CR>
nmap <silent> <leader>l :set invlist<CR>
nmap <silent> <leader>n :set invnumber<CR>
nmap <silent> <leader>p :set invpaste<CR>
nmap <silent> <leader>i :set invrelativenumber<CR>

nmap ; :

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Source current line
vnoremap <leader>L y:execute @@<cr>
" Source visual selection 
nnoremap <leader>L ^vg_y:execute @@<cr>

" w!! to write a file as sudo
" stolen from Steve Losh
cmap w!! w !sudo tee % >/dev/null

" }}}

" . abbrevs {{{
"
iabbrev d@ david.house@webfilings.com

" . }}}

" Settings {{{
set autoread 
set backspace=indent,eol,start
set binary
set cinoptions=:0,(s,u0,U1,g0,t0
set completeopt=menuone,preview
set hidden 
set history=1000
set incsearch 
set laststatus=2 
set list
set encoding=utf-8
" Disable the macvim toolbar
set guioptions-=T

set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set showbreak=↪

set notimeout
set ttimeout
set ttimeoutlen=10

" _ backups {{{ 
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup 
set noswapfile 
" _ }}}

set modelines=0 
set noeol
set relativenumber
nmap <silent> <F11> :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>
set numberwidth=5
set ruler 
set shell=/bin/bash 
set showcmd 

set matchtime=2

set completeopt=longest,menuone,preview

" White characters {{{
set autoindent
set tabstop=4 
set textwidth=80
set shiftwidth=4 
set softtabstop=4
set expandtab
set wrap 
set formatoptions=qrn1
set colorcolumn=+1
" }}}

set visualbell 

set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc
set wildmenu 

set dictionary=/usr/share/dict/words
" }}}

" Triggers {{{

" Save when losing focus
au FocusLost    * :silent! wall

" }}}

" Cursorline {{{
" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
augroup END
" }}}

" Trailing whitespace {{{
" Only shown when not in insert mode so I don't go insane.
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

" }}}

" . searching {{{

" sane regexes
nnoremap / /\v
vnoremap / /\v

set ignorecase 
set smartcase
set showmatch 
set gdefault
set hlsearch

" clear search matching
noremap <leader><space> :noh<cr>:call clearmatches()<cr>
"vnoremap <leader>R :let @a=""|%s//\=setreg('A', submatch(0), 'l')/g|%d _|pu a|0d _<CR>
noremap <leader>R :let @a=""<bar>%s//\=setreg('A', submatch(0), 'l')/g<bar>%d _<bar>pu a<bar>0d _<CR>

" Don't jump when using * for search 
nnoremap * *<c-o>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Highlight word {{{

nnoremap <silent> <leader>hh :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h1 :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h2 :execute '2match InterestingWord2 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h3 :execute '3match InterestingWord3 /\<<c-r><c-w>\>/'<cr>
" }}}

" }}}

" Navigation & UI {{{

" Begining & End of line in Normal mode 
noremap H ^
noremap L g_

" more natural movement with wrap on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Easy buffer navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" Splits ,v and ,h to open new splits (vertical and horizontal)
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Bubbling lines
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

" }}}

" . folding {{{

set foldlevelstart=0
"set foldmethod=indent
set foldlevel=99

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

" Use ,z to "focus" the current fold.
nnoremap <leader>z zMzvzz

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3 - 5
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

function! JavaScriptFold()
	syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
endfunction
"au FileType javascript call JavaScriptFold()


" }}}

" Quick editing {{{

nnoremap <leader>ev <C-w>s<C-w>j:e $MYVIMRC<cr>
nnoremap <leader>es <C-w>s<C-w>j:e ~/.vim/snippets/<cr>
nnoremap <leader>eg <C-w>s<C-w>j:e ~/.gitconfig<cr>
nnoremap <leader>ez <C-w>s<C-w>j:e ~/.zshrc<cr>
nnoremap <leader>et <C-w>s<C-w>j:e ~/.tmux.conf<cr>

" --------------------

set ofu=syntaxcomplete#Complete
let g:rubycomplete_buffer_loading = 0
let g:rubycomplete_classes_in_global = 1

" showmarks
let g:showmarks_enable = 1 
hi! link ShowMarksHLl LineNr
hi! link ShowMarksHLu LineNr
hi! link ShowMarksHLo LineNr
hi! link ShowMarksHLm LineNr

" delimitMate REMOVE?
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1

" sessionman REMOVE?
nmap <leader>S :SessionList<CR>
nmap <leader>SS :SessionSave<CR>
nmap <leader>SA :SessionSaveAs<CR>

" minibufexpl REMOVE?
let g:miniBufExplVSplit = 25
let g:miniBufExplorerMoreThanOne = 100
let g:miniBufExplUseSingleClick = 1
nmap <Leader>b :MiniBufExplorer<cr>

" }}}

" _ Vim {{{
augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END
" }}}

" EXTENSIONS {{{

" _. Scratch {{{

command! ScratchToggle call ScratchToggle()

function! ScratchToggle()
    if exists("w:is_scratch_window")
        unlet w:is_scratch_window
        exec "q"
    else
        exec "normal! :Sscratch\<cr>\<C-W>J:resize 13\<cr>"
        let w:is_scratch_window = 1
    endif
endfunction

nnoremap <silent> <leader><tab> :ScratchToggle<cr>

" }}}

" _. Gist {{{
" Send visual selection to gist.github.com as a private, filetyped Gist
" Requires the gist command line too (brew install gist)
vnoremap <leader>G :w !gist -p -t %:e \| pbcopy<cr>
" }}}

" }}}

" TEXT OBJECTS {{{

" Shortcut for [] motion
onoremap ir i[
onoremap ar a[
vnoremap ir i[
vnoremap ar a[

" }}}

" Load addidional configuration (ie to overwrite shorcuts) {{{
if filereadable(expand("~/.vim/after.vimrc"))
  source ~/.vim/after.vimrc
endif
" }}}
