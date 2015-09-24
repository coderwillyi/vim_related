set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
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
execute pathogen#infect()
syntax on
filetype plugin indent on
"colorscheme set
colorscheme lucius
LuciusDark
"gui config 
"no meue no tools no scrollbar
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=T
"always allow status bar
set laststatus=2
"show the cursor position
set ruler
"show row number
set number
"highlight editing row and column
set cursorline
set cursorcolumn
"highlight the search result
set hlsearch
"set tabstop with 4 spaces
set expandtab
set tabstop=4
"ignore case when search text in current file
set ignorecase
"auto change to current editing file's path
autocmd BufEnter * silent! lcd %:p:h
"split check out key map
map <C-j> <C-w>j
map <C-h> <C-w>h
map <C-k> <C-w>k
map <C-l> <C-w>l

"Ctags settings
"map the <F5>key to toggle silent cmd to create ctags fiels used by taglist or
"other plugins 
map <F5> <Esc>:call ToggleCtags()
func! ToggleCtags()
	silent! execute "!dir /b/s *.c,*.cpp,*.cs,*.java,*.h,*.mak,makefile >> ctags.files"
	silent! execute "!ctags -R --c++-kinds=+px --fields=+iaS --extra=+q -L ctags.files"
endfunc
set tags+=tags;
set autochdir
"Cscope settings
"compatibility between cscope and ctags
"use quickfix window to show the result of query.
"csto is used to set cscope database as the preferential option against tags
"procuced by ctags when search
"tags
"cst is used to set cscope and ctags be used the same time
"csverb will tell you the result when you add a database to cacope
if has("cscope")
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    set csto=0
    set cst
    set csverb
endif
"map the <F6> key to toggle slent cmd to create cscope files used by cscope or
"taglist
map <F6> <Esc>:call Do_CsTag()
function Do_CsTag()
    if(executable("cscope") && has("cscope") )
        if(has('win32'))
            silent! execute "!dir /b/s *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
        else
            silent! execute "!find . -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "*.m" -o -name "*.mm" -o -name "*.java" -o -name "*.py" > cscope.files"
        endif
        silent! execute "!cscope -b"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endf
"map some hot keys to cscope
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
"Taglist settings
let Tlist_Ctags_Cmd='ctags' "set ctags path
let Tlist_Show_One_File=1 "only show current file's taglist
let Tlist_Exit_OnlyWindow=1 "exit vim if taglist is the last window
let Tlist_Use_Left_Window=1 "let taglist window show in the left
let Tlist_File_Fold_Auto_Close=1 "hide taglist if it's not for current file
