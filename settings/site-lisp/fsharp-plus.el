(require 'xml)

;; ============================================================
;;  Evaluation
;; ============================================================

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

;; ============================================================
;;  Editing
;; ============================================================

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

(defun fsharp-inc-indent ()
  (interactive)
  (insert (make-string fsharp-indent-offset ?\s)))

(defun fsharp-dec-indent ()
  (interactive)
  (backward-delete-char fsharp-indent-offset))

;; ============================================================
;;  Fsproj Loading
;; ============================================================

(defun fsproj--map-elements (fsproj element f)
  (with-temp-buffer
    (insert-file-contents fsproj)
    (let* ((project (car (xml-parse-region (point-min) (point-max))))
           (groups (xml-get-children project 'ItemGroup))
           (result ""))
      (dolist (group groups result)
        (dolist (node (xml-get-children group element))
          (setq result
                (concat result (funcall f node) "\n")))))))

(defun fsharp-fsproj-packages (fsproj)
  (fsproj--map-elements
   fsproj
   'PackageReference
   (lambda (node)
     (format "#r \"nuget:%s\""
             (xml-get-attribute node 'Include)))))

(defun fsharp-fsproj-files (fsproj)
  (let ((base-dir (file-name-directory (expand-file-name fsproj))))
    (fsproj--map-elements
     fsproj
     'Compile
     (lambda (node)
       (format "#load \"%s\""
               (expand-file-name
                (xml-get-attribute node 'Include)
                base-dir))))))

(defun fsharp-fsproj-load-packages ()
  (interactive)
  (let ((fsproj (fsharp-mode/find-sln-or-fsproj (project-get-root-dir))))
    (fsharp-send-snippet (fsharp-fsproj-packages fsproj))))

(defun fsharp-fsproj-load-files ()
  (interactive)
  (let ((fsproj (fsharp-mode/find-sln-or-fsproj (project-get-root-dir))))
    (fsharp-send-snippet (fsharp-fsproj-files fsproj))))

(provide 'fsharp-plus)
