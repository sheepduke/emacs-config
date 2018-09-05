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
  :config
  (call-when-defined 'pdf-tools-install))


;; Edit multiple places at the same time.
;; 
(use-package multiple-cursors
  :init
  (setq mc/always-run-for-all t)
  :bind
  ("C-x r e" . mc/edit-lines))


;; It's Magit! Git inside Emacs.
;; 
(use-package magit
  :bind ("C-x v" . magit-status)
  :config
  (add-hook 'git-commit-mode-hook 'flyspell-mode))


;; Jump to character from 2 leading chars.
;; 
(use-package avy
  :bind
  ("M-g M-a" . avy-goto-char-2))


;; Automatically compile Emacs Lisp libraries
;; 
(use-package auto-compile
  :config
  (call-when-defined 'auto-compile-on-load-mode)
  (call-when-defined 'auto-compile-on-save-mode))


;; Execute asynchronous commands.
;; 
(use-package async
  :config
  (dired-async-mode 1))


;; Provides more features.
;; 
(use-package dired+
  :config
  ;; Show image thumb in tooltip.
  (setq diredp-image-preview-in-tooltip 300)
  ;; Just show me all the information.
  (setq diredp-hide-details-initially-flag nil)
  (setq diredp-hide-details-propagate-flag nil))


;; Built-in input method.
;; 
(use-package pyim
  :init
  (require 'pyim)
  
  :config
  (use-package pyim-basedict
	:config
	(call-when-defined 'pyim-basedict-enable))

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
  (pyim-wbdict-gbk-enable)

  :bind
  ("C-`" . toggle-input-method))

(use-package nyan-mode
  :init
  (setq nyan-bar-length 20)
  
  :config
  (call-when-defined 'nyan-mode 1))

(use-package zone
  :config
  (call-when-defined 'zone-when-idle 600))

(use-package so-long
  :init
  ;; Set the max columns that will trigger so-long mode.
  (setq so-long-threshold 500)

  (add-to-list 'so-long-target-modes 'sql-mode)
  :config
  (so-long-enable))

(use-package toggle-window-split
  :bind
  ("C-c t s" . toggle-window-split))

;;; b1-tools.el ends here
