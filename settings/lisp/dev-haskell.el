(use-package haskell-mode
  :functions (haskell-session-interactive-buffer
              haskell-interactive-handle-expr
              haskell-interactive-copy-to-prompt)

  :preface
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

  (defun haskell-setup-hooks ()
    (interactive-haskell-mode 1)
    (let ((mode-map (symbol-value 'interactive-haskell-mode-map))
          (repl-mode-map (symbol-value 'haskell-interactive-mode-map)))
      (define-key mode-map (kbd "C-c C-c") 'interactive-haskell-eval-current-line)
      (define-key mode-map (kbd "C-c C-o") 'interactive-haskell-run-r)
      (define-key repl-mode-map (kbd "C-c C-b") 'haskell-interactive-switch-back))
    (highlight-indent-guides-mode 0))

  :init
  (require 'haskell-interactive-mode)
  
  :hook
  (haskell-mode . haskell-setup-hooks))
