# stylish.vim

Stylish is a vim plugin to help you cycle through available themes and
fonts on your system.

## Installation

Stylish requires vim to be compiled with ruby support:

    $ vim --version | grep ruby

To install, clone or download the repo and:

1. `rake install` – copies the plugin files to your vim directory
2. `rake symlink` – symlinks the files, good for contributing
3. `rake uninstall` – uninstalls the plugin

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

## Fonts to try out

* [Inconsolata][]
* [Anonymous Pro][anon]
* [DejaVu Sans Mono][dejavu]

Install them on your system, cycle through with `<Leader>f`. On MacVim,
resize fonts with `⌘-` and `⌘=`. Support for
systems other than OS X is on the way.

[janus]: https://github.com/carlhuda/janus
[inconsolata]: http://www.levien.com/type/myfonts/inconsolata.html
[anon]: http://www.ms-studio.com/FontSales/anonymouspro.html
[dejavu]: http://dejavu-fonts.org/wiki/Main_Page
