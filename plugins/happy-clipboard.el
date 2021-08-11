;; This file contains a small package which separate the Emacs kill
;; ring and system X clipboard.
;; Also it contains some shortcuts which behave like the standard.
;;
;; To use it, put following elisp code into your Emacs configure file:
;; --- BEGIN ---
;; (require 'happy-clipboard)
;; ;; This package might not work properly without these 2 lines:
;; (setq x-select-enable-clipboard nil)
;; (setq x-select-enable-primary t)
;; 
;; ;; Replace 'text-mode-hook' with the mode you want to apply.
;; (add-hook 'text-mode-hook 'happy-clipboard-mode)
;; 
;; ;; Or if you want to toggle it on globally as always, replace
;; ;; 'add-hook' line with:
;; (happy-clipboard-global-mode)
;; --- END ---
;; 
;; Then you can use C-c to copy, C-x to cut and C-v to paste with X
;; clipboard, and C-w, M-w to play with Emacs kill ring.
;; 
;; Note that they are totally seperated.

(defvar happy-clipboard-mode-map (make-sparse-keymap))
(defvar happy-clipboard-mode-empty-map (make-sparse-keymap))

(defun happy-clipboard-paste ()
  "Yank the content from X clipboard into current position.
This function will not modify the Emacs kill ring."
  (interactive)
  (insert (gui-selection-value)))

(defun happy-clipboard-copy ()
  "Copy string in the currently selected region into the X clipboard.
This function does not modify the Emacs kill ring."
  (interactive)
  (if (not (use-region-p))
      (message "No active region selected.")
    (let ((select-enable-clipboard t))
      (gui-select-text (buffer-substring (region-beginning) (region-end)))
      (message "Text copied to X clipboard."))))

(defun happy-clipboard-cut ()
  "Like X-CLIPBOARD-COPY, but will remove the string from buffer."
  (interactive)
  (if (not (use-region-p))
      (message "No active region selected.")
    (progn (happy-clipboard-copy)
           (delete-region (region-beginning) (region-end)))))

(define-minor-mode happy-clipboard-mode
  "Toggle Happy Clip mode.
In this mode, the Emacs kill ring and X clipboard are seperated so that
they don't affect each other."
  ;; Set init value to nil
  :init-value nil
  (define-key happy-clipboard-mode-map (kbd "C-x") 'happy-clipboard-cut)
  (define-key happy-clipboard-mode-map (kbd "C-c") 'happy-clipboard-copy)
  (define-key happy-clipboard-mode-map (kbd "C-v") 'happy-clipboard-paste)
  (define-key happy-clipboard-mode-map (kbd "C-o") 'happy-clipboard-paste))

(define-globalized-minor-mode happy-clipboard-global-mode
  happy-clipboard-mode happy-clipboard-mode)

(provide 'happy-clipboard)
