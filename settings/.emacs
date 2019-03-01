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

;; Start Emacs server.
(server-start)
;; Start sly.
(sly)

(load-theme 'ample t)
(message "All system online.")
