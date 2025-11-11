(use-package clojure-mode
  :bind
  (:map clojure-mode-map
        ("C-c SPC" . nil))

  :config
  (put-clojure-indent 'match 'defun))

(use-package cider
  :ensure
  
  :config
  (defun cider-remove-ns (&optional prompt)
    (interactive "P")
    (when-let ((ns (if prompt
                       (string-remove-prefix "'" (read-from-minibuffer "Namespace: " (cider-get-ns-name)))
                     (cider-get-ns-name))))
      (cider-interactive-eval (format "(remove-ns '%s)" ns))))

  :custom
  (cider-auto-mode nil)
  (cider-save-file-on-load nil)
  (cider-repl-pop-to-buffer-on-connect 'display-only)

  :hook (clojure-mode . cider-mode)

  :bind
  ((:map cider-mode-map
         ("C-c C-c" . 'cider-eval-dwim)
         ("C-c C-l" . 'cider-ns-reload)
         ("C-c C-n" . 'cider-ns-map))
   (:map cider-ns-map
         ("k" . 'cider-remove-ns)
         ("p" . 'cider-load-all-project-ns))))
