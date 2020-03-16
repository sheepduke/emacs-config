;;; Package --- Init file for Emacs

;;; Commentary:

;;; Code:

;; setup packages installed by MELPA
(require 'package)

(setq package-archives
      '(;; Choose whatever you like.
        ;; --- Default
        ;; ("gnu" . "https://elpa.gnu.org/packages/")
        ;; ("melpa" . "https://melpa.org/packages/")
        ;; ("org" . "https://orgmode.org/elpa/")
        ;; --- TUNA mirror
        ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
        ;; ---
        ))

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
