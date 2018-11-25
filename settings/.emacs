;; setup packages installed by MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(setq package-enable-at-startup nil)
(package-initialize)
(setq load-prefer-newer t)
(require 'use-package)

(mapc 'load (directory-files "~/.emacs.d/settings/plugins/" t "^[a-zA-Z0-9].*.elc$"))
(mapc 'load (directory-files "~/.emacs.d/settings/" t "^[a-zA-Z0-9].*.elc$"))

(server-start)

(load-theme 'spacemacs-light t)
(message "All system online.")

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
       'ivy 'smex 'counsel-projectile
       'sdcv 'org 'org-plus-contrib 'org-journal
       'youdao-dictionary 'magit 'htmlize 'calfw-org 'calfw 'cal-china-x
       ;; themes
       'tangotango-theme 'spacemacs-theme
       ;; development
       'company 'fill-column-indicator 'company-quickhelp
       'yasnippet 'yasnippet-snippets 'ggtags 'highlight-indent-guides
       'hideshow 'arduino-mode 'cmake-mode 'company-c-headers 'erlang
       'company-erlang 'alchemist 'rust-mode 'cargo 'racer 'flycheck-rust
       'company-racer 'slime 'slime-company 'cider 'geiser 'web-mode
       'rainbow-mode 'simple-httpd 'js2-mode 'skewer-mode 'vue-mode 'python
       'elpy 'ruby-mode 'inf-ruby 'company-inf-ruby 'go-mode 'go-eldoc
       'company-go 'latex-preview-pane 'reftex-toc 'company-auctex
       'markdown-mode 'flymd 'markdown-toc 'yaml-mode 'julia-mode 'julia-repl
       ;; input method
       'pyim 'pyim-basedict 'pyim-wbdict
       ;; multimedia
       'emms 'w3m
       ;; mail
       'bbdb 'notmuch
       ;; for fun
       'nyan-mode 'zone))
