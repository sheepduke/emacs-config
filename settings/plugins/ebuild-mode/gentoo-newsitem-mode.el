;;; gentoo-newsitem-mode.el --- edit Gentoo GLEP 42 news items

;; Copyright 2009-2021 Gentoo Authors

;; Author: Ulrich Müller <ulm@gentoo.org>
;; Maintainer: <emacs@gentoo.org>
;; Keywords: wp

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 2 of the License, or
;; (at your option) any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'font-lock)
(require 'easymenu)
(require 'skeleton)

(defvar gentoo-newsitem-font-lock-keywords
  (eval-when-compile
    `((,(concat "^"
		(regexp-opt
		 '("Title" "Author" "Translator" "Content-Type" "Posted"
		   "Revision" "News-Item-Format" "Display-If-Installed"
		   "Display-If-Keyword" "Display-If-Profile")
		 t)
		":")
       . font-lock-keyword-face)))
  "Expressions to highlight in Gentoo newsitem mode.")

(defvar gentoo-newsitem-format-list
  '("1.0" "2.0")
  "List of news item formats defined by GLEP 42.")

;;;###autoload
(define-derived-mode gentoo-newsitem-mode text-mode "Newsitem"
  "Major mode for Gentoo GLEP 42 news items."
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '(gentoo-newsitem-font-lock-keywords t))
  (setq fill-column 72))

(define-skeleton gentoo-newsitem-insert-skeleton
  "Insert a skeleton for a Gentoo GLEP 42 news item."
  nil
  "Title: " (skeleton-read "Title: ") "\n"
  "Author: " (skeleton-read
	      "Author's real name and e-mail address: "
	      (concat user-full-name " <" user-mail-address ">"))
  "\n"
  ((skeleton-read "Further author (null string to terminate): ")
   "Author: " str "\n")
  ((skeleton-read "Translator (null string to terminate): ")
   "Translator: " str "\n")
  ;;@					; not supported in XEmacs 21.5
  (progn
    (setq v2 (point-marker))
    nil)
  "Posted: " (skeleton-read "Date of posting: "
			    (format-time-string "%Y-%m-%d"))
  "\n"
  "Revision: 1\n"
  "News-Item-Format: "
  (setq v1 (completing-read
	    "News-Item-Format: "
	    (mapcar 'list gentoo-newsitem-format-list) nil 'confirm
	    nil nil (car (last gentoo-newsitem-format-list))))
  "\n"
  (if (string-equal v1 "1.0")
      (save-excursion
	;;(goto-char (car skeleton-positions))
	(goto-char v2)
	(insert "Content-Type: text/plain\n")
	nil))
  ((skeleton-read "Display-If-Installed: (null string to terminate): ")
   "Display-If-Installed: " str "\n")
  ((skeleton-read "Display-If-Keyword: (null string to terminate): ")
   "Display-If-Keyword: " str "\n")
  ((skeleton-read "Display-If-Profile: (null string to terminate): ")
   "Display-If-Profile: " str "\n")
  "\n")


(define-key gentoo-newsitem-mode-map
  "\C-c\C-n" 'gentoo-newsitem-insert-skeleton)

(easy-menu-define gentoo-newsitem-mode-menu gentoo-newsitem-mode-map
  "Menu for gentoo-newsitem-mode."
  `("Newsitem"
    ["Insert skeleton" gentoo-newsitem-insert-skeleton]))

;;;###autoload
(add-to-list 'auto-mode-alist
	     '("/[0-9]\\{4\\}-[01][0-9]-[0-3][0-9]-.+\\.[a-z]\\{2\\}\\.txt\\'"
	       . gentoo-newsitem-mode))

(provide 'gentoo-newsitem-mode)

;; Local Variables:
;; coding: utf-8
;; End:

;;; gentoo-newsitem-mode.el ends here
