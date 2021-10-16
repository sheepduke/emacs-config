;;; Package --- cl-helper

;;; Commentary:
;;; Provide functions to create slot definition for Common Lisp.

;;; Code:

(defun lisp-import-symbol-and-defpackage ()
  (interactive)
  (sly-import-symbol-at-point)
  (lisp-eval-defpackage)
  (forward-sexp))

(defun lisp-export-symbol-and-defpackage ()
  (interactive)
  (sly-import-symbol-at-point)
  (lisp-eval-defpackage)
  (forward-sexp))

(defun lisp-export-class-and-defpackage ()
  (interactive)
  (sly-export-class)
  (lisp-eval-defpackage)
  (forward-sexp))

(defun lisp-eval-defpackage ()
  (save-excursion
    (goto-char (point-min))
    (search-forward "(defpackage")
    (backward-char 11)
    (forward-sexp)
    (sly-eval-last-expression)))

(defun lisp-insert-slot ()
  "Insert slot definition accoring to user input."
  (interactive)
  (let* ((slot-name (lisp-read-slot-name))
         (slot-type (lisp-read-slot-type))
         (slot-accessor-type (lisp-read-slot-accessor-type))
         (oneline-content (lisp-get-oneline-slot-definition
                           slot-name
                           slot-type
                           slot-accessor-type)))
    (insert
     (if (<= (length oneline-content) 80)
         oneline-content
       (lisp-get-multiline-slot-definition slot-name slot-type slot-accessor-type)))))

(defun lisp-get-oneline-slot-definition (slot-name slot-type slot-accessor-type)
  (concat "("
          slot-name
          (if slot-type (concat " :type " slot-type) "")
          (if slot-accessor-type
              (format " %s %s" slot-accessor-type slot-name)
            "")
          " :initarg :" slot-name
          ")"))

(defun lisp-get-multiline-slot-definition (slot-name slot-type slot-accessor-type)
  (let* ((name-length (length slot-name))
         (indent-string (make-string (+ 4 name-length) ?\s)))
    (concat "("
            slot-name
            (if slot-type (format " :type %s\n%s" slot-type indent-string) "")
            (if slot-accessor-type
                (format "%s %s\n%s" slot-accessor-type slot-name indent-string)
              "")
            (format ":initarg :%s" slot-name)
            ")")))

(defun lisp-read-slot-name ()
  "Read slot name from user input."
  (read-string "Slot name? "))

(defun lisp-read-slot-type ()
  "Read slot type from user input."
  (cl-case (read-quoted-char "Type? [l]ist [n]umber [s]tring [o]ther [SPC]skip ")
    (?s "string")
    (?n "number")
    (?l "list")
    (?o (read-string "=> "))
    (?\s nil)))

(defun lisp-read-slot-accessor-type ()
  "Read slot accessor type from user input."
  (cl-case (read-quoted-char "Accessor? [a]ccessor [r]eader [w]riter [SPC]skip")
    (?a ":accessor")
    (?r ":reader")
    (?w ":writer")
    (?\s nil)))

(provide 'cl-helper)
