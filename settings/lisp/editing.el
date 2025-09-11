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
  (save-place-mode 1)

  ;; Highlight the current line.
  (global-hl-line-mode 1))

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
  :ensure
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
  :ensure
  :custom
  (mc/always-run-for-all t))

(use-package avy
  :ensure)

(use-package indent-guide
  :ensure
  :demand t
  :delight ""
  
  :hook
  (prog-mode . indent-guide-mode))

;; ============================================================
;;  Spell Checking
;; ============================================================

(use-package flyspell
  :delight " FS"

  :custom
  (ispell-alternate-dictionary (expand-file-name (locate-user-data-file "hunspell/en_US.dic")))

  :bind
  (:map flyspell-mode-map
        ("C-;" . nil))

  :config
  (add-hook 'prog-mode-hook 'flyspell-prog-mode))

;;; Windows specific settings.
(use-package flyspell
  :if (windows?)

  :init
  ;; Tell it which dictionary to use.
  (setenv "LANG" "en_US")

  ;; Use Hunspell as the spell checker.
  (setq ispell-program-name "hunspell")

  ;; Provide the dictionary path.
  ;; 
  ;; Note that the easiest way on Windows is to just put dictionaries
  ;; under C:/Hunspell directory.
  (setq ispell-hunspell-dict-paths-alist
        `(("en_US" "C:/hunspell/en_US.aff"))))
