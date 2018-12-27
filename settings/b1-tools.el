;;; Package --- Summary
;;;
;;; Commentary:
;;; This file contains small tools that makes Emacs smarter.
;;;
;;; Code:

;; This is built-in in Emacs 24 or something.
;; Used to automatically pair brackets.
;; 
(use-package electric
  :ensure
  :config
  (electric-pair-mode))

;; Ebuild mode, for Gentoo users.
;;
(use-package ebuild-mode
  :mode "\\.use\\'"
  :mode "\\.mask\\'"
  :mode "\\.unmask\\'")

;; Make undo like a tree.
;; 
(use-package undo-tree
  :ensure
  :init
  ;; Show diffs when browsing through the undo tree
  (setq undo-tree-visualizer-diff t)
  ;; Don't show relative times in the undo tree visualizer
  (setq undo-tree-visualizer-timestamps nil)
  ;; Don't save history to a file
  (setq undo-tree-auto-save-history nil)

  :bind
  ("C-/" . undo-tree-undo)
  ("C-?" . undo-tree-redo)
  ("C-x u" . undo-tree-visualize)

  :config
  (call-when-defined 'global-undo-tree-mode))

;; Replace the original doc-view for PDF files.
;;
(use-package pdf-tools
  :ensure
  :config
  (call-when-defined 'pdf-tools-install))


;; Edit multiple places at the same time.
;; 
(use-package multiple-cursors
  :ensure
  :init
  (setq mc/always-run-for-all t)
  :bind
  ("C-x r e" . mc/edit-lines))


;; It's Magit! Git inside Emacs.
;; 
(use-package magit
  :ensure
  :bind ("C-x v" . magit-status)
  :config
  (add-hook 'git-commit-mode-hook 'flyspell-mode))


;; Jump to character from 2 leading chars.
;; 
(use-package avy
  :ensure
  :bind
  ("M-g c" . avy-goto-char)
  ("M-g a" . avy-goto-char-2)
  ("M-g g" . avy-goto-line))


;; Automatically compile Emacs Lisp libraries
;; 
(use-package auto-compile
  :ensure
  :config
  (call-when-defined 'auto-compile-on-load-mode)
  (call-when-defined 'auto-compile-on-save-mode))


;; Execute asynchronous commands.
;; 
(use-package async
  :ensure
  :config
  (dired-async-mode 1))

;; Built-in input method.
;; 
(use-package pyim
  :ensure
  :init
  (require 'pyim)
  ;; 设定默认输入法
  (setq default-input-method "pyim")
  ;; 使用五笔
  (require 'pyim-wbdict)
  (setq pyim-default-scheme 'wubi)
  ;; 中文使用全角标点，英文使用半角标点。
  (setq pyim-punctuation-translate-p '(auto yes no))
  ;; 作为五笔用户，我觉得自己完全不需要选词框
  (setq pyim-page-tooltip 'minibuffer)

  ;; 设定词库文件
  (pyim-wbdict-v98-enable)

  :bind
  ("C-`" . toggle-input-method))

(use-package nyan-mode
  :ensure
  :init
  (setq nyan-bar-length 10)
  
  :config
  (call-when-defined 'nyan-mode 1)
  (call-when-defined 'nyan-start-animation))

(use-package lentic
  :ensure
  :init
  (global-lentic-mode))

(use-package so-long
  :init
  ;; Set the max columns that will trigger so-long mode.
  (setq so-long-threshold 500)

  (add-to-list 'so-long-target-modes 'sql-mode)
  :config
  (so-long-enable))

(use-package toggle-window-split
  :bind
  ("C-x *" . toggle-window-split))

;;; b1-tools.el ends here
