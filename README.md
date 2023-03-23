Nothin' to see here but some invisible files.

## prereqs

[iTerm][iterm2], `git clone` this repo...

Set up SSH...  
[generate new keypair](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key)  
add GitHub stuff to `~/.ssh/config` if it's not there already  
`ssh-add` the privkey...  
finally [let GitHub know about the pubkey](https://github.com/settings/keys)


Install [oh-my-zsh] and [Homebrew]

### via [Homebrew]:

    brew install \
      asdf \
      lua \
      neovim \
      ripgrep \
      fzf \
      entr \
      difftastic \
      dos2unix

Then set up `asdf`:

    $ asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
    $ asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

**Unison** backup tool...
[docs](https://www.cis.upenn.edu/~bcpierce/unison/download/releases/stable/unison-manual.html#mountpoints)
[wiki](https://alliance.seas.upenn.edu/~bcpierce/wiki/index.php)
[home](https://www.cis.upenn.edu/~bcpierce/unison/)



## setting em up

Check out the repo, then:

    mkdir ~/.config
    cd ~/.config
    ln -s ~/workspace/dotfiles/nvim
    ln -s ~/workspace/dotfiles/alxndr.zsh-theme
    ln -s ~/workspace/dotfiles/.zshrc
    ln -s ~/workspace/dotfiles/.zshenv
    ln -s ~/workspace/dotfiles/.gitconfig


## other things

* [iTerm 2][iterm2]
  * Settings > General
    * in Window tab, uncheck "Native full screen windows"
      * in earlier versions, this was labeled "Use Lion-style fullscreen windows"
  * Settings > Profile
    * use [Inconsolata for Powerline][inconsolata] as the font
    * `/bin/zsh` as the login shell
    * blinking cursor
    * unlimited scrollback
* [Inconsolata for Powerline][inconsolata] or other [patched fonts](https://www.nerdfonts.com/font-downloads)
* [LittleSnitch][little-snitch]
* [SizeUp][sizeup]


## OS/version-specific notes


### macOS 13 (Ventura)

2021 MBP

* Prefs...
  * Keyboard
    * Dvorak layout inder Input Sources
    * "Press 🌐 key to": "Show Emoji & Symbols" 🎉
    * turn on "Keyboard navigation" (tab / shift-tab)
  * Mouse / Trackpad
    * tap-to-click
    * double-tap-to-right-click
  * Accessibility
    * "three-finger drag" is in Accessibility > Pointer Control > Trackpad Options button, "Enable dragging": "with three finger drag" (make sure there's no 'normal' 3-finger gesture which conflicts)
    * "Reduce motion" option in Display
* Auto-Hide Dock (right-click the dock, "Turn Hiding On")
* [iTerm 2][iterm2]
* [Karabiner]
* [Bartender][bartender]


### macOS 12 (Monterey)

2020 MBP

* Prefs...
  * "three-finger drag" is in Accessibility > Pointer Control > Trackpad Options button, "Enable dragging": "with three finger drag" (make sure there's no 'normal' 3-finger gesture which conflicts)
  * "Reduce motion" option 🎉 🍾  Accessibility > Display
  * use Tab to skip through buttons: Keyboard > Shortcuts tab > checkbox at the bottom "Use keyboard navigation to move focus forward..."
    * _not_ the one in Accessibility > Keyboard > Navigation tab > "Enable Full Keyboard Access"
* Apps...
  * iTerm2 (of course)
  * Karabiner (to turn Enter into Control when held)
    * Complex Modifications > "Change return to control if pressed with other keys..."
    * installing Karabiner seems to moot the built-in CL-to-Ctrl mapping, so have to set it up in Karabiner as well
  * Markdown Editor


### OS X 10.13 (High Sierra)

* dvorak keyboard
* karabiner needs permissions
* restore from Time Machine works pretty pretty pretty well


### OS X 10.12

* Dvorak keyboard
* Karabiner
* Chrome: Warn Before Quitting


### OS X 10.10.5

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
  * System Preferences > Trackpad > Scroll & Zoom > check only "Scroll direction: natural"
  * System Preferences > Trackpad > Scroll & Zoom > check only "Notification Center", "Mission Control", "Show Desktop"
* only show one OS X Menu Bar when using multiple monitors:
  * System Preferences > Mission Control > uncheck "Displays have separate Spaces", then re-login




[bartender]: http://www.macbartender.com/
[flux]: https://justgetflux.com/
[inconsolata]: https://github.com/powerline/fonts/tree/master/Inconsolata
[iterm2]: https://www.iterm2.com/
[little-snitch]: https://www.obdev.at/products/littlesnitch/index.html
[oh-my-zsh]: https://ohmyz.sh
[sizeup]: http://www.irradiatedsoftware.com/sizeup/
[Homebrew]: https://brew.sh/
[Karabiner]: https://karabiner-elements.pqrs.org/
