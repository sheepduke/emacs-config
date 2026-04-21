(use-package typescript-mode
  :ensure

  :preface
  (defun typescript-setup-buffer ()
    (eglot-ensure)
    (setq-local tab-width 2)
    (add-hook 'before-save-hook 'eglot-format-buffer nil t))

  :bind
  (:map typescript-mode-map
        ("C-c C-l" . #'compile)
        ("C-c C-k" . #'recompile))

  :hook
  (typescript-mode . typescript-setup-buffer))

(use-package ts-comint
  :ensure

  :custom
  (ts-comint-program-command "bun")
  (ts-comint-program-arguments '("repl")))
