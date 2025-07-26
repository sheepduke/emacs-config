(use-package rust-ts-mode
  :ensure
  :mode "\\.rs\\'"

  :config
  (defun rust-mode-setup ()
    "Setup rust mode."
    (eglot-ensure)
    (local-set-key (kbd "C-c") 'rust-mode-menu)
    (add-hook 'before-save-hook 'eglot-format-buffer nil t))

  (transient-define-prefix rust-mode-menu ()
    [["Eglot"
      ("e" "Start" eglot)
      ("E" "Stop" eglot-shutdown)
      ("n" "Rename" eglot-rename)]

     ["Build and Run"
       ("b" "Build" cargo-process-build)
       ("c" "Clippy" cargo-process-clippy)
       ("r" "Run" cargo-process-run)
       ("t" "Test" cargo-process-test)]

     ["Dependency"
      ("a" "Add" cargo-process-add)
      ("R" "Remove" cargo-process-rm)]

     ["Misc"
      ("p" "Repeat" cargo-process-repeat)
      ("d" "Open Doc" cargo-process-doc-open)
      ("D" "Build Doc" cargo-process-doc)]
     ])

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

;; (major-mode-hydra-define rust-ts-mode nil
;;   ("Eglot"
;;    (("e" eglot "eglot")
;;     ("E" eglot-shutdown "shutdown")
;;     ("n" eglot-rename "rename"))

;;    "Common"
;;    (("p" cargo-process-repeat "repeat")
;;     ("w" cargo-process-watch "watch"))
   
;;    "Crate"
;;    (("a" cargo-process-add "add")
;;     ("m" cargo-process-rm "remove"))
   
;;    "Build"
;;    (("b" cargo-process-build "build")
;;     ("c" cargo-process-clippy "clippy")
;;     ("k" cargo-process-clean "clean"))
   
;;    "Test & Run"
;;    (("r" cargo-process-run "run")
;;     ("t" cargo-process-test "test"))
   
;;    "Document"
;;    (("d" cargo-process-doc-open "open")
;;     ("D" cargo-process-doc "build"))))
