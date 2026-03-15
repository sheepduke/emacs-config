(use-package emacs-lisp-mode
  :bind
  (:map emacs-lisp-mode-map
        ("C-c C-r" . eval-region)
        ("C-c C-k" . eval-buffer)))

(use-package nameless
  :ensure

  :bind ((:map nameless-mode-map
               ("C-c" . nil)
               ("_" . #'nameless-insert-name-or-self-insert))
         (:map emacs-lisp-mode-map
               ("_" . #'nameless-insert-name-or-self-insert)))
  
  :custom
  (nameless-prefix ":")
  (nameless-private-prefix t))
