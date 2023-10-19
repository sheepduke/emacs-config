;;; Package --- Customize built-in packages.

;;; Commentary:

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                       Default Behavior                       ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package emacs
  :custom
  ;; Content of *scratch* buffer.
  (initial-scratch-message "")

  ;; Share the clipboard with the outside X world.
  (select-enable-clipboard t)

  ;; Fix the position of cursor while scrolling window.
  (scroll-preserve-screen-position t)

  ;; Do not use any GUI pinentry for GPG!
  (epg-pinentry-mode 'loopback))

(use-package bookmark
  :custom
  ;; Set bookmark file.
  (bookmark-default-file (locate-user-data-file "bookmarks"))

  ;; Save bookmark whenever it is changed.
  (bookmark-save-flag 1))

;; Toggle on-the-fly re-indentation
(electric-indent-mode)


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
  (eww-bookmarks-directory (locate-user-data-file "eww/"))
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

(use-package ispell
  :custom
  ;; Set the personal dictionary.
  (ispell-personal-dictionary (locate-user-data-file "aspell.en.pws")))


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
  (setq webjump-file (locate-user-data-file "webjump.el"))
  (webjump-setup)

  :bind (("C-c 1" . webjump)
         ("C-c 2" . webjump-add)))

;;; a2-customize.el ends here
