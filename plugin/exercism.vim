autocmd VimEnter,BufRead,BufNewFile **exercism/*/* call Exercism::Setup()
function Exercism::Setup()
  nnoremap <leader>t :call Exercism::RunTests()<cr>
  nnoremap <leader>r :e README.md<cr>
  nnoremap <leader><leader> :call Exercism::SwapFiles()<cr>

  "" Ocaml nicks the <leader>t binding for itself,
  "" so use <leader>m (for make) instead.
  if Exercism::Track() =~ "ocaml"
    nnoremap <leader>m :call Exercism::RunTests()<cr>
  end
endfunction

function Exercism::StripNewline(str)
  return a:str[0 : strlen(a:str) - 2]
endfunction

function Exercism::Track()
  let track = system("pwd | awk -F'/' '{print $(NF-1)}'")
  return Exercism::StripNewline(track)
endfunction

function Exercism::TestCommand()
  let track = Exercism::Track()
  if     track == "clojure"      | return "lein exec "             . Exercism::TestFile()
  elseif track == "coffeescript" | return "jasmine-node --coffee " . Exercism::TestFile()
  elseif track == "elixir"       | return "elixir "                . Exercism::TestFile()
  elseif track == "go"           | return "go test"
  elseif track == "haskell"      | return "runhaskell -Wall "      . Exercism::TestFile()
  elseif track == "javascript"   | return "jasmine-node "          . Exercism::TestFile()
  elseif track == "objective-c"  | return "objc "                  . Exercism::ObjectiveCExerciseName()
  elseif track == "ocaml"        | return "make"
  elseif track == "perl5"        | return "prove "                 . Exercism::Perl5TestFile()
  elseif track == "python"       | return "python "                . Exercism::TestFile()
  elseif track == "ruby"         | return "ruby "                  . Exercism::TestFile()
  elseif track == "scala"        | return "sbt test"
  endif
endfunction

function Exercism::ObjectiveCExerciseName()
  let name = system("find . -name \"*.h\" | xargs basename | awk -F'.' '{print $1}'")
  return Exercism::StripNewline(name)
endfunction

function Exercism::RunTests()
  execute("!" . Exercism::TestCommand())
endfunction

function Exercism::TestFile()
  let track = Exercism::Track()
  if     track =~ "objective-c" | return Exercism::ObjectiveCTestFile()
  elseif track =~ "perl5"       | return Exercism::Perl5TestFile()
  else                          | return Exercism::GenericTestFile()
  endif
endfunction

function Exercism::GenericTestFile()
  let test_file = system("find . -name \"*test.*\" | xargs basename | head -n 1")
  return Exercism::StripNewline(test_file)
endfunction

function Exercism::Perl5TestFile()
  let test_file = system("find . -name \"*.t\" | xargs basename | head -n 1")
  return Exercism::StripNewline(test_file)
endfunction

function Exercism::ObjectiveCTestFile()
  let test_file = system("find . -name \"*Test.m\" | xargs basename | head -n 1")
  return Exercism::StripNewline(test_file)
endfunction

function Exercism::SourceFile()
  let track = Exercism::Track()
  if     track =~ "clojure"      | let pattern = "*.clj"
  elseif track =~ "coffeescript" | let pattern = "*.coffee"
  elseif track =~ "elixir"       | let pattern = "*.exs"
  elseif track =~ "go"           | let pattern = "*.go"
  elseif track =~ "haskell"      | let pattern = "*.hs"
  elseif track =~ "javascript"   | let pattern = "*.js"
  elseif track =~ "objective-c"  | let pattern = "*.m"
  elseif track =~ "ocaml"        | let pattern = "*.ml"
  elseif track =~ "perl5"        | let pattern = "*.pm"
  elseif track =~ "python"       | let pattern = "*.py"
  elseif track =~ "ruby"         | let pattern = "*.rb"
  elseif track =~ "scala"        | let pattern = "src/main/scala/**.scala"
  endif
  let source_file = system("find . -name \"" . pattern . "\" | grep -v " . Exercism::TestFile() . " | xargs basename | head -n 1")
  return Exercism::StripNewline(source_file)
endfunction

function Exercism::SwapFiles()
  if expand("%") == Exercism::SourceFile() | exec ':e ' . Exercism::TestFile()
  else                                     | exec ':e ' . Exercism::SourceFile()
  endif
endfunction
