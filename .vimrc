"Alans ~/.vimrc script, uses VAM (thanks MarcWeber) to handle all plugins!
set nocompatible
filetype indent plugin on | syn on
set hidden

" let's copy paste some lines from documentation
fun SetupVAM()
    let addons_base = expand('$HOME') . '/.vim/vim-addons'
    exec 'set runtimepath+='.addons_base.'/vim-addon-manager'

    if !isdirectory(addons_base)
        exec '!p='.shellescape(addons_base).'; mkdir -p "$p" && cd "$p" && git clone git://github.com/MarcWeber/vim-addon-manager.git'
    endif

    let g:vim_addon_manager = {}
    let g:vim_addon_manager['plugin_sources'] = {}
    let g:vim_addon_manager['plugin_sources']['snippets'] = { 'type' : 'git', 'url': 'git://github.com/alansaul/snipmate-snippets.git' }
    "let g:vim_addon_manager['plugin_sources']['snippets'] = { 'type' : 'git', 'url': 'git://github.com/scrooloose/snipmate-snippets.git' } << Using my snippets for now as scroolooses has the wrong directory structure to work with upstream VAM, also mine includes lazily loading functions

    call vam#ActivateAddons(['Solarized', 'blackboard', 'desert256', 'molokai', 'wombat256', 'Railscasts_Theme_GUI256color', 'xoria256', 'Syntastic', 'javacomplete', 'project.tar.gz', 'AutoTag', 'The_NERD_tree', 'pyflakes2441', 'taglist', 'FuzzyFinder', 'endwise', 'surround', 'pep82914', 'rails', 'bundler', 'SuperTab', 'TaskList', 'pydoc910', 'rvm', 'snipmate', 'snippets', 'vcscommand'], {'auto_install' : 0})

endf
call SetupVAM()


" Now use VAM so no need for thses
"filetype off
"call pathogen#helptags()
"call pathogen#runtime_append_all_bundles()

" General {
" try to detect filetypes
filetype on
filetype plugin on 
filetype indent on
set tabstop=4
set smarttab
set shiftwidth=4
set autoindent
set expandtab


"set how many lines of history vim has to remember
set history=1000

"Set wildmenu which allows for command line completion
set wildmenu

set shortmess=aOstT " shortens messages to avoid 
" 'press a key' prompt
"English spell checker by typing :set spell and z= for suggestion
":set spell spelllang=en

" Weirdly the backspace stops working on existing text without this
set backspace=indent,eol,start

"Timeout before accepting that this is only the first keycode (i.e. it is
"<C-L> not <C-L><C-L>
set timeoutlen=500

" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
" }

" Vim UI {
set cursorline " highlight current line
set incsearch " BUT do highlight as you type you search phrase
set lazyredraw " do not redraw while running macros
set shortmess=aOstT " shortens messages to avoid 'press a key' prompt
set showmatch " show matching brackets
" Remove search highlighting with <C-L>
nnoremap <C-L> :nohls<CR><C-L>
" Clear the search term so (n and p no longer search again
map <C-L><C-L> :let @/=""<CR>
set hlsearch " Highlight searched terms

"set background=dark
syntax on
set t_Co=256
set showmatch
set background=dark
"let g:solarized_termcolors=256
"let g:solarized_visibility="low"
"colorscheme solarized
colorscheme solarized

"Set up relative line numbering instead of absolute as its useful to perform
"actions to multiple lines
"Make <C-N><C-N> toggle between line numberings relative absolute and none
noremap <silent> <C-N><C-N> :call ToggleNumbers()<CR>
set rnu

func! ToggleNumbers()
    if !exists('s:cur')
        let s:cur = 0
    else
        let s:cur = (s:cur + 1) % 3
    endif

    if s:cur == 0
        set nu 
    elseif &nu == 1
        set nornu nonu
    else
        set rnu 
    endif
endfunc


"set ofu=syntaxcomplete#Complete
set completeopt+=longest,menu,preview

" Make the popups like IDES, from 
" "http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
"inoremap <expr> <TAB> pumvisible() ? '<TAB>' :
"  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"inoremap <TAB> <M-,> pumvisible() ? '<TAB>' :
"  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"}

"Plugin settings {
"Syntastic
set statusline+=%#warningmsg# "enable flags in status bar
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs=1 "enable signs in side bar
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]' "Add status line showing erros
let g:syntastic_auto_loc_list=2

