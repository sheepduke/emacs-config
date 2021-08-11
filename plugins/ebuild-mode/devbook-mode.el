;;; devbook-mode.el --- edit the Gentoo Devmanual

;; Copyright 2020-2021 Gentoo Authors

;; Author: Ulrich Müller <ulm@gentoo.org>
;; Maintainer: <emacs@gentoo.org>
;; Keywords: wp, languages, XML

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

(require 'nxml-mode)
(require 'easymenu)
(require 'skeleton)

;;;###autoload
(define-derived-mode devbook-mode nxml-mode "DevBook"
  "Major mode for editing the Gentoo Devmanual."
  ;; The style guide says 80 characters. Set to 79 to keep diff output
  ;; within the limit (and arguably, 80 includes the newline).
  (setq fill-column 79)
  (setq indent-tabs-mode nil)
  ;; Tabs are allowed in ebuild codesamples, so this isn't redundant.
  (setq tab-width 4)
  ;; *** FIXME *** The style guide says no indentation, except inside
  ;; <tr>, <ul>, <ol> and <dl>, where it must be 2 spaces. There is no
  ;; easy way to achieve this, so set to 0 which is right more often.
  (set (make-local-variable 'nxml-child-indent) 0))

(define-skeleton devbook-insert-skeleton
  "Insert a skeleton for a DevBook XML document."
  nil
  "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
  "<guide "
  (let* ((dirname (file-name-directory buffer-file-name))
	 (path (if (string-match ".*/devmanual[^/]*/\\(.*\\)" dirname)
		   (match-string 1 dirname)
		 (skeleton-read "Path: "))))
    (if (string= path "")
	"root=\"true\""
      (concat "self=\"" (file-name-as-directory path) "\"")))
  ">\n"
  "<chapter>\n"
  "<title>" (skeleton-read "Title: ") "</title>\n"
  - "\n"
  "</chapter>\n"
  "</guide>\n")

(define-key devbook-mode-map
  "\C-c\C-n" 'devbook-insert-skeleton)

(easy-menu-define devbook-mode-menu devbook-mode-map
  "Menu for devbook-mode."
  `("DevBook"
    ["Insert skeleton" devbook-insert-skeleton]))

;;;###autoload
(add-to-list 'auto-mode-alist '("/devmanual.*\\.xml\\'" . devbook-mode))

(provide 'devbook-mode)

;; Local Variables:
;; coding: utf-8
;; End:

;;; devbook-mode.el ends here
