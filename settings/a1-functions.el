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
        (if (or (string-prefix-p "/*" line)
                (string-prefix-p "* " line))
            (progn (newline-and-indent)
                   (insert "* ")
                   (indent-region (line-beginning-position)
                                  (line-end-position)))
          (indent-new-comment-line)))
	(newline-and-indent)))

(defun get-available-font (font-list)
  "Return the first available font in FONT-LIST.
If no one was found, NIL is returned."
  (catch 'found
    (dolist (font font-list)
      (when (font-exist-p font)
        (throw 'found font)))))

(defun call-when-defined (func &rest args)
  "Call function FUNC when it is bound.
ARGS are arguments passed to FUNC."
  (when (fboundp func)
    (apply func args)))

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

(defun turn-linum-mode-on ()
  "Turn linum-mode-on."
  (linum-mode 1))

(defun windows? ()
  "Return T if current OS is Windows."
  (equal system-type 'windows-nt))

(defun x? ()
  "Return TRUE if we are under X system."
  (getenv "DISPLAY"))

(defun copy-whole-buffer ()
  "Copy content of whole buffer to kill ring."
  (interactive)
  (kill-ring-save (point-min) (point-max))
  (message "Buffer content saved to kill ring"))

(defun get-emacs-module-header-file ()
  "Get the absolute path to emacs-module.h header file.
Return NIL if nothing found."
  (cl-find-if (lambda (path) (file-exists-p (concat path "emacs-module.h")))
           *emacs-module-header-roots*))

;;; a1-functions.el ends here
