(require 'package)

(setq package-archives
      '(;; Choose whatever you like.
        ;; --- Default
        ;; ("gnu" . "https://elpa.gnu.org/packages/")
        ;; ("melpa" . "https://melpa.org/packages/")
        ;; --- TUNA mirror
        ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ;; ---
        ))

(load "~/.emacs.d/settings/lisp/init.el")

;; You may change it to any theme you favorite theme.
(load-theme 'leuven t)
