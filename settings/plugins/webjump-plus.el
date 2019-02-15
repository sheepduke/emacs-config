;;; Package --- Summary
;;; This package adds more functions to built-in webjump module.
;;; Together with completion architecture it can make a huge difference.
;;;
;;; Commentary:
;;; 
;;; Code:

(defvar webjump-file
  (concat user-emacs-directory "webjump.el"))

(defun webjump-add ()
  "Read user input and add new bookmark."
  (interactive)
  (let ((url (read-string "Link: "))
        (title (read-string "Title: ")))
    (webjump--add title url)
    (setq webjump-sites
          (sort webjump-sites
                (lambda (a b)
                  (string< (first a)
                           (first b)))))
    (webjump-dump)))

(defun webjump--add (new-title new-url)
  "Push NEW-TITLE and NEW-URL to the front of WEBJUMP-SITES."
  (push (cons new-title new-url) webjump-sites))

(defun webjump-setup ()
  "Initialize webjump-plus functions."
  (if (file-exists-p webjump-file)
      (webjump-load)
    (webjump-dump))
  (file-notify-add-watch webjump-file '(change)
                         (lambda (event)
                           (webjump-load))))

(defun webjump-load ()
  "Load content of WEBJUMP-FILE into WEBJUMP-SITES."
  (setq webjump-sites
        (first
         (read-from-string
          (with-temp-buffer
            (insert-file-contents webjump-file)
            (buffer-string))))))

(defun webjump-dump ()
  "Dump WEBJUMP-SITES to file denoted by WEBJUMP-FILE."
  (with-temp-buffer
    (insert "(")
    (dolist (pair webjump-sites)
      (let ((title (first pair))
            (url (rest pair)))
        (insert
         (format "(\"%s\" . \"%s\")
"
                 title url))))
    (insert ")")
    ;; Write to webjump file.
    (write-region (point-min) (point-max) webjump-file)))

(provide 'webjump-plus)
;;; webjump-plus.el ends here
