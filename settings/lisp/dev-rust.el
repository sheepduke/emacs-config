(use-package rust-ts-mode
  :mode "\\.rs\\'"

  :config
  (defun rust-mode-setup ()
    "Setup rust mode."
    (set (make-local-variable 'compile-command)
         "cargo check"))

  :hook
  (rust-ts-mode . rust-mode-setup)
  (rust-ts-mode . eglot-ensure)

  :bind
  (:map rust-ts-mode-map
        ("C-c C-b" . recompile)
        ("C-c C-v" . compile))

  :custom
  ;; Format rust code before save.
  (rust-format-on-save t))


(use-package cargo
  :hook
  (rust-ts-mode . cargo-minor-mode))
