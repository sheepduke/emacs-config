;; setup packages installed by MELPA
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(setq package-enable-at-startup nil)
(package-initialize)
(setq load-prefer-newer t)
(require 'use-package)
(mapc 'load (directory-files "~/.emacs.d/settings/plugins/" t "^[a-zA-Z0-9].*.elc$"))
(mapc 'load (directory-files "~/.emacs.d/settings/" t "^[a-zA-Z0-9].*.elc$"))

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
