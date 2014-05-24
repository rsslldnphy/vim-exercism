autocmd VimEnter,BufRead,BufNewFile **exercism/*/* call Exercism::Setup()
function Exercism::Setup()
  nnoremap <leader>t :call Exercism::RunTests()<cr>

  "" Ocaml nicks the <leader>t binding for itself,
  "" so use <leader>m (for make) instead.
  if Exercism::Track() =~ "ocaml"
    nnoremap <leader>m :call Exercism::RunTests()<cr>
  end
endfunction

function Exercism::TestFile()
  return system("find . -name *_test.* | xargs basename | head")
endfunction

function Exercism::Track()
  return system("pwd | awk -F'/' '{print $(NF-1)}'")
endfunction

"" Have to use match operator rather than equality here as Exercism::Track()
"" returns the track with a newline at the end and I don't know how to get rid
"" of it!

function Exercism::TestCommand()
  let track = Exercism::Track()
  if     track =~ "clojure"      | return "lein exec "             . Exercism::TestFile()
  elseif track =~ "coffeescript" | return "jasmine-node --coffee " . Exercism::TestFile()
  elseif track =~ "elixir"       | return "elixir "                . Exercism::TestFile()
  elseif track =~ "go"           | return "go test"
  elseif track =~ "haskell"      | return "runhaskell -Wall "      . Exercism::TestFile()
  elseif track =~ "javascript"   | return "jasmine-node "          . Exercism::TestFile()
  elseif track =~ "objective-c"  | return "objc "                  . Exercism::ObjectiveCExerciseName()
  elseif track =~ "ocaml"        | return "make"
  elseif track =~ "perl5"        | return "prove "                 . Exercism::Perl5TestFile()
  elseif track =~ "python"       | return "python "                . Exercism::TestFile()
  elseif track =~ "ruby"         | return "ruby "                  . Exercism::TestFile()
  elseif track =~ "scala"        | return "sbt test"
  endif
endfunction

function Exercism::Foo()
  echo Exercism::TestCommand()
endfunction

function Exercism::ObjectiveCExerciseName()
  return system("find . -name *.h | xargs basename | awk -F'.' '{print $1}'")
endfunction

function Exercism::Perl5TestFile()
  return system("find . -name *.t | xargs basename | head")
endfunction

function Exercism::RunTests()
  execute("!" . Exercism::TestCommand())
endfunction
