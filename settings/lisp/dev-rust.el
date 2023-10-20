(use-package rust-ts-mode
  :mode "\\.rs\\'"

  :config
  (defun rust-mode-setup ()
    "Setup rust mode."
    (set (make-local-variable 'compile-command)
         "cargo test"))

  :hook
  (rust-mode . rust-mode-setup)

  :bind
  (:map rust-mode-map
        ("C-c C-b" . recompile)
        ("C-c C-v" . compile))

  :custom
  ;; Format rust code before save.
  (rust-format-on-save t))


(use-package cargo
  :hook
  (rust-mode . cargo-minor-mode))
