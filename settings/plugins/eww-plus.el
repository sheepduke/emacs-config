;;; Package --- eww-plus

;;; Commentary:
;;; Provide more functions to the built-in eww browser.

;;; Code:

(require 'eww)

(defun eww-is-eww-buffer (buffer)
  "Return T if given BUFFER is a eww buffer."
  (with-current-buffer buffer
    (derived-mode-p 'eww-mode)))

(defun eww-buffer-list ()
  "Return a list of EWW buffers.
Each element is a plist that contains keys: (:buffer :title :url)."
  (cl-loop for buffer in (buffer-list)
           when (eww-is-eww-buffer buffer)
           collect (with-current-buffer buffer
                     (list :buffer buffer
                           :title (cl-getf eww-data :title)
                           :url (cl-getf eww-data :url)))))

(defun eww-switch-buffer ()
  "Interactively select buffer using COMPLETING-READ."
  (interactive)
  (let* ((eww-buffer-list (eww-buffer-list)))
    (cond
     ((not eww-buffer-list) (message "No eww buffer"))
     (t
      (let* ((choice (completing-read
                      "Choose eww Buffer: "
                      (mapcar (lambda (data)
                                (format "[%d] %s - %s"
                                        (eww--buffer-to-number (cl-getf data :buffer))
                                        (cl-getf data :title)
                                        (cl-getf data :url)))
                              eww-buffer-list)))
             (buffer (eww--choice-to-buffer choice)))
        (when (buffer-live-p buffer)
          (switch-to-buffer buffer)))))))

(defun eww--buffer-to-number (buffer)
  "Return the number part in eww BUFFER name."
  (let* ((name (buffer-name (get-buffer buffer)))
         (start (string-match "[0-9]+" name)))
    (if start
        (string-to-number (substring name start (length name)))
      1)))

(defun eww--number-to-buffer (number)
  "Return the buffer from its prefix NUMBER."
  (get-buffer (concat "*eww*"
                      (if (> number 1)
                          (format "<%d>" number)
                        ""))))

(defun eww--choice-to-buffer (choice)
  "Return corresponding buffer from CHOICE."
  (eww--number-to-buffer
   (string-to-number
    (substring choice 1 (string-match "\]" choice)))))

(defun eww--kill-buffer-from-select (choice)
  "Kill corresponding buffer according to CHOICE."
  (kill-buffer (eww--choice-to-buffer choice)))

(defun eww-browse-url-new-buffer (url &optional new-window)
  "Browse given URL using eww in a new buffer with NEW-WINDOW setting."
  (eww-rename-eww-buffer)
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
  (eww-rename-eww-buffer)
  (eww url))

(defun eww-rename-eww-buffer ()
  "Rename buffer `*eww*' to a new name according to the index."
  (let ((eww-buffer (get-buffer "*eww*")))
    (when eww-buffer
      (with-current-buffer eww-buffer
        (rename-buffer (generate-new-buffer-name "*eww*"))))))

(when (require 'ivy nil t)
  (ivy-set-actions
   'eww-select-buffer
   '(("k"
      eww--kill-buffer-from-select
      "kill"))))

(provide 'eww-plus)
;;; eww-plus.el ends here
