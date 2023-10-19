;;; Package --- Utility functions.

;;; Commentary:

;; Code:

(defun disable-company-quickhelp-mode ()
  "Disable quickhelp-mode of company-mode."
  (company-quickhelp-local-mode 0))

(defun font-exist-p (fontname)
  "Test if given FONTNAME is exist or not."
  (if (or (not fontname) (string= fontname ""))
      nil
    (if (not (x-list-fonts fontname)) nil t)))

(defun get-available-font (font-list)
  "Return the first available font in FONT-LIST.
If no one was found, NIL is returned."
  (catch 'found
    (dolist (font font-list)
      (when (font-exist-p font)
        (throw 'found font)))))

(defun emacs-version-main ()
  "Extract main version number of running Emacs."
  (let* ((version (emacs-version))
         (start (string-match "[0-9]\\{2\\}" version)))
    (string-to-number (substring version start (+ 2 start)))))

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

;;; a1-functions.el ends here
