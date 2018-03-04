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

;;; This file provides feature mu4e-ext.
;;;
;;; It provides functions to extend the usability of mu4e.
;;; 
;;; Code:

(with-eval-after-load "mu4e"

  (defun mu4e-ext-read-all ()
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
            (mu4e-headers-mark-for-read)
            (incf line))
          (mu4e-mark-execute-all t))
      (message "You are not in mu4e-headers-mode.")))

  (provide 'mu4e-ext))
