# emacs-settings
This repository contains Emacs settings used by me.

# How to Use
Place `.emacs` file to your `home` directory and others to `~/.emacs.d/`, then navigate to `~/.emacs.d/settings/` and run `C-u 0 byte-recompile-directory`.
This will compile `.el` files into byte code and thus can be loaded automatically by `~/.emacs` file.

# Installed Packages
You may `eval` the following snippet to install all packages at once.
```emacs lisp
(setq package-selected-packages
      (list
       ;; utility
       'use-package 'elscreen 'auto-compile 'elscreen-persist
       ;; display
       'shackle 'delight
       ;; window manipulation
       'winner 'ace-window 'windmove
       ;; cursor
       'multiple-cursors 'avy
       ;; editing
       'undo-tree
       ;; file manipulation
       'async 'dired+
       ;; file viewing
       'pdf-tools 'image+
       ;; productivity
       'helm 'helm-descbinds 'projectile 'helm-projectile 'sdcv
       'youdao-dictionary 'magit 'htmlize 'calfw-org 'calfw 'cal-china-x
       ;; themes
       'helm-themes 'tangotango-theme 'spacemacs-theme
       ;; development
       'company 'fill-column-indicator 'company-quickhelp 'helm-company
       'yasnippet 'yasnippet-snippets 'ggtags 'highlight-indent-guides
       'hideshow 'arduino-mode 'cmake-mode 'company-c-headers 'erlang
       'company-erlang 'alchemist 'rust-mode 'cargo 'racer 'flycheck-rust
       'company-racer 'slime 'slime-company 'cider 'geiser 'web-mode
       'rainbow-mode 'simple-httpd 'js2-mode 'skewer-mode 'vue-mode 'python
       'ruby-mode 'inf-ruby 'company-inf-ruby 'go-mode 'go-eldoc 'company-go
       'latex-preview-pane 'reftex-toc 'company-auctex 'markdown-mode 'flymd
       'markdown-toc 'yaml-mode
       ;; input method
       'pyim 'pyim-basedict 'pyim-wbdict
       ;; multimedia
       'emms 'w3m
       ;; mail
       'bbdb 'notmuch
       ;; 'mu4e-alert 'mu4e 'mu4e-maildirs-extension 'mu4e-ext
       ;; for fun
       'nyan-mode 'zone))
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

## f4-mail
Configuration for email.

## e1-org-mode
Org related settings.

## .emacs
Backup for `~/.emacs` file.
