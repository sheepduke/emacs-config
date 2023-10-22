;; F# development support.
;; Key bindings in evil settings.
(use-package fsharp-mode
  :mode "\\.fs\\'"

  :preface
  (defun fsharp-setup ()
    (interactive)
    (setq yas-indent-line 'fixed))
  
  (defun fsharp-eval-buffer ()
    (interactive)
    (fsharp-eval-region (point-min) (point-max)))

  (defun fsharp-format-buffer()
    (interactive)
    (when (equal major-mode 'fsharp-mode)
      (lsp-format-buffer)))

  (defun fsharp-smart-newline ()
    (interactive)
    (let* ((line-content (thing-at-point 'line))
           (line-length (length line-content))
           (char-content (thing-at-point 'char t)))
      (cond
       ;; For an empty line, just indent it.
       ((string-empty-p (string-trim line-content))
        (insert "\n")
        (insert (make-string (1- (length line-content)) ?\s)))
       ;; When cursor is in {|}, create new line and indent corresponding lines.
       ((or (and (string-match-p "\\{\\}" line-content)
                 (string= char-content "}"))
            (and (string-match-p "\\[\\]" line-content)
                 (string= char-content "]")))
        (delete-char 1)
        (insert "\n")
        (insert (make-string (+ line-length 2) ?\s))
        (insert "\n")
        (insert (make-string (- line-length 3) ?\s))
        (insert char-content)
        (previous-line)
        (end-of-line))
       (t (smart-newline)))))

  (defun fsharp-return-and-indent ()
    (interactive)
    (smart-newline)
    (insert "    "))
 
  (defun fsharp-return-and-unindent ()
    (interactive)
    (smart-newline)
    (backward-delete-char 4))

  (defun fsharp-add-indent ()
    (interactive)
    (insert "    "))

  :bind
  (:map fsharp-mode-map
        ("<return>" . fsharp-smart-newline)
        ("C-<return>" . fsharp-return-and-indent)
        ("M-<return>" . fsharp-return-and-unindent)
        ("C-<tab>" . #'fsharp-add-indent)
        ("<backtab>" . #'indent-for-tab-command))

  :hook
  (fsharp-mode . fsharp-setup)
  (fsharp-mode . lsp)
  (before-save . fsharp-format-buffer))

(use-package csproj-mode
  :mode "\\.csproj\\'")
