" Plugin Config: junegunn/vim-easy-align

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(LiveEasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(LiveEasyAlign)

" Set easy align to ignore comment lines so blocks can have inline docs
let g:easy_align_ignore_groups = ['Comment', 'String']
