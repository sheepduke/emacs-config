;;; Package --- Customize built-in packages.

;;; Commentary:

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                       Default Behavior                       ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Replace "yes or no" with "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

;; When pressing 'return', do the action.
(define-key query-replace-map (kbd "return") 'act)

;; Don't show the startup message.
(setq inhibit-startup-message t)

;; Content of *scratch* buffer.
(setq initial-scratch-message "")

;; When quiting Emacs, confirm.
(setq confirm-kill-emacs 'yes-or-no-p)

;; Load gentoo related functions.
(when (file-exists-p "/usr/share/emacs/site-lisp/site-gentoo.el")
  (load "/usr/share/emacs/site-lisp/site-gentoo.el")
  (require 'site-gentoo))

;; Share the clipboard with the outside X world.
(setq select-enable-clipboard t)

(use-package pcomplete
  :custom
  ;; Don't cycle through completions.
  (pcomplete-cycle-completions nil))

;; Fix the position of cursor while scrolling window.
(setq scroll-preserve-screen-position t)

;; Increase the warning threshold to 15M.
(setq large-file-warning-threshold 15000000)

;; Tune GC threshold to speed it up.
(setq gc-cons-threshold (eval-when-compile (* 100 1024 1024)))
(run-with-idle-timer 2 t (lambda () (garbage-collect)))

;; Don't use <TAB>
(setq-default indent-tabs-mode nil)

;; Disable recursive mini buffers.
(setq enable-recursive-minibuffers nil)

;; Ignore all ring bell.
(setq ring-bell-function 'ignore)

;; Force to use Unix UTF-8 coding system.
(setq-default buffer-file-coding-system 'utf-8-unix)

;; Set default directory.
(setq-default default-directory (getenv "HOME"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Backup                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package files
  :ensure nil
  :custom
  ;; Control where to put backup files.
  (backup-by-copying t)
  (backup-directory-alist `(("." . ,*backup-dir*)))

  ;; Don't keep the outdated version.
  (delete-old-versions t)
  (kept-new-versions 2)
  (kept-old-versions 4)

  ;; Enable open control.
  (version-control t)

  ;; Don't ask me via dialog box!
  (use-dialog-box nil)

  ;; Set the default tab width to 4.
  (tab-width 4)
  ;; Always use space to do indention.
  (indent-tabs-mode nil))

(use-package bookmark
  :custom
  ;; Set bookmark file.
  (bookmark-default-file (concat *data-path* "bookmarks"))

  ;; Save bookmark whenever it is changed.
  (bookmark-save-flag 1))

;; Toggle on-the-fly re-indentation
(electric-indent-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Modes                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Show column number.
(column-number-mode 1)

;; Show line number.
(line-number-mode 1)

;; Show matched parenthesis.
(show-paren-mode 1)

;; Disable menu bar.
(menu-bar-mode 0)

;; Disable tool bar.
(tool-bar-mode 0)

;; Disable scroll bar.
(scroll-bar-mode 0)

;; Automatically revert modified buffer.
(global-auto-revert-mode)

;; Save cursor place of file after exiting Emacs.
(save-place-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                           Time                               ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package time
  :custom
  ;; Display time.
  (display-time-mode t)

  ;; Set time format
  (display-time-format "(%Y/%m/%d %H:%M:%S)")

  ;; Don't display load average
  (display-time-default-load-average nil)

  ;; Use email icon to notify the new email.
  (display-time-use-mail-icon t)

  ;; Refresh time every 1 second.
  (display-time-interval 1)

  :config
  (display-time))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                           shell                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package eshell
  :defines (eshell-aliases-file
            eshell-mode-map
            *data-path*)
  :functions (eshell-send-input)

  :config
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

  :hook (eshell-mode . eshell-mode-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Dired                               ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package dired
  :ensure nil
  :custom
  ;; Human readable size display
  (dired-listing-switches "-alh")

  ;; dired guesses the target directory
  (dired-dwim-target t)

  :bind (:map dired-mode-map
              ("," . dired-kill-subdir)))

(use-package dired-x
  :ensure nil
  :after dired
  
  :custom
  ;; Set omit regex in omit mode.
  (dired-omit-files "^\\.?#\\|^\\.")

  :bind (:map dired-mode-map
              ("h" . dired-omit-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          Commands                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun enable-command (&rest commands)
  "Enable all commands specified by COMMANDS.
COMMANDS must be a list containing the symbol name of commands."
  (mapcar (lambda (command)
            (put command 'disabled nil))
          commands))

;; Enable commands
(enable-command 'dired-find-alternate-file
                'upcase-region
                'downcase-region
                'scroll-left
                'narrow-to-region)

(defun save-buffer-readonly ()
  "If buffer is read-only, temporally change its permission and write to it.
This works like Vim 'w!'."
  (interactive)
  (let* ((filename (buffer-file-name))
         (original-file-modes (file-modes (buffer-file-name))))
    (condition-case nil
        (save-buffer)
      (error (set-file-modes filename (+ original-file-modes #o222))
             (save-buffer)
             (set-file-modes filename original-file-modes)))))

(defun switch-to-other-buffer ()
  "Switch between 2 buffers."
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun switch-to-scratch-buffer ()
  (interactive)
  (switch-to-buffer "*scratch*"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            ediff                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ediff
  :custom
  ;; Do not use frame!
  (ediff-window-setup-function 'ediff-setup-windows-plain)

  ;; Split window horizontally instead of vertically.
  (ediff-split-window-function 'split-window-horizontally))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                             eww                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package eww
  :defer t
  :custom
  (eww-download-directory "~/downloads/")
  (eww-bookmarks-directory (concat *data-path* "eww/"))
  (browse-url-browser-function '((".*" . browse-url-default-browser))))

(use-package eww-plus
  :ensure nil
  :defer t
  :after eww

  :init
  ;; (setq browse-url-browser-function
  ;;       `(("HyperSpec" . eww-browse-url-new-buffer)
  ;;         (".*" . browse-url-default-browser)))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                       Calendar                           ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package calendar
  :bind (("C-c O" . calendar)
         (:map calendar-mode-map
               (("M-f" . calendar-forward-month)
                ("M-b" . calendar-backward-month))))

  :custom
  ;; Use Chinese month name.
  (calendar-month-name-array ["一月" "二月" "三月" "四月" "五月" "六月"
                              "七月" "八月" "九月" "十月" "十一月" "十二月"])

  ;; Use Chinese weekday name.
  (calendar-day-name-array ["日" "一" "二" "三" "四" "五" "六"])

  ;; Use Monday as the first day of week.
  (calendar-week-start-day 0)

  ;; Holidays
  (calendar-holidays '(;;公历节日
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
                       (holiday-lunar 12 23 "祭灶" 0)
                       (holiday-lunar 12 30 "除夕" 0)
                       (holiday-lunar 1 1 "春节" 0)
                       (holiday-lunar 1 15 "元宵" 0)
                       (holiday-lunar 5 5 "端午" 0)
                       (holiday-lunar 7 7 "七夕" 0)
                       (holiday-lunar 8 15 "中秋" 0)
                       (holiday-lunar 9 9 "重阳" 0)
                       ;; 节气
                       (holiday-solar-term "小寒" "小寒")
                       (holiday-solar-term "大寒" "大寒")
                       (holiday-solar-term "立春" "立春")
                       (holiday-solar-term "雨水" "雨水")
                       (holiday-solar-term "惊蛰" "惊蛰")
                       (holiday-solar-term "春分" "春分")
                       (holiday-solar-term "清明" "清明")
                       (holiday-solar-term "谷雨" "谷雨")
                       (holiday-solar-term "立夏" "立夏")
                       (holiday-solar-term "小满" "小满")
                       (holiday-solar-term "芒种" "芒种")
                       (holiday-solar-term "夏至" "夏至")
                       (holiday-solar-term "小暑" "小暑")
                       (holiday-solar-term "大暑" "大暑")
                       (holiday-solar-term "立秋" "立秋")
                       (holiday-solar-term "处暑" "处暑")
                       (holiday-solar-term "白露" "白露")
                       (holiday-solar-term "秋分" "秋分")
                       (holiday-solar-term "寒露" "寒露")
                       (holiday-solar-term "霜降" "霜降")
                       (holiday-solar-term "立冬" "立冬")
                       (holiday-solar-term "小雪" "小雪")
                       (holiday-solar-term "大雪" "大雪")
                       (holiday-solar-term "冬至" "冬至"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            Misc                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package flycheck
  :custom
  ;; Set the temporary directory.
  (flycheck-temp-prefix "/tmp/flycheck"))


(use-package ispell
  :custom
  ;; Set the personal dictionary.
  (ispell-personal-dictionary (concat *data-path* "aspell.en.pws")))


(use-package ispell
  :if (and (windows?)
           (executable-find "hunspell"))

  :custom
  (ispell-program-name (executable-find "hunspell"))
  (ispell-local-dictionary "en_US")
  (ispell-hunspell-dict-paths-alist '(("en_US" "c:/Hunspell/en_US.aff")))
  (ispell-local-dictionary-alist '(("en_US"
                                    "[[:alpha:]]"
                                    "[^[:alpha:]]"
                                    "[']"
                                    nil
                                    nil
                                    nil
                                    utf-8))))


;; Do not use any GUI pinentry for GPG!
(use-package epg-config
  :ensure nil
  :custom
  (epa-pinentry-mode 'loopback))

;; Set the default method of tramp.
(setq tramp-default-method "ssh")

;; Disable Windows cursor type.
(when (windows?)
  (setq w32-use-visible-system-caret nil))

(use-package webjump
  :defer t
  :defines (webjump-file)
  :functions (webjump-setup)
  
  :config
  (require 'webjump-plus)
  (setq webjump-file (concat *data-path* "webjump.el"))
  (webjump-setup)

  :bind (("C-c 1" . webjump)
         ("C-c 2" . webjump-add)))

;;; a2-customize.el ends here
