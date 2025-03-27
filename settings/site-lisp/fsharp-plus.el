(defvar fsharp-repl-init-filename "Repl.fs"
  "The name of REPL init file.")

(defun run-fsharp-restart ()
  "Run fsi and restart it if needed."
  (interactive)
  (when (and (get-buffer inferior-fsharp-buffer-name)
             (comint-check-proc inferior-fsharp-buffer-name)) 
    (fsharp-send-snippet "#quit"))

  (while (comint-check-proc inferior-fsharp-buffer-name)
    (sleep-for 0.1))
  
  (fsharp-run-process-if-needed inferior-fsharp-program))

(defun fsharp-reload-repl ()
  (interactive)
  (let ((dir (locate-dominating-file "." fsharp-repl-init-filename)))
    (if dir
        (with-temp-buffer
          (insert-file-contents (expand-file-name fsharp-repl-init-filename dir))
          (fsharp-send-buffer))
      (error "No '%s' file found" fsharp-repl-init-filename))))

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

(provide 'fsharp-plus)