"TASK LIST
" Toggle task list (type \td to see a list of TODO:'s etc"
map <leader>td <Plug>TaskList
"
" TagList Settings {
let Tlist_Auto_Open=0 " let the tag list open automagically
let Tlist_Compact_Format = 1 " show small menu
let Tlist_Ctags_Cmd = 'ctags' " location of ctags
let Tlist_Enable_Fold_Column = 0 " do show folding tree
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_File_Fold_Auto_Close = 0 " fold closed other trees
let Tlist_Sort_Type = "name" " order by 
let Tlist_Use_Right_Window = 1 " split to the right side of the screen
let Tlist_WinWidth = 40 " 40 cols wide, so i can (almost always read my
"   functions)

"SUPERTAB
" For code completion with a drop down menu
let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
"let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

"PEP8
" Type \8 to check that python syntax complies with standard requirements
let g:pep8_map='<leader>8'

"PROJECT
" Add recently accessed projects menu (project plugin)
set viminfo^=!

"RAILS
" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'

"NERDTREE
" Setup nerd tree shortcut to see directory listings
map <Leader>n :NERDTreeToggle<CR>  

"FUZZY FINDER
let mapleader = "\\"
map <leader>F :FufFile<CR>
map <leader>FT :FufTaggedFile<CR>
map <leader>f :FufCoverageFile<CR> "Recusively find from current directory downward
map <leader>s :FufTag<CR>

"EXUBERANT TAGS
" Remake ctags with F5
map <silent> <F5>:!ctags -R --exclude=.svn --exclude=.git --exclude=log *<CR>
"Set up tag toggle mapping
nmap <leader>t :TlistToggle<CR>

"RVM info
set statusline+=%{rvm#statusline()} 

"VCSCommand
map <leader>zc :VCSCommit<CR>

"Snipmate
"function SnipPath ()
"    return split(&runtimepath,',') + [g:vim_addon_manager.plugin_root_dir+'/snipmate-snippets']
"endfunction
let g:snipMate = {}
"let g:snipMate['snippet_dirs'] = {'faked_function_reference': 'return split(&runtimepath,",") + [g:vim_addon_manager.plugin_root_dir]'}

let g:snipMate['scope_aliases'] = get(g:snipMate,'scope_aliases',
          \ {'objc' :'c'
          \ ,'cpp': 'c'
          \ ,'cs':'c'
          \ ,'xhtml': 'html'
          \ ,'html': 'javascript'
          \ ,'php': 'php,html,javascript'
          \ ,'ur': 'html,javascript'
          \ ,'mxml': 'actionscript'
          \ ,'eruby': 'eruby-rails'
          \ ,'ruby': 'ruby,ruby-rails,ruby-rspec,ruby-shoulda,ruby-factorygirl'
          \ } )
    
"source ~/.vim/vim-addons/snippets/support_functions.vim

" }

" Auto commands {
" Python
au BufRead,BufNewFile *.py set shiftwidth=4
au BufRead,BufNewFile *.py set softtabstop=4 
" Ruby {
" ruby standard 2 spaces, always
au BufRead,BufNewFile *.rb,*.rhtml set shiftwidth=2 
au BufRead,BufNewFile *.rb,*.rhtml set softtabstop=2 
"If its an erb file, give html and ruby snippets
au BufNewFile,BufRead *.html.erb set filetype=eruby.html
"au BufNewFile,BufRead *.rb set filetype=ruby.ruby-rails.ruby-rspec.ruby-shoulda.ruby-factorygirl

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
au CursorMovedI * if pumvisible() == 0|pclose|endif
au InsertLeave * if pumvisible() == 0|pclose|endif

"
" Java {
"let words = :call :PingEclim
"let eclimer = split()
"echo eclimer
" Set up java autocompletion
"au FileType java set completefunc=javacomplete#CompleteParamsInfo
"This line broke things with omni completion: :setlocal completefunc=javacomplete#CompleteParamsInfo
"au FileType java set omnifunc=javacomplete#CompleteParamsInfo
"autocmd Filetype java setlocal omnifunc=javacomplete#Complete 
"au FileType java set omnifunc=javacomplete#Complete 
" }
" }

" Mappings {
"Set up map leader
let mapleader = '\'

" Command to run current script by typing ;e
map ;p :w<CR>:exe ":!python " . getreg("%") . "" <CR>

"Add a new line
nmap <CR> O<ESC>j

"Remap increment number from <C-A> (which is used in screen) to <C-I>
nmap <C-I> <C-A>

" DISABLE ARROW KEYS < Just comment this out if you wan't arrow keys to work
" again
" ==================
"
" Insert Mode
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
" Normal Mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>


" Navigate Omnicomplete with jk
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

"Set up remaps for markers as ' is easier to press. Normally ' goes to the
"line of the marker, and ` goes to the column and line of the marker, here I
"am swapping them because it is easier to press ' and I would usually want
"the effect of `
nnoremap ' `
nnoremap ` '

" ROT13 - fun
map <leader>r ggVGg?
" }

