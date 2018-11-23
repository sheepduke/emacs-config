;;; package --- summary
;;;
;;; Commentary:
;;; This package is used for toggling window splitting style.
;;;
;;; Code is copied from `https://www.emacswiki.org/emacs/ToggleWindowSplit'
;;;
;;; Code:


(defun toggle-window-split ()
  "Toggle the window splitting style when you have 2 windows."
  (interactive)
  (cond
   ((= (count-windows) 2)
    (let* ((this-win-buffer (window-buffer))
	       (next-win-buffer (window-buffer (next-window)))
	       (this-win-edges (window-edges (selected-window)))
	       (next-win-edges (window-edges (next-window)))
	       (this-win-2nd (not (and (<= (car this-win-edges)
					                   (car next-win-edges))
				                   (<= (cadr this-win-edges)
					                   (cadr next-win-edges)))))
	       (splitter
	        (if (= (car this-win-edges)
		           (car (window-edges (next-window))))
		        'split-window-horizontally
		      'split-window-vertically)))
	  (delete-other-windows)
	  (let ((first-win (selected-window)))
	    (funcall splitter)
	    (if this-win-2nd (other-window 1))
	    (set-window-buffer (selected-window) this-win-buffer)
	    (set-window-buffer (next-window) next-win-buffer)
	    (select-window first-win)
	    (if this-win-2nd (other-window 1)))))
   ;; Give an error if there are more than 2 windows.
   (t
    (message "toggle-window-split only support 2 windows."))))

(provide 'toggle-window-split)
