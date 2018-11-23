;;; Package --- Summary
;;;
;;; Commentary:
;;; This file contains customize things for built-in packages,
;;; changing default behavior of Emacs.
;;;
;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         Default Behavior                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Replace "yes or no" with "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

;; When pressing 'return', do the action.
(define-key query-replace-map (kbd "return") 'act)

;; Don't show the startup message.
(setq inhibit-startup-message t)

;; When quiting Emacs, confirm.
(setq confirm-kill-emacs 'yes-or-no-p)

;; Load gentoo related functions.
(when (file-exists-p "/usr/share/emacs/site-lisp/site-gentoo.el")
  (require 'site-gentoo))

;; Share the clipboard with the outside X world.
(setq select-enable-clipboard t)

;; Don't cycle through completions.
(setq pcomplete-cycle-completions nil)

;; Fix the position of cursor while scrolling window.
(setq scroll-preserve-screen-position t)

;; Increase the warning threshold to 10M.
(setq large-file-warning-threshold 10000000)

;; Tune GC threshold to speed it up.
(setq gc-cons-threshold (eval-when-compile (* 10 1024 1024)))
(run-with-idle-timer 2 t (lambda () (garbage-collect)))

;; Don't use <TAB>
(setq-default indent-tabs-mode nil)

;; Disable recursive mini buffers.
(setq enable-recursive-minibuffers nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Backup                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Control where to put backup files.
(setq backup-by-copying t)
(setq backup-directory-alist '(("." . "/home/sheep/backup")))
;; Don't delete the old version.
(setq delete-old-versions t)
(setq kept-new-versions 2)
(setq kept-old-versions 4)
;; Enable open control.
(setq version-control t)

;; Don't ask me via dialog box!
(setq use-dialog-box nil)

;; Set the default tab width to 4.
(setq-default tab-width 4)
;; Always use space to do indention.
(setq indent-tabs-mode nil)

;; Set bookmark file.
(setq bookmark-default-file (concat *data-path* "bookmarks"))
;; Save bookmark whenever it is changed.
(setq bookmark-save-flag 1)


;; Toggle on-the-fly re-indentation
(electric-indent-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Modes                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Show column number
(column-number-mode 1)
;; Show line number
(line-number-mode 1)
;; Show matched parenthesis
(show-paren-mode 1)
;; Disable menu bar
(menu-bar-mode 0)
;; Disable tool bar
(tool-bar-mode 0)
;; Disable scroll bar
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode 0))
;; Automatically revert modified buffer
(global-auto-revert-mode)
;; Save cursor place of file after exiting Emacs
(save-place-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             Time                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Display time.
(display-time-mode t)
;; Set time format
(setq display-time-format "(%Y/%m/%d %H:%M:%S)")
;; Don't display load average
(setq display-time-default-load-average nil)
;; Use email icon to notify the new email.
(setq display-time-use-mail-icon t)
;; Refresh time every 1 second.
(setq display-time-interval 1)
(display-time)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             shell                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package eshell
  :init
  (setq eshell-aliases-file (concat *data-path* "eshell-alias"))

  (defun eshell-clear-buffer ()
    "Clear the buffer and delete everything. Handy if you have too much
output."
    (interactive)
    (let ((inhibit-read-only t))
      (erase-buffer)
      (eshell-send-input)))

  (defun eshell-mode-setup ()
    (setq pcomplete-cycle-completions nil)
    (local-set-key (kbd "C-M-l") 'eshell-clear-buffer)
    (setenv "PAGER" "/bin/cat"))

  (add-hook 'eshell-mode-hook 'eshell-mode-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Dired                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Dired
(require 'dired)
;; Human readable size display
(setq dired-listing-switches "-alh")
;; dired guesses the target directory
(setq dired-dwim-target t)

(define-key dired-mode-map (kbd ",") 'dired-kill-subdir)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Commands                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun enable-command (&rest commands)
  "Enable command inside `commands'. 
`commands' must be a list containing the symbol name of commands."
  (mapcar (lambda (command)
            (put command 'disabled nil))
          commands))

;; Enable commands
(enable-command 'dired-find-alternate-file
                'upcase-region
                'downcase-region
                'scroll-left)

(defun save-buffer-readonly ()
  "If current buffer is read-only, change its permission and write to it,
then change the permission back. This works like Vim 'w!'"
  (interactive)
  (let* ((filename (buffer-file-name))
         (original-file-modes (file-modes (buffer-file-name))))
    (condition-case nil
        (save-buffer)
      (error (set-file-modes filename (+ original-file-modes #o222))
             (message "....")
             (save-buffer)
             (set-file-modes filename original-file-modes)))))

(defun switch-to-other-buffer ()
  "Switch between 2 buffers."
  (interactive)
  (switch-to-buffer (other-buffer)))

(global-set-key (kbd "C-c r") 'rename-buffer)
(global-set-key (kbd "C-c s") 'eshell)
(global-set-key (kbd "C-x C-b") 'switch-to-other-buffer)
(global-set-key (kbd "C-x C-k") 'bury-buffer)
(global-set-key (kbd "C-x C-s") 'save-buffer-readonly)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-M-r") 'replace-regexp)
(global-set-key (kbd "M-u") 'upcase-initials-region)
(global-set-key (kbd "M-<") 'beginning-of-buffer)
(global-set-key (kbd "M->") 'end-of-buffer)
(global-set-key (kbd "M-;") 'toggle-comment-in-line)


;; auto fill
(global-set-key (kbd "M-q") 'fill-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Misc                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set the temporary directory.
(setq flycheck-temp-prefix "/tmp/flycheck")
;; Set the personal dictionary.
(setq ispell-personal-dictionary
      (concat *data-path* "aspell.en.pws"))

;; Do not use any GUI pinentry for GPG!

(if (< (emacs-version-main) 27)
    (setq epa-pinentry-mode 'loopback)
  (setq epg-pinentry-mode 'loopback))

;; Set the default method of tramp.
(setq tramp-default-method "ssh")

(global-set-key (kbd "C-c t t") 'toggle-truncate-lines)
(global-set-key (kbd "C-c t d") 'toggle-debug-on-error)
(global-set-key (kbd "C-c t l") 'linum-mode)

;;; a2-customize.el ends here
