;;; Package --- eww-plus

;;; Commentary:
;;; Provide more functions to the built-in eww browser.

;;; Code:

(require 'eww)

(defun eww-browse-url-new-buffer (url &optional new-window)
  "Browse given URL using eww in a new buffer with NEW-WINDOW setting."
  (eww-make-new--buffer)
  (eww-browse-url url new-window))

(defun eww-new-buffer (url)
  "Fetch URL and render the page in new buffer.
If the input doesn't look like an URL or a domain name, the
word(s) will be searched for via `eww-search-prefix'."
  (interactive
   (let* ((uris (eww-suggested-uris))
          (prompt (concat "Enter URL or keywords"
                          (if uris (format " (default %s)" (car uris)) "")
                          ": ")))
     (list (read-string prompt nil nil uris))))
  (eww-make-new--buffer)
  (eww url))

(defun eww-make-new--buffer ()
  "Copy buffer *eww* to a new one with name generated according to the index."
  (let ((eww-buffer (get-buffer "*eww*")))
    (when eww-buffer
      (with-current-buffer eww-buffer
        (rename-buffer (generate-new-buffer-name "*eww*")))
      (switch-to-buffer "*eww*")
      (eww-setup-buffer))))

(provide 'eww-plus)
;;; eww-plus.el ends here
