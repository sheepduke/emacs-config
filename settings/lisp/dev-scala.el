(use-package scala-mode
  :mode "\\.scala\\'"
  :mode "\\.sc\\'")

(use-package lsp-metals
  :after scala-mode
  
  :preface
  (defun lsp-metals-setup-hooks ()
    (add-hook 'before-save-hook 'lsp-organize-imports)
    (add-hook 'before-save-hook 'lsp-format-buffer))

  :custom
  (lsp-metals-server-args '("-J-Dmetals.allow-multiline-string-formatting=off"))

  :hook
  (scala-mode . lsp)
  (scala-mode . lsp-metals-setup-hooks))

(use-package sbt-mode)

(use-package sbt-anywhere
  :after (sbt scala-mode)
  
  :bind (:map scala-mode-map
              ("C-c C-l" . sbt-anywhere-enter-repl)
              ("C-c C-o" . sbt-anywhere-leave-repl)
              ("C-c C-c" . sbt-anywhere-send-line)
              ("C-c C-r" . sbt-anywhere-send-region)
              ("C-c C-b" . sbt-anywhere-send-buffer)
              ("C-c c c" . sbt-do-compile)
              ("C-c c t" . sbt-do-test)
              ("C-c c r" . sbt-do-run)
              ("C-c c l" . sbt-do-clean)
              ("C-c c p" . sbt-do-package)
              ("C-c c s" . sbt-anywhere-do-restart)
              ("C-c c a" . sbt-anywhere-do-assembly)
              ("C-M-l" . sbt-clear)))
