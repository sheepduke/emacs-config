;;; mu4e-refile.el --- extension to mu4e, the mu mail user agent
;;
;; Copyright (C) 2017 Danny YUE

;; Author: Danny YUE <sheepduke@gmail.com>
;; Maintainer: Danny YUE <sheepduke@gmail.com>
;; Keywords: email
;; Version: 1.0

;; This file is not part of GNU Emacs.
;;
;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; This file provides feature mu4e-refile.
;;; It mainly defines 3 functions:
;;; mu4e-refile-search-and-refile - search and refile mails according to query.
;;; mu4e-refile-unread - refile all unread files.
;;; mu4e-refile-current-buffer - refile all mails in current buffer.
;;;
;;; If you already set up dynamic refile facility of mu4e, you can use the
;;; following configuration to make mu4e automatically refile your mail every
;;; time mu4e updates its index:
;;; (add-hook 'mu4e-index-updated-hook 'mu4e-refile-unread)

;;; Code:

(require 'mu4e)

(defvar mu4e-refile-header-buffer-name "*mu4e-headers*"
  "Name of mu4e header buffer.")

(defvar mu4e-refile-header-temp-buffer-name "*mu4e-headers-temp*"
  "Temporal name of mu4e header buffer.")


(defun mu4e-refile-save-header-buffer ()
  "Save header buffer by renaming."
  (let ((mu4e-buffer (get-buffer mu4e-refile-header-buffer-name)))
	(when mu4e-buffer
	  (with-current-buffer mu4e-buffer
		(rename-buffer mu4e-refile-header-temp-buffer-name)))))

(defun mu4e-refile-restore-header-buffer ()
  "Restore header buffer from temp name."
  (let ((mu4e-temp-buffer (get-buffer mu4e-refile-header-temp-buffer-name)))
	(when mu4e-temp-buffer
	  (with-current-buffer mu4e-temp-buffer
		(rename-buffer mu4e-refile-header-buffer-name)))))

(defun mu4e-refile-finished-p ()
  "Check if mu4e process has finished running."
  (save-excursion
	(or (search-forward "No matching messages found" (point-max) t 1)
		(search-forward "End of search results" (point-max) t 1))))

(defun mu4e-refile-current-buffer ()
  "Refile all the messages in current buffer, if the current buffer is
in `mu4e-headers-mode'. Better used after `mu4e-headers-search'."
  (interactive)
  (if (equal major-mode 'mu4e-headers-mode)
	  (let (message-count (line 0))
		(backward-page)
		(setq message-count
			  (1- (count-lines (point-min) (point-max))))
		;; For each message, mark and execute.
		(while (< line message-count)
		  (mu4e-headers-mark-for-refile)
		  (incf line))
		(mu4e-mark-execute-all t))
	(message "You are not in mu4e-headers-mode.")))

(defun mu4e-refile-search-and-refile (&optional query)
  "Search by QUERY and refile them. If QUERY is not given, ask for it."
  (interactive)
  (save-window-excursion
	(while (not query)
	  (setq query (read-string "[mu4e] Search and refile for: ")))
	
	(let (mu4e-active-p)
	  ;; If there is any buffer currently opened, save it.
	  (when (or (get-buffer mu4e-refile-header-buffer-name)
				(get-buffer "*mu4e-main*"))
		(setq mu4e-active-p t)
		(mu4e-refile-save-header-buffer))
	  
	  ;; Search the message and refile.
	  ;; We have to wait until mu4e has finished its job.
	  (mu4e~headers-search-execute query t)
	  (while (not (mu4e-refile-finished-p))
		(sleep-for 0.1))
	  
	  (mu4e-refile-current-buffer)
	  (kill-buffer)
	  ;; If mu4e is active, kill current buffer and restore mu4e session.
	  (when mu4e-active-p
		(mu4e-refile-restore-header-buffer)))))

(defun mu4e-refile-unread ()
  "Refile all unread files."
  (interactive)
  (mu4e-refile-search-and-refile "flag:unread"))

(provide 'mu4e-refile)
