;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        Common Settings                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Habit tracking
(require 'org-habit)
;; Do not spam my timeline with it.
(setq org-habit-show-habits-only-for-today t)
;; Show my habits no matter whether it is scheduled today.
(setq org-habit-show-all-today t)

;; Convert the source code into HTML file keeping the highlight.
;; NOTE: This plugin is necessary when using Org Mode to generate HTML file.
(require 'htmlize)

;; Org modules loaded with org mode itself
(setq org-modules
      '(org-w3m org-bbdb org-habit org-bibtex org-docview org-info))
;; default table size
(setq org-table-default-size "2x2")

(defun org-mode-hook-function ()
  "Setup."
  (auto-fill-mode 0)
  (toggle-truncate-lines 0)
  (toggle-word-wrap 1)
  
  (make-local-variable 'company-backends)
  (setq company-backends '((company-dabbrev :with company-yasnippet)))

  (make-local-variable 'company-idle-delay)
  (setq company-idle-delay 0.5)

  (setq fill-column 80))
(add-hook 'org-mode-hook 'org-mode-hook-function)
(add-hook 'org-mode-hook 'flyspell-mode)

;; Some hot keys.
(define-key org-mode-map (kbd "C-c C-,") 'org-promote-subtree)
(define-key org-mode-map (kbd "C-c C-.") 'org-demote-subtree)
(define-key org-mode-map (kbd "C-c C-l") 'org-toggle-link-display)
(define-key org-mode-map (kbd "C-c C-i") 'org-mark-ring-goto)

(use-package helm
  :bind
  (:map org-mode-map
        ("C-c C-j" . helm-org-in-buffer-headings)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         Localization                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Display org in a bigger calendar!
(require 'calfw-org)
;; Chinese localization
(require 'cal-china-x)

;; Use Chinese month name.
(setq calendar-month-name-array
      ["一月" "二月" "三月" "四月" "五月" "六月"
       "七月" "八月" "九月" "十月" "十一月" "十二月"])
;; Use Chinese weekday name.
(setq calendar-day-name-array
      ["日" "一" "二" "三" "四" "五" "六"])
;; Use Monday as the first day of week.
(setq calendar-week-start-day 0)

;; Holidays
(setq calendar-holidays
      '(;;公历节日
        (holiday-fixed 1 1 "元旦")
        (holiday-fixed 2 14 "情人节")
        (holiday-fixed 3 8 "妇女节")
        (holiday-fixed 5 1 "劳动节")
        (holiday-float 5 0 2 "母亲节")
        (holiday-fixed 6 1 "儿童节")
        (holiday-float 6 0 3 "父亲节")
        (holiday-fixed 9 10 "教师节")
        (holiday-fixed 10 1 "国庆节")
        (holiday-fixed 12 25 "圣诞节")
        ;; 农历节日
        (holiday-lunar 12 30 "年三十" 0)
        (holiday-lunar 1 1 "春节" 0)
        (holiday-lunar 1 15 "元宵节" 0)
        (holiday-solar-term "清明" "清明节")
        (holiday-lunar 5 5 "端午节" 0)
        (holiday-lunar 8 15 "中秋节" 0)))

;; Key bindings for calendar.
(define-key calendar-mode-map (kbd "M-f") 'calendar-forward-month)
(define-key calendar-mode-map (kbd "M-b") 'calendar-backward-month)
(global-set-key (kbd "C-c O") 'calendar)
(global-set-key (kbd "C-c o") 'cfw:open-org-calendar)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        Customization                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set the default directory for all notes.
(setq org-directory "~/notes/")
;; Days to show in agenda view.
(setq org-agenda-span 3)
;; Always start on today in agenda.
(setq org-agenda-start-on-weekday nil)
;; Display agenda in the other window.
(setq org-agenda-window-setup 'current-window)
;; Restore the window config after displaying agenda.
(setq org-agendaq-restore-windows-after-quit t)
;; Do not show scheduled and deadline of finished items.
(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t)
;; Do now show scheduled items in global TOOD list.
(setq org-agenda-todo-ignore-scheduled t)

;; Get rid of the foot detail while generating HTML.
(setq org-html-postamble nil)
;; show everything on startup
(setq org-startup-folded nil)
;; do indenting
(setq org-startup-indented t)
;; fontify code blocks
(setq org-src-fontify-natively t)
;; don't show all the leading stars
(setq org-hide-leading-stars t)

;; Set the extra CSS for exported HTML files.
(setq org-html-head-extra
      "
<style type=\"text/css\">
:not(pre) > code {
  background: #d4d3d3; border-radius: 2px; padding: 2px
}​
</style>
")

;; Enable bold, italic etc inside Chinese context.
(setf (nth 0 org-emphasis-regexp-components) " \t('\"{[:multibyte:]")
(setf (nth 1 org-emphasis-regexp-components) " \t\r\n('\"{[:multibyte:],.)")
(org-set-emph-re 'org-emphasis-regexp-components
                 org-emphasis-regexp-components)

;; Always insert a new line before new item.
(setq org-blank-before-new-entry '((heading . t)
                                   (plain-list-item . t)))

;; Just let me refile!
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Export                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
		(incf start)
		(let ((filename (second (split-string (match-string 0 content)
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

(use-package htmlize
  :defer t
  :config
  (progn
    ;; It is required to disable `fci-mode' when `htmlize-buffer' is called;
    ;; otherwise the invisible fci characters show up as funky looking
    ;; visible characters in the source code blocks in the html file.
    ;; http://lists.gnu.org/archive/html/emacs-orgmode/2014-09/msg00777.html
    (with-eval-after-load 'fill-column-indicator
      (defvar modi/htmlize-initial-fci-state nil
        "Variable to store the state of `fci-mode' when `htmlize-buffer' is called.")

      (defun modi/htmlize-before-hook-fci-disable ()
        (setq modi/htmlize-initial-fci-state fci-mode)
        (when fci-mode
          (fci-mode -1)))

      (defun modi/htmlize-after-hook-fci-enable-maybe ()
        (when modi/htmlize-initial-fci-state
          (fci-mode 1)))

      (add-hook 'htmlize-before-hook #'modi/htmlize-before-hook-fci-disable)
      (add-hook 'htmlize-after-hook #'modi/htmlize-after-hook-fci-enable-maybe))

    ;; `flyspell-mode' also has to be disabled because depending on the
    ;; theme, the squiggly underlines can either show up in the html file
    ;; or cause elisp errors like:
    ;; (wrong-type-argument number-or-marker-p (nil . 100))
    (with-eval-after-load 'flyspell
      (defvar modi/htmlize-initial-flyspell-state nil
        "Variable to store the state of `flyspell-mode' when `htmlize-buffer' is called.")

      (defun modi/htmlize-before-hook-flyspell-disable ()
        (setq modi/htmlize-initial-flyspell-state flyspell-mode)
        (when flyspell-mode
          (flyspell-mode -1)))

      (defun modi/htmlize-after-hook-flyspell-enable-maybe ()
        (when modi/htmlize-initial-flyspell-state
          (flyspell-mode 1)))

      (add-hook 'htmlize-before-hook #'modi/htmlize-before-hook-flyspell-disable)
      (add-hook 'htmlize-after-hook #'modi/htmlize-after-hook-flyspell-enable-maybe))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Workflow                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Keep track of done things.
(setq org-log-done 'time)
;; Keep the task dependency.
(setq org-enforce-todo-dependencies t)
;; Archive to local file under 'Archived' tree with corresponding tag.
(setq org-archive-location "::* Archived :ARCHIVE:")
;; Record clock information of both running and history clocks.
(setq org-clock-persist t)
(org-clock-persistence-insinuate)

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c k") 'org-capture)

(setq org-todo-keywords
      '((sequence "TODO(t)" "Doing(o!)" "Pause(p@/!)" "|"
                  "Done(d@/!)" "Cancel(c@/!)")))

(setq org-todo-keyword-faces
      '(("TODO" . org-todo)
        ("PAUSE" :foreground "purple" :weight bold)
        ("Doing" :foreground "cyan" :weight bold)
        ("Done" :foreground "green" :weight bold)
        ("CANCELED" :foreground "SlateGray4" :weight bold)))

(setq org-refile-targets
      '((nil :maxlevel . 4)
        (org-agenda-files :maxlevel . 3)
        ("todo.org" :level . 1)
        ("event.org" :level . 1)
        ("capture.org" :level . 1)))

;; Set templates:
;; (KEYS DESCRIPTION TYPE TARGET TEMPLATE PROPERTIES)
;; TYPE: entry item checkitem table-line plain
;; TARGET: file id file+headline
(setq org-capture-templates
      `(("b" "Bookmark" entry (file+headline "bookmarks.org" "Bookmarks") "** %?")
        ("k" "Capture" entry (file "capture.org") "* %?")
        ("j" "Journal" plain (file ,(concat "~/private/journal/" (today "%Y-%m-%d") ".org")))))

(setq org-agenda-sorting-strategy
      '((category-keep agenda habit-down time-up priority-down)
        (category-keep todo priority-down)
        (category-keep tags priority-down)
        (search category-keep)))

(setq org-agenda-custom-commands
      '(("b" "Bookmarks" tags "+bookmark")
        ("n" "Agenda"
         ((agenda "" nil)
		  (todo "Pause"
                ((org-agenda-overriding-header "On Hold")))
          (todo "Doing"
                ((org-agenda-overriding-header "Doing")))
		  (todo "TODO"
				((org-agenda-overriding-header "TODO List")))
          (tags "refile"
               ((org-agenda-overriding-header "Refile")))
		  nil))))

