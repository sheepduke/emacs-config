;;; Package --- Small tools that enhances Emacs

;;; Commentary:

;;; Code:

;; This is built-in in Emacs 24 or something.
;; Used to automatically pair brackets.
(use-package electric
  :ensure
  :config
  (electric-pair-mode))


;; Ebuild mode, for Gentoo users.
(use-package ebuild-mode
  :mode "\\.use\\'"
  :mode "\\.mask\\'"
  :mode "\\.unmask\\'")


;; Make undo like a tree.
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
(use-package pdf-tools
  :ensure
  :config
  (call-when-defined 'pdf-tools-install))


;; Open epub files.
(use-package nov
  :ensure
  :init
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))


;; Edit multiple places at the same time.
(use-package multiple-cursors
  :ensure
  :init
  (setq mc/always-run-for-all t)
  :bind
  ("C-x r e" . mc/edit-lines))


;; It's Magit! Git inside Emacs.
(use-package magit
  :ensure
  :bind ("C-x v" . magit-status)
  :config
  (add-hook 'git-commit-mode-hook 'flyspell-mode))


;; Jump to character from 2 leading chars.
(use-package avy
  :ensure

  :init
  ;; Set the timeout to a very short time.
  (setq avy-timeout-seconds 0.2)

  :bind
  ("C-'" . avy-goto-char-timer)
  ("M-g g" . avy-goto-line))


;; Automatically compile Emacs Lisp libraries
(use-package auto-compile
  :ensure
  :config
  (call-when-defined 'auto-compile-on-load-mode)
  (call-when-defined 'auto-compile-on-save-mode))


;; Execute asynchronous commands.
(use-package async
  :ensure
  :init
  (dired-async-mode 1)
  
  ;; Compile packages asynchronously.
  (setq async-bytecomp-allowed-packages '(all))
  (async-bytecomp-package-mode 1))


;; Built-in input method.
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
  ;; 作为五笔用户，我觉得自己完全不需要选词框。
  (setq pyim-page-tooltip 'minibuffer)
  ;; 同上，取消词库。
  (setq pyim-dcache-auto-update nil)

  ;; 设定词库文件
  (pyim-wbdict-v98-enable)

  :bind
  ("C-`" . toggle-input-method))


;; Show Nyan cat in progress bar.
(use-package nyan-mode
  :ensure
  :init
  (setq nyan-bar-length 10)
  
  :config
  (call-when-defined 'nyan-mode 1)
  (call-when-defined 'nyan-start-animation))


;; Emacs interface for `cheat.sh'.
(use-package cheat-sh
  :ensure)


;; Provides extra information for EShell prompt.
(use-package eshell-prompt-extras
  :ensure
  :init
  ;; Setup prompt.
  (setq eshell-highlight-prompt t
        eshell-prompt-function 'epe-theme-lambda))


;; Disable font displaying effects when the lines are too long,
(use-package so-long
  :init
  ;; Set the max columns that will trigger so-long mode.
  (setq so-long-threshold 500)

  (add-to-list 'so-long-target-modes 'sql-mode)
  :config
  (so-long-enable))


;; Toggle layout of 2 windows between vertical and horizontal.
(use-package toggle-window-split
  :bind
  ("C-x *" . toggle-window-split))


;;; b1-tools.el ends here
