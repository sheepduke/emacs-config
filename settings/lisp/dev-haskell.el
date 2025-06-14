(use-package haskell-mode
  :ensure
  :mode "\\.hs\\'"

  :init
  (defun haskell-process-eval-string (string)
    "Evaluate given string in REPL."
    (with-current-buffer (haskell-session-interactive-buffer (haskell-session))
      (insert string)
      (haskell-interactive-handle-expr)))

  (defun haskell-process-eval-line ()
    "Evaluate current line."
    (interactive)
    (haskell-process-eval-string 
     (string-trim (thing-at-point 'line))))

  (defun haskell-process-eval-region ()
    "Evaluate current active region."
    (interactive)
    (haskell-process-eval-string 
     (string-trim (thing-at-point 'region))))

  (defun haskell-process-eval-dwim ()
    "Evaluate a region or the current line."
    (interactive)
    (if (region-active-p)
        (haskell-process-eval-region)
      (haskell-process-eval-line)))

  (defun haskell-mode-setup ()
    (interactive)
    ;; Set up eglot.
    (setq eglot-workspace-configuration
          '(:haskell (:plugin (:stan (:globalOn t))
                              :formattingProvider "ormolu")))
    (eglot-ensure)
    (add-hook 'before-save-hook #'eglot-format-buffer nil t)
    (unbind-key (kbd "C-c") haskell-mode-map))

  (remove-hook 'haskell-mode-hook 'interactive-haskell-mode)

  :config
  (require 'haskell)

  (setq interactive-haskell-mode-map (make-sparse-keymap))

  (major-mode-hydra-define haskell-mode nil
    ("REPL"
     (("c" haskell-process-eval-dwim "eval")
      ("l" haskell-process-load-file "load"))

     "Editing"
     (("r" eglot-rename "rename")
      ("f" haskell-mode-format-imports "format imports"))
     
     "Other"
     (("a" haskell-process-cabal "cabal")
      ("i" haskell-process-do-info "info"))))

  :hook
  (haskell-mode . haskell-mode-setup)

  :bind
  (:map interactive-haskell-mode
        ("M-RET" . eglot-code-actions)
        ("C-M-l" . haskell-interactive-mode-clear)))
