;;; Package --- Settings for Org Mode

;;; Commentary:

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        Customization                         ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org
  :preface
  (defun org-insert-table ()
    "Insert a 2x2 table to current position."
    (interactive)
    (save-excursion
      (insert "|---+---|
|   |   |
|---+---|
|   |   |
|---+---|")))

  :config
  ;; Enable bold, italic etc inside Chinese context.
  (setf (nth 0 org-emphasis-regexp-components)
        "-[:space:]('\"{[:multibyte:]")
  (setf (nth 1 org-emphasis-regexp-components)
        "-[:space:].,:!?;'\")}\\[[:multibyte:]")
  (org-set-emph-re 'org-emphasis-regexp-components
                   org-emphasis-regexp-components)

  :hook
  (org-mode . disable-truncate-lines)
  (org-mode . flyspell-mode)

  :bind (:map org-mode-map
              ("C-'" . nil)
              ("M-q" . org-fill-paragraph)
              ("C-c C-," . org-promote-subtree)
              ("C-c C-." . org-demote-subtree)
              ("C-c C-l" . org-toggle-link-display)
              ("C-c C-i" . org-mark-ring-goto)
              ("C-<tab>" . org-force-cycle-archived))

  :custom
  ;; Set the default directory for all notes.
  (org-directory "~/notes/")

  ;; Default table size.
  (org-table-default-size "2x2")

  ;; Show everything on startup.
  (org-startup-folded nil)

  ;; Do indenting during start-up.
  (org-startup-indented t)

  ;; Fontify code blocks.
  (org-src-fontify-natively t)

  ;; Don't show all the leading stars.
  (org-hide-leading-stars t)

  ;; Set the format of captured email link.
  (org-link-email-description-format "Email: %s")

  ;; Always insert a new line before new item.
  (org-blank-before-new-entry '((heading . t)
                                (plain-list-item . auto))))

;; TODO move it to use-package.
(defun org-mode-hook-function ()
  "Setup."
  (make-local-variable 'company-backends)
  (setq company-backends '((company-dabbrev :with company-yasnippet)))

  (make-local-variable 'company-idle-delay)
  (setq company-idle-delay 0.5))
(add-hook 'org-mode-hook 'org-mode-hook-function)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Modules                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org-habit :ensure org-plus-contrib
  :custom
  (org-habit-show-habits-only-for-today t)
  
  ;; Show my habits no matter whether it is scheduled today.
  (org-habit-show-all-today t)

  ;; Org modules loaded with org mode itself
  (org-modules '(org-bbdb
                 org-bibtex
                 org-docview
                 org-habit
                 org-notmuch
                 org-info)))

;; Bigger calendar.
(use-package calfw :ensure)

;; Display org items in calfw.
(use-package calfw-org :ensure
  :bind
  ("C-c o" . cfw:open-org-calendar))

;; Chinese localization
(use-package cal-china-x :ensure)

;; Show leading stars as bullets.
(use-package org-bullets :ensure
  :hook
  (org-mode . org-bullets-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Export                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Get rid of the foot detail while generating HTML.
(setq org-html-postamble nil)

;; Set the extra CSS for exported HTML files.
(setq org-html-head-extra
      "
<style type=\"text/css\">
:not(pre) > code {
  background: #d4d3d3; border-radius: 2px; padding: 2px
}​
</style>
")

;; Enable Markdown export.
(require 'ox-md)

;; Read ATTR_* for images.
(setq org-image-actual-width nil)

(defun org-inline-style-file (exporter)
  "Embed CSS file indicated by INLINE_STYLE into generated HTML file.
EXPORTER is provided by Org Mode."
  (when (eq exporter 'html)
	(let ((content (buffer-string))
		  (start 0))
	  ;; match
	  (while (setq start
                   (string-match "^.+INLINE_STYLE.*:.*\.css$" content start))
		(cl-incf start)
		(let ((filename (cl-second (split-string (match-string 0 content)
                                              ":" t " "))))
		  (if (file-exists-p filename)
			  (setq org-html-head (concat
								   "<style type=\"text/css\">\n"
								   "<!--/*--><![CDATA[/*><!--*/\n"
								   (with-temp-buffer
									 (insert-file-contents filename)
									 (buffer-string))
								   "/*]]>*/-->\n"
								   "</style>\n"))
			(message "Style file \"%s\" does not exist" filename)))))))

(add-hook 'org-export-before-processing-hook 'org-inline-style-file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                           Journal                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org-journal :ensure
  :custom
  ;; Set root directory.
  (org-journal-dir (concat org-directory "journal/"))
  
  ;; Set file format.
  (org-journal-file-format "%Y-%m-%d.org")
  
  ;; Set format of title in each journal file.
  (org-journal-date-format "%Y-%m-%d (%A)")
  
  ;; Use find-file in order to open new journal file in current window.
  (org-journal-find-file 'find-file)
  
  ;; Automatically adds current and future journals to agenda.
  (org-journal-enable-agenda-integration t)
  
  ;; Delete empty journal file.
  (org-journal-carryover-delete-empty-journal 'always)
  
  ;; Automatically carry over TODO items.
  (org-journal-carryover-items "TODO=\"TODO\"|TODO=\"HOLD\"")
  
  :bind
  ("C-c C-j" . nil)
  ("C-c j s" . org-journal-search)
  ("C-c j j" . org-journal-new-entry)
  ("C-c j k" . org-journal-new-scheduled-entry)
  ("C-c j v" . org-journal-schedule-view))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Workflow                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'org-depend)

;; Keep track of done things.
(setq org-log-done 'time)
;; Keep the task dependency.
(setq org-enforce-todo-dependencies t)
;; Archive to "archive.org" file.
(setq org-archive-location
      (format "%s/archive.org::" org-directory))
;; Record clock information of both running and history clocks.
(setq org-clock-persist t)
(org-clock-persistence-insinuate)

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c k") 'org-capture)
(global-set-key (kbd "C-c l l") 'org-store-link)
(global-set-key (kbd "C-c l i") 'org-insert-link)

(setq org-todo-keywords
      '((sequence "TODO(t)" "HOLD(h@/!)" "PROJ" "|"
                  "DONE(d@/!)" "STOP(s@/!)")))

(setq org-todo-keyword-faces
      '(("PROJ" :foreground "tomato" :weight bold)
        ("TODO" . org-todo)
        ("HOLD" :foreground "purple" :weight bold)
        ("DONE" . org-done)
        ("STOP" :foreground "DarkGreen" :weight bold)))

(setq org-tag-persistent-alist
      '((:startgroup . nil)
        ("feature" . ?f) ("bug" . ?b) ("enhancement" . ?e)
        (:endgroup . nil)
        (:startgroup . nil)
        ("@work" . ?w) ("@home" . ?h) ("@outside" . ?o)
        (:endgroup . nil)))

(setq org-refile-targets
      '((org-agenda-files :level . 1)))

;; Just let me refile!
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path 'file)

;; Set templates:
;; (KEYS DESCRIPTION TYPE TARGET TEMPLATE PROPERTIES)
;; TYPE: entry item checkitem table-line plain
;; TARGET: file id file+headline
(setq org-capture-templates
      `(("k" "Capture" entry
         (file "capture.org") "* %?\n"
         :empty-lines 1)
        ("K" "Kill Ring" entry
         (file "capture.org") "* %c\n"
         :empty-lines 1)
        ("t" "TODO" entry
         (file "main.org") "* TODO %?\n"
         :empty-lines 1)))

(setq org-agenda-sorting-strategy
      '((category-keep agenda habit-down time-up priority-down)
        (category-keep todo priority-down)
        (category-keep tags priority-down)
        (search category-keep)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                           Pomodoro                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org-pomodoro
  :ensure

  :init
  ;; Length of pomodoro cycle.
  (setq org-pomodoro-length 25)
  ;; Length of pomodoro short break.
  (setq org-pomodoro-short-break-length 5)

  :bind
  (:map org-agenda-mode-map
        ("i" . org-pomodoro)
        ("I" . org-agenda-clock-in)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                         Super Agenda                         ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Days to show in agenda view.
(setq org-agenda-span 'week)
;; Always start on today in agenda.
(setq org-agenda-start-on-weekday nil)
;; Display agenda in the other window.
(setq org-agenda-window-setup 'current-window)
;; Do not restore the window config after displaying agenda.
(setq org-agenda-restore-windows-after-quit nil)
;; Do not show scheduled and deadline of finished items.
(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t)
;; Set it to NIL because super-agenda is used.
(setq org-agenda-todo-ignore-scheduled nil)

(use-package org-super-agenda :ensure
  :init
  (call-when-defined 'org-super-agenda-mode 1)

  ;; Set the separator between blocks.
  (setq org-super-agenda-header-separator "\n●")

  (setq org-agenda-custom-commands
        `(("n" "Super Agenda"
           ((agenda "" nil)
            (todo "HOLD"
                  ((org-agenda-overriding-header "On Hold")))
            (todo "PROJ"
                  ((org-agenda-overriding-header "Projects")))
            (todo ""
                  ((org-agenda-overriding-header "TASKS")
                   (org-super-agenda-groups
                    '((:discard (:scheduled t))
                      (:discard (:todo "HOLD"))
                      (:discard (:todo "PROJ"))
                      (:discard (:tag "capture"))
                      (:discard (:tag "someday"))
                      (:name "Projects"
                             :auto-parent)
                      (:name "Priority"
                             :auto-priority)))))
            (tags "capture"
                  ((org-agenda-overriding-header "INBOX")
                   (org-super-agenda-groups
                    '((:name "Capture"
                             :tag "capture")))))))

          ("u" "Scheduled Tasks"
           ((todo ""
                  ((org-super-agenda-groups
                    '((:name "Scheduled Tasks"
                             :scheduled t)
                      (:discard (:not (:scheduled t))))))))))))
  
;;; e1-org-mode.el ends here
