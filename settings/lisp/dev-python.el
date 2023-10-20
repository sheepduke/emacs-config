(use-package python
  :custom
  ;; Use Python 3 instead of Python 2.
  (python-shell-interpreter "python3"))


;; For setup elpy, run:
;; pip install jedi flake8 autopep8
(use-package elpy
  :disabled
  :after python

  :config
  (defun elpy-shell-send-current-line ()
    "Send current line to Python shell."
    (interactive)
    (python-shell-send-string (thing-at-point 'line)))

  (elpy-enable)

  :hook
  (elpy-mode . (lambda () (highlight-indentation-mode -1)))

  :bind
  (:map elpy-mode-map
        ("C-c C-p" . run-python)
        ("C-c C-r" . 'elpy-shell-send-region-or-buffer)
        ("C-c C-b" . elpy-shell-send-region-or-buffer)
        ("C-c C-c" . elpy-shell-send-current-line))

  :custom
  (elpy-rpc-python-command "python3"))
