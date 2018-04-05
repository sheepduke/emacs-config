# emacs-settings
This repository contains Emacs settings used by me.

I am currently using mu4e for mail client. But the configuration contains some personal information so it is not included here.

# How to Use
Place `.emacs` file to your `home` directory and others to `~/.emacs.d/`, then navigate to `~/.emacs.d/settings/` and run `C-u 0 byte-recompile-directory`.
This will compile `.el` files into byte code and thus can be loaded automatically by `~/.emacs` file.

# Installed Packages
```emacs lisp
(rainbow-mode zone-nyan skewer-mode js2-mode cider mu4e-maildirs-extension
geiser tangotango-theme pyim-wbdict markdown-mode flymd fill-column-indicator
highlight-indent-guides sdcv calfw-org pyim company-racer racer flycheck-rust
cargo rust-mode company-erlang erlang company-quickhelp highlight-blocks
highlight dired+ flycheck nyan-mode robe auto-compile company-inf-ruby
inf-ruby company-web web-mode use-package mu4e-alert slime-company slime
helm-themes delight company-auctex company-c-headers helm-projectile
projectile helm-descbinds helm-company company helm elscreen-persist pdf-tools
shackle image-dired+ image+ magit cal-china-x yasnippet w3m undo-tree
string-utils showtip pos-tip php-mode multiple-cursors latex-preview-pane
htmlize gntp ggtags emms-player-mpv elscreen concurrent cmake-font-lock calfw
bbdb auctex ace-window)
```

You may customize the content of this list and install it by (for Emacs above 25.1):
```emacs lisp
(setq package-selected-packages the-list-above)
(package-install-selected-packages)
```

# Directory Hierarchy
## a0-variables
Definition of global variables.

## a1-function
Definition of common functions.

## b0-customize
Customization of built-in functionality.

## b1-tools
Small tools that bring much efficiency.

## b2-display
Customization related to buffer display, X window etc.

## c3-external
Tools that relies on external programs.

## d0-helm
`Helm` configuration.

## d1-dev-common
Some common programming configuration.

## d2-dev-lang
Configuration for each programming language.

## e1-org-mode
Org related settings.

## .emacs
Backup for `~/.emacs` file.
