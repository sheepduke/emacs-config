(use-package haskell-mode
  :mode "\\.hs\\'"

  :init
  (defun interactive-haskell-do-eval ()
    "Evaluate the current expression in Haskell REPL."
    (with-current-buffer (haskell-session-interactive-buffer (haskell-session))
      (haskell-interactive-handle-expr)))
  
  (defun interactive-haskell-eval-current-line ()
    "Evaluate current line."
    (interactive)
    (haskell-interactive-copy-to-prompt)
    (interactive-haskell-do-eval))

  (defun interactive-haskell-run-r ()
    "Run the function defined as 'r'."
    (interactive)
    (with-current-buffer (haskell-session-interactive-buffer (haskell-session))
      (insert "r\n")
      (haskell-interactive-mode-return)))

  :config
  (require 'haskell)

  :bind
  (:map interactive-haskell-mode-map
        ("C-c C-b" . haskell-process-reload)
        ("C-c C-c" . interactive-haskell-eval-current-line)
        ("C-c C-l" . interactive-haskell-run-r)
        ("C-c C-o" . haskell-interactive-switch))

  :bind
  (:map haskell-interactive-mode-map
        ("C-c C-o" . haskell-interactive-switch-back)))
