(use-package rust-ts-mode
  :ensure
  :mode "\\.rs\\'"

  :config
  (defun rust-mode-setup ()
    "Setup rust mode."
    (eglot-ensure)
    (add-hook 'before-save-hook 'eglot-format-buffer nil t))

  :hook
  (rust-ts-mode . rust-mode-setup)

  :bind
  (:map rust-ts-mode-map
        ("C-c C-b" . #'cargo-process-build)
        ("C-c C-c" . #'cargo-process-clippy)
        ("C-c C-r" . #'cargo-process-run)
        ("C-c C-t" . #'cargo-process-test)
        ("C-c C-a" . #'cargo-process-add)
        ("C-c C-A" . #'cargo-process-rm)
        ("C-c C-d" . #'cargo-process-doc-open)
        ("C-c C-D" . #'cargo-process-doc)
        ("C-c C-p" . #'cargo-process-repeat)
        ("M-<return>" . eglot-code-actions))

  :custom
  ;; Format rust code before save.
  (rust-format-on-save t))

(use-package cargo
  :ensure)

