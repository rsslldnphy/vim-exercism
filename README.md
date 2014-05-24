# vim-exercism

Adds one simple mapping - `<Leader>t` - that will run the tests for the current exercise.

The OCaml settings for vim steal that mapping for themselves, so when doing an OCaml exercise you have to use `<Leader>m` (for `make`) instead I'm afraid.

You must be in the exercise directory for this to work, but the mapping will work from any file in that directory.

The plugin relies on you exercises being stored in a directory named `exercism`... which I'm assuming most if not everyone's are.

Supports all languages (at time of writing) apart from C#, as I couldn't think of a nice way to automate the horrific process of building, linking and running the C# exercise, not least because there's no easy way to know where the nunit.framework.dll will be. Sorry, C-sharpers! Pull requests welcome ;-)

## Installation

[Pathogen](https://github.com/tpope/vim-pathogen) is the easiest way to install. Assuming you have pathogen set up, just:

    cd ~/.vim/bundle
    git clone git://github.com/rsslldnphy/vim-exercism.git
