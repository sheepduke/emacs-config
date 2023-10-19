(cl-defun insert-comment-block (comment-char &optional (comment-char-count 2))
  "Return a block with COMMENT inside."
  (interactive)
  (let* ((comment (read-string "Comment: "))
         (comment-length (length comment))
         (comment-line-length 70)
         (comment-length-with-space (- comment-line-length
                                       (* comment-char-count 2)
                                       comment-length))
         (length-before-comment (/ comment-length-with-space 2))
         (length-after-comment (- comment-length-with-space length-before-comment)))
    (format "%s\n%s%s%s%s%s\n%s"
            (make-string comment-line-length comment-char)
            (make-string comment-char-count comment-char)
            (make-string length-before-comment ? )
            comment
            (make-string length-after-comment ? )
            (make-string comment-char-count comment-char)
            (make-string comment-line-length comment-char))))

(defun windows? ()
  "Return T if current OS is Windows."
  (equal system-type 'windows-nt))

(defun wsl? ()
  "Return T if current OS is WSL(2)."
  (string-match "-[Mm]icrosoft" (shell-command-to-string "uname -a")))

(defun x? ()
  "Return TRUE if we are under X system."
  (getenv "DISPLAY"))

(defun locate-user-data-file (new-name &optional old-name)
  (locate-user-emacs-file (concat "data/" new-name)
                          (if old-name (concat "data/" old-name) nil)))

(defvar-keymap custom-global-keymap)

(define-minor-mode custom-global-keymap-mode
  "Minor mode for defining custom global hotkeys.")

(add-to-list 'minor-mode-map-alist custom-global-keymap)
