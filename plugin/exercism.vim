"" Haskell Setup
autocmd BufRead,BufNewFile **exercism/*.hs call Exercism::HaskellSetup()

function Exercism::HaskellSetup()
  let s:test_file = system("find . -name *_test.hs | xargs basename | head")
  let s:test_command = "runhaskell -Wall"
endfunction

"" Ruby Setup
autocmd BufRead,BufNewFile **exercism/*.rb call Exercism::RubySetup()

function Exercism::RubySetup()
  let s:test_file = system("find . -name *_test.rb | xargs basename | head")
  let s:test_command = "ruby"
endfunction

"" Clojure Setup
autocmd BufRead,BufNewFile **exercism/*.clj call Exercism::ClojureSetup()

function Exercism::ClojureSetup()
  let s:test_file = system("find . -name *_test.clj | xargs basename | head")
  let s:test_command = "lein exec"
endfunction

"" Generic Setup
autocmd BufRead,BufNewFile **exercism/** call Exercism::Setup()

function Exercism::RunTests()
  execute("!" . s:test_command . " " . s:test_file)
endfunction

function Exercism::Setup()
  nnoremap <leader>t :call Exercism::RunTests()<cr>
endfunction
