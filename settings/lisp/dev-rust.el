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
        ("C-c" . nil)
        ("M-<return>" . eglot-code-actions))

  :custom
  ;; Format rust code before save.
  (rust-format-on-save t))

(use-package cargo
  :ensure)

(major-mode-hydra-define rust-ts-mode nil
  ("Eglot"
   (("e" eglot "eglot")
    ("E" eglot-shutdown "shutdown")
    ("n" eglot-rename "rename"))

   "Common"
   (("p" cargo-process-repeat "repeat")
    ("w" cargo-process-watch "watch"))
   
   "Crate"
   (("a" cargo-process-add "add")
    ("m" cargo-process-rm "remove"))
   
   "Build"
   (("b" cargo-process-build "build")
    ("c" cargo-process-clippy "clippy")
    ("k" cargo-process-clean "clean"))
   
   "Test & Run"
   (("r" cargo-process-run "run")
    ("t" cargo-process-test "test"))
   
   "Document"
   (("d" cargo-process-doc-open "open")
    ("D" cargo-process-doc "build"))))
