Nothin' to see here but some invisible files.

## setting em up

Check out the repo, then either `ln -s workspace/dotfiles/[...]` into `~` or see if `./link_dotfiles.sh` still works...

Also `brew install neovim` and `ln -s workkspace/dotfiles/init.vim` into `~/.config/nvim/`.

If trying to use vim, also have to:

    cd dotfiles/ \
    && git submodule update --init --recursive
    && cd .vim/bundle/YouCompleteMe/ \
    && ./install.py --clang-completer \
    && cd -


## os x settings

### for OS X 10.12

* Dvorak keyboard
* Karabiner
* ...

### for OS X 10.10.5

* Dvorak keyboard:
  * System Preferences > Keyboard > Input Sources, `+` button, English > Dvorak
* restore F-number keys:
  * System Preferences > Keyboard > Keyboard, check "Use all F1, F2, etc. keys as standard function keys"
* rip out the spell checker:
  * System Preferences > Keyboard > Text, uncheck "Correct spelling automatically"
* rip out a bunch of keyboard shortcuts:
  * System Preferences > Keyboard > Shortcuts, uncheck pretty much everything excepyt for the Screen Shots
* turn off hold-letter-for-accent-marks:
  * `defaults write -g ApplePressAndHoldEnabled -bool false`
* enable using Tab to move keyboard focus between all sorts of GUI controls
  * System Preferences > Keyboard > Shortcuts, under "Full Keyboard Access […]" select the "All controls" radio button
* make the trackpad make sense:
  * System Preferences > Trackpad > Point & Click > check only "Tap to click", "Secondary click", "Three finger drag"
  * System Preferences > Trackpad > Scroll & Zoom > check only "Scroll direction: natural"
  * System Preferences > Trackpad > Scroll & Zoom > check only "Notification Center", "Mission Control", "Show Desktop"
* only show one OS X Menu Bar when using multiple monitors:
  * System Preferences > Mission Control > uncheck "Displays have separate Spaces", then re-login


## other things

### fonts

* [Inconsolata for Powerline][inconsolata]

### tools

* htop
  * `brew install htop`
* [iTerm 2][iterm2]
  * Settings > General
    * uncheck "Use Lion-style fullscreen windows"
  * Settings > Profile
    * use Inconsolata for Powerline as the font
    * `/bin/zsh` as the login shell
    * blinking cursor
    * unlimited scrollback
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
