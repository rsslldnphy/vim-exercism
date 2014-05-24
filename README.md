# vim-exercism

[exercism.io](http://exercism.io) is a brilliant site with loads of fun coding exercises and crowd-sourced code-reviews. You download an exercise and make the supplied tests pass. This plugin tries to make running those tests and navigating between the files a breeze for vim users.

It adds three simple mappings:

`<Leader>t`        - runs the tests for the current exercise.

`<Leader><Leader>` - switches between source file and test file.

`<Leader>r`        - opens the README.md

(You can set your `<Leader>` key to whatever you want. I use comma.)

## Language support

Supports all languages (at time of writing) apart from C#, as I couldn't think of a nice way to automate the horrific process of building, linking and running the C# exercise, not least because there's no easy way to know where the `nunit.framework.dll` will be. Sorry, C-sharpers! Pull requests welcome ;-)

## OCaml Exception

The OCaml settings for vim steals the `<Leader>t` mapping for itself, so when doing an OCaml exercise you have to use `<Leader>m` (for `make`) to run tests instead I'm afraid.

## Installation

[Pathogen](https://github.com/tpope/vim-pathogen) is the easiest way to install. Assuming you have pathogen set up, just:

    cd ~/.vim/bundle
    git clone git://github.com/rsslldnphy/vim-exercism.git

## Assumptions

You must be in the exercise directory for these commands to work, but they will work from any file in that directory.

The plugin relies on you exercises being stored in a directory named `exercism`... which I'm assuming most if not everyone's are.

Working out which file is the source and which is the test is basically guess-work, so may go wrong. If it does, please let me know the example so the guesswork can be made more effective.

## Vimscript

Aaargh.
