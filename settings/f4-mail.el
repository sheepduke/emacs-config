;;; Package --- Email settings

;;; Commentary:

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        Notification                          ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'notifications)

(defvar *notification-sent* nil
  "Record whether or not the desktop notification has been sent.")

(defvar mail-update-function 'notmuch-poll
  "Function to update/index mail database.")

(defun check-new-mail ()
  "Check new mail and send desktop notification if there is any new mail."
  (catch 'checked
    (dolist (filename (directory-files *mailbox-dir*))
      (unless (or (equal filename ".")
                  (equal filename ".."))
        (let ((dir (concat *mailbox-dir* filename "/new/")))
          (when (and (file-exists-p dir)
                     (> (length (directory-files dir)) 2))
            (call-when-defined mail-update-function)
            (unless *notification-sent*
              (setq *notification-sent* t)
              (notifications-notify :title "New mail"))
            (throw 'checked t)))))
    (setq *notification-sent* nil)
    nil))

;; Register mail checking function.
(when (file-exists-p *mailbox-dir*)
  (setq display-time-mail-function 'check-new-mail))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            BBDB                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Contact database supporting Gnus contact completion.
(use-package bbdb
  :ensure
  :init
  ;; set bbdb database location.
  (setq bbdb-file (concat *data-path* "bbdb"))
  ;; add support for gnus
  (setq bbdb-complete-mail-allow-cycling t
		bbdb-completion-display-record nil)
  
  :config
  (call-when-defined 'bbdb-initialize 'message))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Message                             ;;;;
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

;; Add spell checking.
(add-hook 'message-mode-hook 'flyspell-mode)

;; Automatically Bcc myself.
(defun message-bcc-sender ()
  "Find the sender (i.e. myself) and add him to Bcc list."
  (interactive)
  (save-excursion
    (call-when-defined 'message-goto-from)
    (call-when-defined 'message-add-header
                       (concat "Bcc: " (substring (current-line-content) 6) "\n"))))

(add-hook 'message-send-hook 'message-bcc-sender)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Notmuch                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package notmuch
  :ensure

  :preface
  (defun notmuch-mark-all-as-read ()
    "Mark all unread mails as read."
    (interactive)
    (call-when-defined 'notmuch-tag "tag:unread" '("-unread")))

  (defun notmuch-toggle-flagged (get-tag-fun change-tag-fun)
    (funcall change-tag-fun
             (if (member "flagged" (funcall get-tag-fun))
                 '("-flagged")
               '("+flagged"))))

  (defun notmuch-search-toggle-flagged ()
    "Toggle flagged tag for current item."
    (interactive)
    (notmuch-toggle-flagged #'notmuch-search-get-tags #'notmuch-search-tag))

  (defun notmuch-tree-toggle-flagged ()
    "Toggle flagged tag for current item."
    (interactive)
    (notmuch-toggle-flagged #'notmuch-tree-get-tags #'notmuch-tree-tag))

  (defun notmuch-show-toggle-flagged ()
    "Toggle flagged tag for current item."
    (interactive)
    (notmuch-toggle-flagged #'notmuch-show-get-tags #'notmuch-show-tag))

  :init
  ;; The number of recent searches to display.
  (setq notmuch-hello-recent-searches-max 10)
  ;; Do not save to "sent" file
  (setq notmuch-fcc-dirs nil)
  ;; Show new emails first.
  (setq notmuch-search-oldest-first nil)

  ;; Set the saved searchers.
  (setq notmuch-saved-searches
        '((:name "Unread Gmail" :query "tag:unread AND tag:gmail")
          (:name "Unread Other" :query "tag:unread AND NOT tag:gmail" :key "u")
          (:name "Drafts" :query "tag:draft" :key "d")
          (:name "Flagged" :query "tag:flagged" :key "f")
          (:name "Gmail" :query "tag:gmail" :key "g")
          (:name "Feed" :query "tag:feed")
          (:name "Me" :query "tag:me")
          (:name "Inbox" :query "tag:inbox" :key "i")
          (:name "Ecnu" :query "tag:ecnu")
          (:name "Gentoo User" :query "tag:gentoo-user")
          (:name "Emacs User" :query "tag:emacs-user")
          (:name "Emacs Devel" :query "tag:emacs-devel")
          (:name "CL Cookbook" :query "tag:cl-cookbook")))

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
        ("f" . notmuch-search-toggle-flagged)
        ("M r" . notmuch-mark-all-as-read))
  (:map notmuch-tree-mode-map
        ("f" . notmuch-tree-toggle-flagged))
  (:map notmuch-show-mode-map
        ("f" . notmuch-show-toggle-flagged)
        ("C-c C-o" . browse-url-at-point)))


;;; f4-mail.el ends here
