"" Haskell Setup
autocmd BufRead,BufNewFile **exercism/*.hs call Exercism::HaskellSetup()

function Exercism::HaskellSetup()
  let s:test_file = system("find . -name *_test.hs | xargs basename | head")
  let s:test_command = "runhaskell -Wall"
endfunction

function Exercism::TestFile()
  return s:test_file
endfunction

function Exercism::RunTests()
  execute("!" . s:test_command . " " . s:test_file)
endfunction

"" Generic Setup
autocmd BufRead,BufNewFile **exercism/** call Exercism::Setup()

function Exercism::Setup()
  nnoremap <leader>t :call Exercism::RunTests()<cr>
endfunction
