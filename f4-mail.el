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
            (unless *notification-sent*
              (setq *notification-sent* t)
              (notmuch-poll)
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

;; Set citation format.
(setq message-citation-line-format "On %Y-%m-%d %H:%M, %f wrote:")
(setq message-citation-line-function 'message-insert-formatted-citation-line)

;; Automatically Bcc myself.
(defun message-bcc-sender ()
  "Find the sender (i.e. myself) and add him to Bcc list."
  (interactive)
  (save-excursion
    (message-goto-from)
    (message-add-header (concat "Bcc: " (substring (current-line) 6)))))

(remove-hook 'message-mode-hook  'message-bcc-sender)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Notmuch                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package notmuch
  :init
  ;; The number of recent searches to display.
  (setq notmuch-hello-recent-searches-max 10)

  :bind
  ("C-c m" . notmuch)
  (:map notmuch-hello-mode-map
        ("g" . notmuch-refresh-this-buffer))
  (:map notmuch-search-mode-map
        ("g" . notmuch-refresh-this-buffer)))
