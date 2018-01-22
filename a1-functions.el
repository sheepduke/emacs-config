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

(defun current-line ()
  "Return line content in string."
  (buffer-substring (line-beginning-position)
					(line-end-position)))

(defun line-empty? ()
  "Return T if line contains only spaces or nothing."
  (string-empty-p (string-trim (current-line))))

(defun toggle-comment-in-line (&optional arg)
  "If there is no content after CHAR, delete the comment char.
Otherwise, call `comment-dwin'."
  (interactive "*P")
  (if (or (use-region-p)
		  (string-empty-p (string-trim (current-line))))
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
	  (indent-new-comment-line)
	(newline-and-indent)))

;;; a1-functions.el ends here
