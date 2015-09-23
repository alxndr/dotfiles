Nothin' to see here but some invisible files.

## setting em up

Check out the repo, then either `ln -s workspace/dotfiles/[...]` into `~` or see if `./link_dotfiles.sh` still works...

If trying to use vim, also have to:

    cd dotfiles/ \
    && git submodule update --init --recursive
    && cd .vim/bundle/YouCompleteMe/ \
    && ./install.sh  --clang-completer \
    && cd -


## other things

### fonts

* [Inconsolata for Powerline][inconsolata]

### tools

* [iTerm 2][iterm2]
* [LittleSnitch][little-snitch]
* [SizeUp][sizeup]

### quality of life

* [Bartender][bartender]
* [f.lux][flux]

[bartender]: http://www.macbartender.com/
[flux]: https://justgetflux.com/
[inconsolata]: https://github.com/powerline/fonts/tree/master/Inconsolata
[iterm2]: https://www.iterm2.com/
[little-snitch]: https://www.obdev.at/products/littlesnitch/index.html
[sizeup]: http://www.irradiatedsoftware.com/sizeup/
