(use-package python
  :ensure
  :mode ("\\.py\\'" . python-ts-mode)

  :custom
  ;; Use Python 3 instead of Python 2.
  (python-shell-interpreter "python3")

  :bind
  (:map python-ts-mode-map
        ("C-c C-b" . python-shell-send-buffer)
        ("C-c C-c" . python-shell-send-statement)))
