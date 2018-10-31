;;; Package --- Summary
;;;
;;; Commentary:
;;; This file contains utility functions.
;;; 
;;; Code:

(defun today (format)
  "Get today's date ISO date FORMAT."
  (format-time-string format (current-time)))

(defun line-in-comment? ()
  "Return T if current line is commented."
  (nth 4 (syntax-ppss)))

(defun current-line-content ()
  "Return line content in string."
  (buffer-substring (line-beginning-position)
					(line-end-position)))

(defun line-empty? ()
  "Return T if line contains only spaces or nothing."
  (string-empty-p (string-trim (current-line-content))))

(defun toggle-comment-in-line (&optional arg)
  "If there is no content after CHAR, delete the comment char.
Otherwise, call `comment-dwin'."
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
  "Return the first font in the list that is available in the system.
If no one was found, NIL is returned."
  (catch 'found
    (dolist (font font-list)
      (when (font-exist-p font)
        (throw 'found font)))))

(defun call-when-defined (func &rest args)
  "Call function FUNC when it is bound. If QUIETP is NIL, a warning is given
when function is not defined."
  (if (fboundp func)
      (apply func args)
    (warn "Function %s not defined" func)))

(defun emacs-version-main ()
  "Extract main version number of running Emacs."
  (let* ((version (emacs-version))
         (start (string-match "[0-9]\\{2\\}" version)))
    (string-to-number (substring version start (+ 2 start)))))

;;; a1-functions.el ends here
