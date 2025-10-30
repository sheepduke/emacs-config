(use-package lisp-mode)

(use-package sly
  :ensure
  :after lisp-mode

  :config
  (defun sly-repl-clear-buffer-anywhere ()
    "Clear Sly buffer from anywhere."
    (interactive)
    (dolist (buffer (cl-remove-if-not (lambda (buffer)
                                        (string-prefix-p "*sly-mrepl for"
                                                         (buffer-name buffer)))
                                      (buffer-list)))
      (with-current-buffer buffer
        (sly-mrepl-clear-repl)
        (goto-char (point-max)))))

  ;; Set the location of HyperSpec.
  (load "~/.roswell/lisp/quicklisp/clhs-use-local.el" t)

  :custom
  ;; set common lisp REPL
  (inferior-lisp-program "ros run")

  ;; Use classic completion style.
  (sly-complete-symbol-function 'sly-flex-completions)

  :hook (lisp-mode . sly-editing-mode)

  :bind
  (:map sly-mode-map
        ("C-c D" . sly-delete-package)
        ("C-c C-b" . sly-interrupt)
        ("C-c C-k" . sly-eval-buffer)
        ("C-c C-l" . sly-eval-defun)
        ("C-c C-p" . sly-eval-print-last-expression)
        ("C-c X" . sly-export-class)
        ("C-c C-d d" . hyperspec-lookup)
        ("C-M-l" . sly-repl-clear-buffer-anywhere)))


(use-package sly-repl-ansi-color
  :ensure
  :after sly

  :config
  (push 'sly-repl-ansi-color sly-contribs))

(use-package cl-helper
  :after lisp-mode

  :bind (:map lisp-mode-map
              ("C-c i" . lisp-import-symbol-and-defpackage)
              ("C-c x" . lisp-export-symbol-and-defpackage)
              ("C-c X" . lisp-export-class-and-defpackage)
              ("C-c 5" . lisp-toggle-5am-run-test-when-defined)))
