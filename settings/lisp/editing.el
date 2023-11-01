;; ============================================================
;;  Basic Editing
;; ============================================================

(use-package emacs
  :custom
  ;; Set the default tab width to 4.
  (tab-width 4)

  ;; Always use space to do indention.
  (indent-tabs-mode nil)
  
  :config
  ;; Automatically revert modified buffer.
  (global-auto-revert-mode 1)

  ;; Save cursor place of file after exiting Emacs.
  (save-place-mode 1))

(use-package electric
  :config
  ;; Enable auto pairing.
  (electric-pair-mode 1)

  ;; Enable on-the-fly re-indentation.
  (electric-indent-mode 1))

;; ============================================================
;;  Undo
;; ============================================================

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

;; ============================================================
;;  Cursors
;; ============================================================

(use-package multiple-cursors
  :custom
  (mc/always-run-for-all t))

(use-package avy)

(use-package indent-guide
  :demand t
  :delight ""
  
  :hook
  (prog-mode . indent-guide-mode))

;; ============================================================
;;  Spell Checking
;; ============================================================

(use-package flyspell
  :config
  (add-hook 'prog-mode-hook 'flyspell-prog-mode)

  :delight " FS")
