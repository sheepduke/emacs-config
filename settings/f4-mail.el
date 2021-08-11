;;; Package --- Email settings

;;; Commentary:

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                    New Mail Checking                         ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun check-new-mail ()
  "Check all sub-maildir under *MAILBOX-DIR* for new mails.
Returns a boolean value indicating the result."
  (if (file-directory-p *mailbox-dir*)
      (let* ((sub-maildirs (cl-remove-if-not
                            #'file-directory-p
                            (directory-files *mailbox-dir* t "^[a-z]")))
             (new-mail-dirs (cl-remove-if-not
                             #'file-directory-p
                             (mapcar (lambda (dir) (concat dir "/new"))
                                     sub-maildirs)))
             (mails (apply #'append
                           (mapcar (lambda (dir) (directory-files dir t "^[0-9A-Za-z]"))
                                   new-mail-dirs)))
             (mail-count (length mails)))
        (> mail-count 0))
    nil))

(setq display-time-mail-function 'check-new-mail)

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
  (bbdb-initialize 'message))


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
    (message-goto-from)
    (message-add-header
                       (concat "Bcc: " (substring (current-line-content) 6) "\n"))))

(add-hook 'message-send-hook 'message-bcc-sender)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Notmuch                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package notmuch
  :ensure

  :functions (notmuch-search-get-tags
              notmuch-search-tag
              notmuch-tree-get-tags
              notmuch-tree-tag
              notmuch-show-get-tags
              notmuch-show-tag)

  :config
  (defun notmuch-mark-all-as-read ()
    "Mark all unread mails as read."
    (interactive)
    (notmuch-tag "tag:unread" '("-unread")))

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

  (defun notmuch-hello-init-cursor-position ()
    "Move cursor place to the first position of saved searches."
    (if (and (eq (point) (point-min))
             (search-forward "Saved searches:" nil t))
        (progn
          (forward-line)
          (widget-forward 1))))

  :hook (notmuch-hello-refresh . notmuch-hello-init-cursor-position)

  :bind (("C-c m" . notmuch)
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

  :custom
  ;; The number of recent searches to display.
  (notmuch-hello-recent-searches-max 10)
  ;; Do not save to "sent" file
  (notmuch-fcc-dirs nil)
  ;; Show new emails first.
  (notmuch-search-oldest-first nil)

  ;; Set the saved searchers.
  (notmuch-saved-searches
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
     (:name "CL Cookbook" :query "tag:cl-cookbook"))))


;;; f4-mail.el ends here
