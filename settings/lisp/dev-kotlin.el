(use-package kotlin-mode
  :ensure

  :preface
  (defun kotlin-mode-setup ()
    (when (linux?)
      (eglot-ensure)
      (add-hook 'before-save-hook 'eglot-format-buffer nil t)))

  :config
  (require 'gradle)

  :hook
  (kotlin-mode . kotlin-mode-setup)

  :bind
  (:map kotlin-mode-map
        ("C-c C-k" . gradle-run)
        ("C-c C-c" . gradle-select-task)))

