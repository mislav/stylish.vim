# stylish.vim

Stylish is a vim plugin to help you cycle through available themes and
fonts on your system.

Stylish requires vim to be compiled with ruby support:

    $ vim --version | grep ruby

## Usage

The following commands are available:

1. `:Stylish` – creates the Leader-prefixed shortcuts for the following
   commands
1. `:StylishNext` (`<Leader>c`) – next color scheme
1. `:StylishPrev` (`<Leader>cp`) – previous color scheme
1. `:StylishRand` (`<Leader>r`) – random color scheme
1. `:StylishFont` (`<Leader>f`) – next programming font (currently OS X
   only)

Typical usage is opening vim, executing the `:Stylish` command and pressing
`<Leader>r` ("Leader" character by default is `\`) to explore color
schemes in random order.

Stylish affects two vim settings: `:color` and `:set guifont`. Type
these commands to inspect the current settings. Copy the commands with their values to your "~/.vimrc"
and "~/.gvimrc" to persist them.

Tip: different fonts look best with different `linespace` setting.

Example config:

``` vim
" .vimrc
color molokai

" .gvimrc
color twilight
set guifont=Menlo\ Regular:h14
set linespace=2
```

If you're using [Janus][], put custom settings in "~/.vimrc.local" and "~/.gvimrc.local" instead.


[janus]: https://github.com/carlhuda/janus
