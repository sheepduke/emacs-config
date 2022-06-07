;;; Package --- Small tools that enhances Emacs

;;; Commentary:

;;; Code:

;; This is built-in in Emacs 24 or something.
;; Used to automatically pair brackets.
(use-package electric
  :config
  (electric-pair-mode 1))


;; Ebuild mode, for Gentoo users.
(use-package ebuild-mode
  :ensure nil
  :mode "\\.use\\'"
  :mode "\\.mask\\'"
  :mode "\\.unmask\\'")


;; Make undo like a tree.
(use-package undo-tree
  :delight

  :config
  (global-undo-tree-mode)

  :bind (("C-/" . undo-tree-undo)
         ("C-?" . undo-tree-redo)
         ("C-x u" . undo-tree-visualize))

  :custom
  ;; Show diffs when browsing through the undo tree
  (undo-tree-visualizer-diff t)

  ;; Don't show relative times in the undo tree visualizer
  (undo-tree-visualizer-timestamps nil)

  ;; Don't save history to a file
  (undo-tree-auto-save-history nil))


;; Replace the original doc-view for PDF files.
(use-package pdf-tools
  :functions (windows?)
  :unless (windows?)

  :config
  (pdf-tools-install))


;; Open epub files.
(use-package nov
  :mode ("\\.epub\\'" . nov-mode))


;; Edit multiple places at the same time.
(use-package multiple-cursors
  :bind ("C-x r e" . mc/edit-lines)

  :custom
  (mc/always-run-for-all t))


;; It's Magit! Git inside Emacs.
(use-package magit
  :bind ("C-x v" . magit-status)

  :hook (git-commit-mode . flyspell-mode))


;; Jump to character from 2 leading chars.
(use-package avy
  :bind (("C-'" . avy-goto-char-timer)
         ("M-g g" . avy-goto-line))

  :custom
  ;; Set the timeout to a very short time.
  (avy-timeout-seconds 0.2)
  ;; Do not directly jump to the only candidate.
  (avy-single-candidate-jump nil))


;; Automatically compile Emacs Lisp libraries
(use-package auto-compile
  :config
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode))


;; Execute asynchronous commands.
(use-package async
  :config
  (dired-async-mode 1)
  (async-bytecomp-package-mode 1)

  :custom
  ;; Compile packages asynchronously.
  (async-bytecomp-allowed-packages '(all)))

(use-package openwith
  :hook
  (dired-mode . openwith-mode)

  :config
  (define-advice abort-if-file-too-large
      (:around (orig-fn size op-type filename &optional offer-raw) unless-openwith-handles-it)
    "Do not abort if FILENAME is handled by Openwith."
    (let ((my-ok-large-file-types (mapconcat 'car openwith-associations "\\|")))
      (unless (string-match-p my-ok-large-file-types filename)
        (funcall orig-fn size op-type filename offer-raw))))

  :custom
  (openwith-associations '(("\\.mp4\\'" "mpv" (file))
                           ("\\.m4v\\'" "mpv" (file)))))

;; Emacs interface for `cheat.sh'.
(use-package cheat-sh)


;; Provides extra information for EShell prompt.
(use-package eshell-prompt-extras
  :custom
  ;; Setup prompt.
  (eshell-highlight-prompt t)
  (eshell-prompt-function 'epe-theme-lambda))


;; Disable font displaying effects when the lines are too long,
(use-package so-long
  :custom
  ;; Set the max columns that will trigger so-long mode.
  (so-long-threshold 500)
  
  :config
  (global-so-long-mode))


;; Toggle layout of 2 windows between vertical and horizontal.
(use-package toggle-window-split
  :ensure nil
  :bind ("C-x *" . toggle-window-split))

;; Show hot keys when prefix keys are pressed.
(use-package which-key
  :delight

  :config
  (which-key-mode 1)

  :custom
  (which-key-idle-delay 0.5))

;; AutoHotkey mode.
;; Only for Windows.
(use-package ahk-mode)

;;; b1-tools.el ends here
