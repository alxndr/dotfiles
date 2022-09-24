Nothin' to see here but some invisible files.

## prereqs

Install [oh-my-zsh]

    brew install \
      lua \
      neovim \
      Schniz/fnm \
      ripgrep \
      fzf \
    # ...probably a bunch more
    # oh-my-zsh ?

## setting em up

Check out the repo, then either `ln -s workspace/dotfiles/[...]` into `~` or see if `./link_dotfiles.sh` still works...

    ln -s workspace/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
    ln -s ~/workspace/dotfiles/alxndr.zsh-theme ~/.oh-my-zsh/themes

## os x settings

Need [patched fonts](https://www.nerdfonts.com/font-downloads)... currently enamored with `Hasklig` / Hasklug

### high sierra

* dvorak keyboard
* karabiner needs permissions
* restore from Time Machine works pretty pretty pretty well

### for OS X 10.12

* Dvorak keyboard
* Karabiner
* Chrome: Warn Before Quitting
* ...

### for OS X 10.10.5

* Dvorak keyboard:
  * System Preferences > Keyboard > Input Sources, `+` button, English > Dvorak
* restore F-number keys:
  * System Preferences > Keyboard > Keyboard, check "Use all F1, F2, etc. keys as standard function keys"
* rip out the spell checker:
  * System Preferences > Keyboard > Text, uncheck "Correct spelling automatically"
* rip out a bunch of keyboard shortcuts:
  * System Preferences > Keyboard > Shortcuts, uncheck pretty much everything except for the Screen Shots
* turn off hold-letter-for-accent-marks:
  * `defaults write -g ApplePressAndHoldEnabled -bool false`
* enable using Tab to move keyboard focus between all sorts of GUI controls
  * System Preferences > Keyboard > Shortcuts, under "Full Keyboard Access […]" select the "All controls" radio button
* turn Caps Lock into Control
  * System Preferences > Keyboard > Modifier Keys button > set Caps Lock to Control
* make the trackpad make sense:
  * System Preferences > Trackpad > Point & Click > check only "Tap to click", "Secondary click", "Three finger drag"
    * "three-finger drag" is in Accessibility > Pointer Control > Trackpad Options button, "Enable dragging": "with three finger drag" (make sure there's no 'normal' 3-finger gesture which conflicts)
  * System Preferences > Trackpad > Scroll & Zoom > check only "Scroll direction: natural"
  * System Preferences > Trackpad > Scroll & Zoom > check only "Notification Center", "Mission Control", "Show Desktop"
* only show one OS X Menu Bar when using multiple monitors:
  * System Preferences > Mission Control > uncheck "Displays have separate Spaces", then re-login


## other things

### fonts

* [Inconsolata for Powerline][inconsolata]


### gui tools

* [iTerm 2][iterm2]
  * Settings > General
    * in Window tab, uncheck "Native full screen windows"
      * in earlier versions, this was labeled "Use Lion-style fullscreen windows"
  * Settings > Profile
    * use [Inconsolata for Powerline][inconsolata] as the font
    * `/bin/zsh` as the login shell
    * blinking cursor
    * unlimited scrollback
* [LittleSnitch][little-snitch]
* [SizeUp][sizeup]


### quality of life

* [Bartender][bartender]
* [f.lux][flux] ... now built-in to newer versions of Mac OS X


[bartender]: http://www.macbartender.com/
[flux]: https://justgetflux.com/
[inconsolata]: https://github.com/powerline/fonts/tree/master/Inconsolata
[iterm2]: https://www.iterm2.com/
[little-snitch]: https://www.obdev.at/products/littlesnitch/index.html
[oh-my-zsh]: https://ohmyz.sh
[sizeup]: http://www.irradiatedsoftware.com/sizeup/
[Schniz/fnm]: https://github.com/Schniz/fnm
