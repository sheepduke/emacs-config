(use-package rust-ts-mode
  :ensure
  :mode "\\.rs\\'"

  :config
  (defun rust-mode-setup ()
    "Setup rust mode."
    (set (make-local-variable 'compile-command)
         "CARGO_INCREMENTAL=0 cargo test")
    (add-hook 'before-save-hook 'eglot-format-buffer nil t)
    (eglot-ensure))

  :hook
  (rust-ts-mode . rust-mode-setup)

  :bind
  (:map rust-ts-mode-map
        ("C-c C-b" . recompile)
        ("C-c C-v" . compile))

  :custom
  ;; Format rust code before save.
  (rust-format-on-save t))


(use-package cargo
  :ensure
  :hook
  (rust-ts-mode . cargo-minor-mode))
