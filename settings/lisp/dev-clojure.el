(use-package clojure-mode)

(use-package cider
  :ensure
  
  :config
  (defun cider-eval-buffer-content ()
    "Eval buffer content without having to save it."
    (interactive)
    (cider-eval-region (point-min) (point-max)))

  :custom
  (cider-auto-mode nil)
  (cider-save-file-on-load nil)
  (cider-repl-pop-to-buffer-on-connect 'display-only)

  :hook (clojure-mode . cider-mode)

  :bind
  ((:map cider-mode-map
         ("C-c C-c" . 'cider-eval-dwim))))
