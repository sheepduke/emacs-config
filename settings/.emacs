;;; Package --- Init file for Emacs

;;; Commentary:

;;; Code:

;; setup packages installed by MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(package-initialize)
(setq load-prefer-newer t)
(require 'use-package)

(mapc 'load (directory-files "~/.emacs.d/settings/plugins/" t "^[a-zA-Z0-9].*.elc$"))
(mapc 'load (directory-files "~/.emacs.d/settings/" t "^[a-zA-Z0-9].*.elc$"))

;; Start Emacs server.
(server-start)

;; Make Emacs fullscreen.
(toggle-frame-fullscreen)
;; You may change it to any theme you favorite theme.
(load-theme 'moe-dark t)

;;; .emacs ends here
