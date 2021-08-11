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

;; Set load path.
(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'load-path "~/.emacs.d/plugins/ebuild-mode/")
(add-to-list 'load-path "~/.emacs.d/settings/")

;; Load custom plugins.
(mapc 'load
      (mapcar (lambda (filename) (file-name-base filename))
              (directory-files "~/.emacs.d/plugins/" nil ".*.el$")))

;; Load settings.
(mapc 'load
      (mapcar (lambda (filename) (file-name-base filename))
              (directory-files "~/.emacs.d/settings/" nil "^[a-zA-Z][0-9]-.*.el$")))

;; Start Emacs server.
(server-start)

;;; init.el ends here
