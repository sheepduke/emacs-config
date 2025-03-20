;; ============================================================
;;  F#
;; ============================================================

;; F# development support.
;; Key bindings in evil settings.
(use-package eglot-fsharp
  :ensure)

(use-package fsharp-mode
  :ensure
  :after eglot-fsharp
  :mode "\\.fs\\'"

  :preface
  (defun fsharp-setup ()
    (interactive)
    (setq yas-indent-line 'fixed)
    (eglot-ensure)
    (add-hook 'before-save-hook #'eglot-format-buffer))

  (defun fsharp-send-buffer ()
    "Send the buffer to REPL."
    (interactive)
    (fsharp-send-snippet (buffer-string)))

  (defun fsharp-send-region-or-line ()
    "Send the active region or current line."
    (interactive)
    (if (region-active-p)
        (fsharp-send-region)
      (fsharp-send-line)))

  (defun fsharp-send-region ()
    "Send the region to REPL."
    (interactive)
    (fsharp-send-snippet (thing-at-point 'region)))

  (defun fsharp-send-line ()
    "Send the line to REPL."
    (interactive)
    (fsharp-send-snippet (thing-at-point 'line)))

  (defun fsharp-send-snippet (snippet)
    (fsharp-send-string snippet)
    (fsharp-send-string ";;\n"))

  (defun fsharp-send-string (raw)
    (comint-send-string inferior-fsharp-buffer-name raw))

  (defun fsharp-clear-repl-buffer ()
    (interactive)
    (with-current-buffer inferior-fsharp-buffer-name
      (comint-clear-buffer)))

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
        ("C-c" . #'major-mode-hydra)
        ("<return>" . #'fsharp-smart-newline)
        ("C-<return>" . #'fsharp-return-and-indent)
        ("M-<return>" . #'fsharp-return-and-unindent)
        ("C-<tab>" . #'fsharp-add-indent)
        ("<backtab>" . #'indent-for-tab-command)
        ("C-M-l" . #'fsharp-clear-repl-buffer))

  :hook
  (fsharp-mode . fsharp-setup))

(major-mode-hydra-define fsharp-mode nil
  ("Eval"
   (("c" fsharp-send-region-or-line "region/line")
    ("b" fsharp-send-buffer "buffer"))
   "REPL"
   (("l" fsharp-clear-repl-buffer "clear"))))

;; ============================================================
;;  C#
;; ============================================================

(use-package csharp-mode
  :init
  (defun csharp-setup-buffer ()
    (eglot-ensure)
    (add-hook 'before-save-hook 'eglot-format-buffer nil t))

  (defun csharp-newline-with-brackets ()
    (interactive)
    (smart-newline)
    (insert "{}")
    (c-indent-line-or-region)
    (backward-char)
    (smart-newline)
    (save-excursion
      (next-line)
      (c-indent-line-or-region)))

  :bind
  (:map csharp-mode-map
        ("C-<return>" . csharp-newline-with-brackets)
        ("M-<return>" . eglot-code-actions))

  :hook
  (csharp-mode . csharp-setup-buffer))

(use-package csproj-mode
  :ensure
  :mode "\\.csproj\\'")

(major-mode-hydra-define csharp-mode nil
  ("Dotnet"
   (("k" recompile))))
