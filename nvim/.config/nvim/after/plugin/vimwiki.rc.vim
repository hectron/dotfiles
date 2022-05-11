if !exists("g:loaded_vimwiki")
  finish
endif

" let wiki = {}
" let wiki.path = $HOME . "/wiki"
" let wiki.syntax = "markdown"
" let wiki.ext = ".md"
" let wiki.auto_toc = 1
" let wiki.auto_tags = 1
" let wiki.auto_diary_index = 1
" let wiki.auto_generate_links = 1
" let wiki.auto_generate_tags = 1
" let wiki_list = [wiki]
" 
" " til wiki configuration
" "   make sure the repository is cloned, and the env var is set
" if $TIL_DIR != ""
"   let til_wiki = {}
"   let til_wiki.path = $TIL_DIR . "/content"
"   let til_wiki.syntax = "markdown"
"   let til_wiki.ext = ".md"
" 
"   let til_wiki.diary_rel_path = "til/"
" 
"   let til_wiki.auto_diary_index = 1
"   let til_wiki.auto_generate_links = 1
"   let til_wiki.auto_generate_tags = 1
"   let til_wiki.auto_toc = 1 
"   let wiki_list = [til_wiki, wiki]
" endif
" 
" let g:vimwiki_list = wiki_list
" let g:vimwiki_listsyms = "✗○◐●✓"
