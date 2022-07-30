lua require("user.options")
lua require("user.plugins")

runtime maps.vim " generic key mappings, custom ones go in after/plugin/

" HACK -- after/plugin for vimwiki isn't quite working.
let wiki = {}
let wiki.path = $HOME . "/wiki"
let wiki.syntax = "markdown"
let wiki.ext = ".md"
let wiki.auto_toc = 1
let wiki.auto_tags = 1
let wiki.auto_diary_index = 1
let wiki.auto_generate_links = 1
let wiki.auto_generate_tags = 1
let wiki_list = [wiki]

" til wiki configuration
"   make sure the repository is cloned, and the env var is set
if $TIL_DIR != ""
  let til_wiki = {}
  let til_wiki.path = $TIL_DIR . "/content"
  let til_wiki.syntax = "markdown"
  let til_wiki.ext = ".md"

  let til_wiki.diary_rel_path = "til/"

  let til_wiki.auto_diary_index = 1
  let til_wiki.auto_generate_links = 1
  let til_wiki.auto_generate_tags = 1
  let til_wiki.auto_toc = 1 
  let wiki_list = [til_wiki, wiki]
endif

let g:vimwiki_list = wiki_list
let g:vimwiki_listsyms = "✗○◐●✓"
" Apply automatic 120 width of characters
autocmd BufRead,BufNewFile *.md setlocal textwidth=120

" colorscheme catppuccin
colorscheme onedarkpro
"
" colorscheme spaceduck
" spaceduck has a weird highlight where it blends too much with the
" background, so we use an explicitly darker grey to help
" hi Visual ctermbg=DarkGrey

set statusline+=%{%v:lua.require('nvim-navic').get_location()%}
set exrc
