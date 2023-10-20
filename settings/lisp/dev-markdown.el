(use-package markdown-mode
  :mode "\\.md\\'"
  
  :commands (w3m-reload-all-pages)
  
  :config
  (defun markdown-mode-setup ()
    (add-hook 'after-save-hook 'markdown-live-preview-w3m-reload))

  (defun markdown-live-preview-window-w3m (file)
    "Use w3m to preview Markdown buffer."
    (cond
     ((require 'w3m nil t)
      (w3m-find-file file)
      (get-buffer "*w3m*"))
     (t (error "Package w3m not available"))))

  (defun markdown-live-preview-w3m-reload ()
    "Reload generated HTML."
    (when (and markdown-live-preview-mode
               (get-buffer "*w3m*"))
      (w3m-reload-all-pages)))

  :custom
  ;; Use pandoc as markdown generator.
  (markdown-command "pandoc")
  
  ;; Use w3m to preview markdown.
  (markdown-live-preview-window-function 'markdown-live-preview-window-w3m)

  :hook ((markdown-mode . flyspell-mode)
         (markdown-mode . toggle-word-wrap)
         (markdown-mode . markdown-mode-setup)))


(use-package poly-markdown
  :after markdown-mode

  :config
  (remove-hook 'markdown-mode-hook 'poly-markdown-mode))


(use-package flymd
  :after markdown-mode

  :custom
  (flymd-output-directory "/tmp/"))

(use-package markdown-toc
  :after markdown-mode

  :bind (:map markdown-mode-map
              ("C-c =" . markdown-toc-generate-or-refresh-toc)))
