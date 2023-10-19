;;; Package --- Utility functions.

;;; Commentary:

;;; Code:

(defun line-in-comment? ()
  "Return T if current line is commented."
  (nth 4 (syntax-ppss)))

(defun current-line-content ()
  "Return line content in string."
  (buffer-substring (line-beginning-position)
					(line-end-position)))

(defun line-empty? ()
  "Return T if the line contain only spaces or nothing."
  (string-empty-p (string-trim (current-line-content))))

(defun toggle-comment-in-line (&optional arg)
  "If there is no content after CHAR, delete the comment char.
Otherwise, call `comment-dwin' with optional ARG."
  (interactive "*P")
  (if (or (use-region-p)
		  (string-empty-p (string-trim (current-line-content))))
	  (comment-dwim arg)
	(comment-or-uncomment-region (line-beginning-position)
								 (line-end-position))))

(defun disable-company-quickhelp-mode ()
  "Disable quickhelp-mode of company-mode."
  (company-quickhelp-local-mode 0))

(defun newline-smart-comment ()
  "Insert comment to next line if current line is commented."
  (interactive)
  (if (line-in-comment?)
      (let ((line (string-trim-left (current-line-content))))
        ;; Handle multi-line comment for C++ etc.
        (if (or (string-prefix-p "/*" line)
                (string-prefix-p "* " line))
            (progn (newline-and-indent)
                   (insert "* ")
                   (indent-region (line-beginning-position)
                                  (line-end-position)))
          ;; Just insert the comment line.
          (indent-new-comment-line)))
    ;; Just insert newline.
    (newline-and-indent)))

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

(defun copy-whole-buffer ()
  "Copy content of whole buffer to kill ring."
  (interactive)
  (kill-ring-save (point-min) (point-max))
  (message "Buffer content saved to kill ring"))

(defun save-and-kill-this-buffer()
  (interactive)
  (save-buffer-readonly)
  (kill-this-buffer))

(defun locate-user-data-file (new-name &optional old-name)
  (locate-user-emacs-file (concat "data/" new-name)
                          (if old-name (concat "data/" old-name) nil)))

;;; a1-functions.el ends here
