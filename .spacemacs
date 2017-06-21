;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

;; TODO
;; - don't use sound effects when updating packages

(defun dotspacemacs/layers ()
  "Configuration Layers declaration."
  (setq-default
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     auto-completion
     better-defaults
     colors
     dash
     elixir
     emacs-lisp
     emoji
     erlang
     git
     github
     gtags
     html
     javascript
     markdown
     (osx :variables osx-use-option-as-meta nil)
     php
     react
     ruby
     ruby-on-rails
     (shell :variables shell-default-height 30
                       shell-default-position 'bottom
                       shell-default-shell 'term
                       shell-default-term-shell "/bin/zsh")
     syntax-checking
     yaml
     version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages then consider to create a layer, you can also put the
   ;; configuration in `dotspacemacs/config'.
   dotspacemacs-additional-packages '()
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'
   dotspacemacs-delete-orphan-packages t

   evil-escape-key-sequence "jk"
   evil-escape-unordered-key-sequence t

   ruby-insert-encoding-magic-comment nil
   )
  )

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; Either `vim' or `emacs'. Evil is always enabled but if the variable
   ;; is `emacs' then the `holy-mode' is enabled at startup.
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer.
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed.
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'."
   dotspacemacs-startup-lists '(recents projects)

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(solarized-dark solarized-light)
   ;; If non nil the cursor color matches the state color.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Inconsolata for Powerline"
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it.
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; Default value is `cache'.
   dotspacemacs-auto-save-file-location 'cache
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f) is replaced.
   dotspacemacs-use-ido nil
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content.
   dotspacemacs-enable-paste-micro-state nil
   ;; Guide-key delay in seconds. The Guide-key is the popup buffer listing
   ;; the commands bound to the current keystrokes.
   dotspacemacs-guide-key-delay 0.4
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil ;; to boost the loading time.
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up.
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup t
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX."
   dotspacemacs-fullscreen-use-non-native t
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'.
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'.
   dotspacemacs-inactive-transparency 50
   ;; If non nil unicode symbols are displayed in the mode line.
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen.
   dotspacemacs-smooth-scrolling t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible value is `all',
   ;; `current' or `nil'. Default is `all'
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now.
   dotspacemacs-default-package-repository nil

   )

  (setq dotspacemacs-auto-save-file-location nil)

  (setq require-final-newline t)
  (setq ruby-insert-encoding-magic-comment nil)
  (setq ruby-version-manager 'rvm)

    (defun comment-dwim-line (&optional arg)
      "Replacement for the comment-dwim command.
        If no region is selected and current line is not blank and we are not at the end of the line, then comment current line.
        Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line.
        http://www.emacswiki.org/emacs/CommentingCode"
      (interactive "*P")
      (comment-normalize-vars)
      (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
        (comment-or-uncomment-region (line-beginning-position) (line-end-position))
        (comment-dwim arg)))
    (global-set-key (kbd "C-\\") 'comment-dwim-line)

    ;(add-to-list 'auto-mode-alist '("\\.jsx$" . react-mode))

  )

(defun dotspacemacs/user-init ()
  "User init function."

  (message (system-name))
  (if (string= "bigmac.gateway.sonic.net" (system-name))
      (setq-default dotspacemacs-default-font
                    '("Inconsolata for Powerline"
                      :size 24
                      :weight normal
                      :width normal
                      :powerline-scale 1.1)))

)

(defun dotspacemacs/user-config ()
  "Configuration function.
 This function is called at the very end of Spacemacs initialization after
layers configuration."
  (global-linum-mode)
  (linum-relative-toggle)
  (setq-default truncate-lines t)

  ;; remappings

  (define-key evil-normal-state-map (kbd "RET") 'spacemacs/insert-line-below-no-indent)
  (define-key evil-normal-state-map (kbd "C-RET") 'spacemacs/insert-line-above-no-indent)
  (define-key evil-normal-state-map (kbd "S-RET") 'spacemacs/insert-line-above-no-indent)

  (define-key evil-normal-state-map (kbd "+") 'er/expand-region)

  ;; TODO
  ;; - nnoremap <S-Down> shift current line down
  ;; - nnoremap <S-Up>   shift current line up

  (setq-default standard-indent 2)

  ;; css
  (setq-default css-indent-offset 2)
  (setq-default web-mode-css-indent-offset 2)

  ;; elixir
  (add-hook 'alchemist-mode-hook 'company-mode) ;; http://zohaib.me/spacemacs-and-alchemist-to-make-elixir-of-immortality/
  (setq-default elixir-basic-offset 2)
  ;; (with-eval-after-load 'elixir
  ;;   (modify-syntax-entry ?_ "w" elixir-mode-syntax-table) ;; "symbol's value is void: elixir-mode-syntax-table"
  ;; )

  ;; html
  (setq-default web-mode-attr-indent-offset 2)
  (setq-default web-mode-markup-indent-offset 2)

  ;; js
  (setq-default js2-basic-offset 2)
  (setq-default web-mode-code-indent-offset 2)
  ;; https://github.com/syl20bnr/spacemacs/tree/15de481a803b00983d6771309f8f99c1d1e464b8/layers/%2Bframeworks/react#optional-configuration
  (with-eval-after-load 'web-mode
    (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil)))

  ;; check when opening large files
  ;; https://github.com/syl20bnr/spacemacs/issues/3491#issuecomment-150478925
  (defun spacemacs/check-large-file ()
    (when (> (buffer-size) (* 1024 1024))
      (when (y-or-n-p "Open file literally?")
        (setq buffer-read-only t)
        (buffer-disable-undo)
        (fundamental-mode))))
  (add-hook 'find-file-hook 'spacemacs/check-large-file)

)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ahs-case-fold-search nil)
 '(ahs-default-range (quote ahs-range-whole-buffer))
 '(ahs-idle-interval 0.25)
 '(ahs-idle-timer 0 t)
 '(ahs-inhibit-face-list nil)
 '(auto-save-default nil)
 '(c-basic-offset 2)
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(diff-hl-side (quote left))
 '(even-window-heights nil)
 '(evil-shift-width 2)
 '(flycheck-check-syntax-automatically (quote (save mode-enabled)))
 '(flycheck-temp-prefix ".flycheck")
 '(helm-grep-ag-command "rg --smart-case --no-heading --line-numbers %s %s %s")
 '(indent-tabs-mode nil)
 '(js-indent-level 2)
 '(json-reformat:indent-width 2)
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "docs")))
 '(ring-bell-function (quote ignore) t)
 '(safe-local-variable-values
	 (quote
		((eval setq flycheck-checkers
					 (quote
						(javascript-eslint)))
		 (eval setq flycheck-disabled-checkers
					 (quote
						(javascript-jshint)))
		 (eval flycheck-add-mode
					 (quote javascript-eslint)
					 (quote web-mode))
		 (eval add-to-list
					 (quote auto-mode-alist)
					 (quote
						("\\.js$" . web-mode)))
		 (eval highlight-regexp "^ *"))))
 '(show-trailing-whitespace t)
 '(sp-navigate-close-if-unbalanced t)
 '(split-width-threshold 60)
 '(tab-width 2)
 '(x-stretch-cursor t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
