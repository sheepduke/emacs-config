;; ============================================================
;;  Lisp
;; ============================================================

(use-package paredit
  :delight "")

;; ============================================================
;;  Emacs Lisp
;; ============================================================

(use-package emacs-lisp-mode
  :mode "\\.el\\'"
  
  :bind
  (:map emacs-lisp-mode-map
        ("C-c C-r" . eval-region)
        ("C-c C-b" . eval-buffer))

  :hook
  (emacs-lisp-mode . paredit-mode))

(use-package nameless
  :hook
  (emacs-lisp-mode . nameless-mode)

  :bind ((:map nameless-mode-map
               ("-" . nameless-insert-name-or-self-insert)))
  
  :custom
  (nameless-prefix "@")
  (nameless-private-prefix t))

(use-package major-mode-hydra
  :config
  (major-mode-hydra-define emacs-lisp-mode nil
    ("Eval"
     (("b" eval-buffer "buffer")
      ("e" eval-defun "defun")
      ("r" eval-region "region"))
     
     "REPL"
     (("I" ielm "ielm"))
     
     "Test"
     (("t" ert "prompt")
      ("T" (ert t) "all")
      ("F" (ert :failed) "failed"))
     
     "Describe"
     (("d" describe-foo-at-point "thing-at-pt")
      ("f" describe-function "function")
      ("v" describe-variable "variable")
      ("i" info-lookup-symbol "info lookup")))))

;; ============================================================
;;  Common Lisp
;; ============================================================

(use-package lisp-mode
  :mode "\\.lisp\\'"
  
  :hook
  (lisp-mode . paredit-mode))

(use-package sly
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
        ("C-c C-k" . sly-interrupt)
        ("C-c C-b" . sly-eval-buffer)
        ("C-c C-l" . sly-eval-defun)
        ("C-c C-p" . sly-eval-print-last-expression)
        ("C-c X" . sly-export-class)
        ("C-c C-d d" . hyperspec-lookup)
        ("C-M-l" . sly-repl-clear-buffer-anywhere)))


(use-package sly-repl-ansi-color
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Clojure                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package cider
  :mode "\\.clj\\'"
  
  :config
  (defun cider-eval-buffer-content ()
    "Eval buffer content without having to save it."
    (interactive)
    (cider-eval-region (point-min) (point-max)))

  :hook (clojure-mode . cider-mode)

  :bind ((:map cider-mode-map
               ("C-c C-b" . cider-eval-buffer-content)
               ("C-c C-r" . cider-eval-region)
               ("C-c C-l" . cider-eval-defun-at-point)
               ("C-c C-k" . cider-interrupt)
               ("C-M-l" . cider-find-and-clear-repl-output))
         (:map cider-repl-mode-map
               ("C-M-l" . cider-repl-clear-buffer))))
