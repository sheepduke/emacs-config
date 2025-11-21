;;; Setup
;;; 1. Install roswell
;;; 2. Run roswell install
;;; 3. Run (ql:quickload "clhs")
;;; 4. Run (ql:quickload "cl-project")

(use-package lisp-mode)

(use-package sly
  :ensure

  :init
  (defun sly-mrepl-clear-repl-remotely ()
    (interactive)
    (with-current-buffer (sly-mrepl--find-buffer (sly-current-connection))
      (sly-mrepl-clear-repl)))

  (defun sly-mrepl-clear-recent-output-remotely ()
    (interactive)
    (with-current-buffer (sly-mrepl--find-buffer (sly-current-connection))
      (sly-mrepl-clear-recent-output)))

  :config
  ;; Requires (ql:quickload "clhs")
  (setq common-lisp-hyperspec-root
        "file:///home/sheep/.roswell/lisp/quicklisp/dists/quicklisp/software/clhs-0.6.3/HyperSpec/")

  :custom
  (inferior-lisp-program "ros run")

  :bind
  (:map sly-mode-map
        ("C-c C-o" . 'sly-mrepl-clear-repl-remotely)
        ("C-c C-e" . nil)
        ("C-c C-e e" . 'sly-export-symbol-at-point)
        ("C-c C-e c" . 'sly-export-class))
  
  (:map sly-editing-mode-map
        ("C-c C-k" . 'sly-eval-buffer)
        ("C-c C-l" . 'sly-compile-and-load-file)
        ("M-n" . nil)
        ("M-p" . nil)))

(use-package sly-quicklisp
  :ensure
  :after sly)

(use-package sly-asdf
  :ensure
  :after sly

  :bind
  (:map sly-mode-map
        ("C-c C-a l" . 'sly-asdf-load-system)
        ("C-c C-a t" . 'sly-asdf-test-system)))

(use-package sly-repl-ansi-color
  :ensure
  :after sly

  :config
  (add-to-list 'sly-contribs 'sly-repl-ansi-color 'append))
