;;; Package --- Init file for Emacs
;;;
;;; Commentary:
;;; 
;;; Code:

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

;; Load custom plugins.
(mapc 'load (directory-files "~/.emacs.d/settings/plugins/" t "^[a-zA-Z0-9].*.elc$"))

;; Load settings.
(mapc 'load
      (mapcar (lambda (filename) (expand-file-name filename "~/.emacs.d/settings/"))
              (remove "init.elc"
                      (directory-files "~/.emacs.d/settings/" nil "^[a-zA-Z0-9].*.elc$"))))

(mapc 'load (directory-files "~/.emacs.d/settings/" t "^[a-zA-Z0-9].*.elc$"))

;; Start Emacs server.
(server-start)

;; You may change it to any theme you favorite theme.
(load-theme 'kaolin-breeze t)

;;; init.el ends here
