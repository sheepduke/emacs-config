;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          Notification                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'notifications)

(defvar *notification-sent* nil
  "Record whether or not the desktop notification has been sent.")

(defun check-new-mail ()
  (catch 'checked
    (dolist (filename (directory-files *mailbox-dir*))
      (unless (or (equal filename ".")
                  (equal filename ".."))
        (let ((dir (concat *mailbox-dir* filename "/new/")))
          (when (and (file-exists-p dir)
                     (> (length (directory-files dir)) 2))
            (notmuch-poll)
            (unless *notification-sent*
              (setq *notification-sent* t)
              (notifications-notify :title "New mail"))
            (throw 'checked t)))))
    (setq *notification-sent* nil)
    nil))

;; Register mail checking function.
(setq display-time-mail-function 'check-new-mail)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              BBDB                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Contact database supporting Gnus contact completion.
(use-package bbdb
  :init
  ;; set bbdb database location.
  (setq bbdb-file (concat *data-path* "bbdb"))
  ;; add support for gnus
  (setq bbdb-complete-mail-allow-cycling t
		bbdb-completion-display-record nil)
  
  :config
  (when (fboundp 'bbdb-initialize)
    (bbdb-initialize 'message)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Message                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; use msmtp to send mail
(setq message-send-mail-function 'message-send-mail-with-sendmail
	  sendmail-program "msmtp")
;; Use "From:" header as the sender.
(setq message-sendmail-envelope-from 'header)
;; Specify envelope-from information while sending message.
(setq mail-specify-envelope-from t)
;; Use "From:" header as envelope address.
(setq mail-envelope-from 'header)

;; Set citation format.
(setq message-citation-line-format "On %Y-%m-%d %H:%M, %f wrote:")
(setq message-citation-line-function 'message-insert-formatted-citation-line)

;; Automatically Bcc myself.
(defun message-bcc-sender ()
  "Find the sender (i.e. myself) and add him to Bcc list."
  (interactive)
  (save-excursion
    (message-goto-from)
    (message-add-header (concat "Bcc: " (substring (current-line) 6) "\n"))))

(add-hook 'message-send-hook 'message-bcc-sender)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Notmuch                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package notmuch
  :init
  ;; The number of recent searches to display.
  (setq notmuch-hello-recent-searches-max 10)

  (defun notmuch-mark-all-as-read ()
    "Mark all unread mails as read."
    (interactive)
    (notmuch-tag "tag:unread" '("-unread")))

  ;; Set the saved searchers.
  (setq notmuch-saved-searches
        '((:name "unread" :query "tag:unread" :key "u")
          (:name "gmail" :query "tag:gmail" :key "g")
          (:name "me" :query "tag:me" :key "m")
          (:name "inbox" :query "tag:inbox" :key "i")
          (:name "ecnu" :query "tag:ecnu" :key "e")
          (:name "flagged" :query "tag:flagged" :key "f")
          (:name "gentoo-user" :query "tag:gentoo-user" :key "n")
          (:name "emacs-user" :query "tag:emacs-user" :key "a")
          (:name "drafts" :query "tag:draft" :key "d")))

  (defun notmuch-hello-init-cursor-position ()
    "Move cursor place to the first position of saved searches."
    (if (and (eq (point) (point-min))
             (search-forward "Saved searches:" nil t))
        (progn
          (forward-line)
          (widget-forward 1))))
      ;; (if (eq (widget-type (widget-at)) 'editable-field)
      ;;     (beginning-of-line))))
  (add-hook 'notmuch-hello-refresh-hook 'notmuch-hello-init-cursor-position)

  :bind
  ("C-c m" . notmuch)
  (:map notmuch-hello-mode-map
        ("g" . notmuch-refresh-this-buffer)
        ("M r" . notmuch-mark-all-as-read))
  (:map notmuch-search-mode-map
        ("g" . notmuch-refresh-this-buffer)
        ("M r" . notmuch-mark-all-as-read)))

(provide 'f4-mail)
;;; f4-mail.el ends here
