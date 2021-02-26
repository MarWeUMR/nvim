call plug#begin('~/.vim/plugged')
Plug 'machakann/vim-sandwich'
"Plug 'asvetliakov/vim-easymotion'
Plug 'easymotion/vim-easymotion'
"Plug 'haya14busa/incsearch.vim'
"Plug 'haya14busa/incsearch-fuzzy.vim'
"Plug 'haya14busa/incsearch-easymotion.vim'
" Plug 'unblevable/quick-scope'
call plug#end()



if exists('g:vscode')
    " VSCode extension
    
    let mapleader=" "
    nnoremap <Space> <Nop>

    " Easymotion
    map <Leader>l <Plug>(easymotion-lineforward)
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
    map <Leader>h <Plug>(easymotion-linebackward)
    map <Leader>s <Plug>(easymotion-s2)


  
    " Vim Commentary
    xmap gc  <Plug>VSCodeCommentary
    nmap gc  <Plug>VSCodeCommentary
    omap gc  <Plug>VSCodeCommentary
    nmap gcc <Plug>VSCodeCommentaryLine

    " Sandwich
    highlight OperatorSandwichBuns guifg='#edc41f' gui=underline ctermfg=172 cterm=underline 
    highlight OperatorSandwichAdd guifg='#b1fa87' gui=underline ctermfg=172 cterm=underline
    highlight OperatorSandwichDelete guifg='#b1fa87' gui=standout ctermfg=172 cterm=underline
    highlight OperatorSandwichChange guifg='#b1fa87' gui=standout ctermfg=172 cterm=underline

else

    " ordinary neovim
        
    map <Leader>s <Plug>(easymotion-sn)
    let mapleader=" "
    nnoremap <Space> <Nop>

    map <Leader>l <Plug>(easymotion-lineforward)
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
    map <Leader>h <Plug>(easymotion-linebackward)

    set scrolloff=999

endif


