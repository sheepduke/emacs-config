;;; Package --- Small tools that enhances Emacs

;;; Commentary:

;;; Code:

;; This is built-in in Emacs 24 or something.
;; Used to automatically pair brackets.
(use-package electric
  :config
  (electric-pair-mode 1))

;; Make undo like a tree.
(use-package undo-tree
  :delight

  :config
  (global-undo-tree-mode 1)

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
  :defer t
  :unless (windows?)

  :config
  (pdf-tools-install))


;; Open epub files.
(use-package nov
  :mode ("\\.epub\\'" . nov-mode))


;; It's Magit! Git inside Emacs.
(use-package magit
  :bind ("C-x v" . magit-status)

  :hook (git-commit-mode . flyspell-mode))


;; Show hot keys when prefix keys are pressed.
(use-package which-key
  :delight

  :config
  (which-key-mode 1)

  :custom
  (which-key-idle-delay 0.5))

;; Manage buffers and window layouts into dynamic workspaces.
(use-package perspective
  :defer nil

  :preface
  (defun persp-start-and-load ()
    (persp-mode 1)
    (persp-state-load persp-state-default-file))

  (defun persp-switch-to-1 ()
    (interactive)
    (persp-switch-by-number 1))

  (defun persp-switch-to-2 ()
    (interactive)
    (persp-switch-by-number 2))

  (defun persp-switch-to-3 ()
    (interactive)
    (persp-switch-by-number 3))

  (defun persp-switch-to-4 ()
    (interactive)
    (persp-switch-by-number 4))

  (defun persp-switch-to-5 ()
    (interactive)
    (persp-switch-by-number 5))

  (defun persp-switch-to-6 ()
    (interactive)
    (persp-switch-by-number 6))

  (defun persp-switch-to-7 ()
    (interactive)
    (persp-switch-by-number 7))

  (defun persp-switch-to-8 ()
    (interactive)
    (persp-switch-by-number 8))

  (defun persp-switch-to-9 ()
    (interactive)
    (persp-switch-by-number 9))

  :custom
  (persp-mode-prefix-key (kbd "C-c p"))

  ;; The default name of frame.
  (persp-initial-frame-name "1. main")

  ;; Method used to sort perspectives.
  (persp-sort 'name)

  ;; File used to load and save state file.
  (persp-state-default-file "~/.emacs.d/data/perspective.dat"))

(use-package multiple-cursors
  :custom
  (mc/always-run-for-all t))

;; Function to show a dedicated sidebar for dired.
(use-package dired-sidebar)

;;; b1-tools.el ends here
