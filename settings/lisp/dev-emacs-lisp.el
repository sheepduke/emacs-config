(use-package emacs-lisp-mode
  :bind
  (:map emacs-lisp-mode-map
        ("C-c C-r" . eval-region)
        ("C-c C-k" . eval-buffer)))

(use-package nameless
  :ensure
  :hook
  (emacs-lisp-mode . nameless-mode)

  :bind ((:map nameless-mode-map
               ("C-c" . nil)
               ("_" . nameless-insert-name-or-self-insert)))
  
  :custom
  (nameless-prefix "@")
  (nameless-private-prefix t))
