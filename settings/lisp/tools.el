;; ============================================================
;;  Eshell
;; ============================================================

(use-package eshell
  :config
  (setq eshell-aliases-file (locate-user-data-file "eshell-alias"))

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

;; ============================================================
;;  PDF
;; ============================================================

;; Replace the original doc-view for PDF files.
(use-package pdf-tools
  :defer t
  :unless (windows?)

  :config
  (pdf-tools-install))

;; ============================================================
;;  Book Reader
;; ============================================================

;; Open epub files.
(use-package nov
  :mode ("\\.epub\\'" . nov-mode))

;; ============================================================
;;  Music
;; ============================================================

(use-package emms
  
  :init
  (require 'emms-setup)

  ;; Set players.
  (emms-all)
  (emms-default-players)

  ;; Show info at mode-line.
  (require 'emms-mode-line)
  (emms-mode-line-mode 1)

  ;; Show time of music.
  (require 'emms-playing-time)
  (emms-playing-time-mode 1)

  ;; Auto identify encode.
  (require 'emms-i18n)

  ;; Do NOT save and import playlist automatically.
  ;; WARNING! It will make Emacs slow.
  ;; (require 'emms-history)
  ;; (emms-history-load)

  ;; Don't repeat playlist.
  (setq emms-repeat-playlist nil)
  ;; Set default music directory.
  (setq emms-source-file-default-directory "~/music"))

;; ============================================================
;;  Dictionary
;; ============================================================

(use-package sdcv
  :if (executable-find "sdcv"))

;; ============================================================
;;  Browser
;; ============================================================

(use-package w3m
  :if (executable-find "w3m")

  :preface
  (defun w3m-bury-all-buffers ()
    "Bury all w3m related buffers."
    (interactive)
    (let ((buffers (w3m-list-buffers t)))
      (dolist (buffer buffers)
        (bury-buffer buffer)))
    (switch-to-other-buffer))

  (defun w3m-browse-url-in-browser (url &rest args)
    (if (wsl?)
        (let ((browse-url-generic-program "/mnt/c/Windows/System32/cmd.exe")
              (browse-url-generic-args '("/c" "start")))
          (browse-url-generic url))
      (browse-url-default-browser url)))

  :bind (:map w3m-mode-map
         ("C-<return>" . w3m-view-this-url-new-session)
         ("C-M-h" . w3m-previous-buffer)
         ("C-M-l" . w3m-next-buffer)
         ("H" . w3m-view-previous-page)
         ("L" . w3m-view-next-page)
         ("h" . w3m-db-history)
         ("q" . w3m-bury-all-buffers))

  :custom
  (w3m-home-page "about://bookmark/")

  ;; Images
  (w3m-toggle-inline-images-permanently t)
  (w3m-default-display-inline-images t)

  ;; Cookies
  (w3m-use-cookies t)
  (w3m-cookie-accept-bad-cookies t)

  ;; Sessions
  (w3m-session-load-last-sessions t)
  (w3m-new-session-in-background nil)
  (w3m-session-time-format "%Y-%m-%d %A %H:%M")

  ;; Cache
  (w3m-favicon-use-cache-file t)
  (w3m-keep-arrived-urls 5000)
  (w3m-keep-cache-size 1000)

  ;; Don't ask me if I'm leaving secure page.
  (w3m-confirm-leaving-secure-page nil)

  ;; Storage
  (w3m-default-save-directory (locate-user-data-file "w3m/saved/"))
  (w3m-bookmark-file (locate-user-data-file "w3m/bookmark.html"))

  ;; Set w3m as the default browser inside Emacs.
  (browse-url-browser-function '(("HyperSpec" . w3m-goto-url-new-session)
                                 (".*" . w3m-browse-url-in-browser)))
  (browse-url-handlers '(("HyperSpec" . w3m-goto-url-new-session)
                         (".*" . w3m-browse-url-in-browser)))

  ;; Set duckduckgo as the default search engine.
  (w3m-search-default-engine "duckduckgo")

  ;; Use w3m to render HTML mails.
  (mm-text-html-renderer 'w3m))

(use-package eww
  :defer t
  :custom
  (eww-download-directory "~/downloads/")
  (eww-bookmarks-directory (locate-user-data-file "eww/"))
  (browse-url-browser-function '((".*" . browse-url-default-browser))))

(use-package eww-plus
  :defer t
  :after eww

  :init
  ;; (setq browse-url-browser-function
  ;;       `(("HyperSpec" . eww-browse-url-new-buffer)
  ;;         (".*" . browse-url-default-browser)))
  )

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

;; ============================================================
;;  Diff
;; ============================================================

(use-package ediff
  :custom
  ;; Do not use frame!
  (ediff-window-setup-function 'ediff-setup-windows-plain)

  ;; Split window horizontally instead of vertically.
  (ediff-split-window-function 'split-window-horizontally))

;; ============================================================
;;  Input Method
;; ============================================================

(use-package rime
  :custom
  ;; Set Rime as the default input method.
  (default-input-method "rime")

  ;; Use mini-buffer as the prompt.
  (rime-show-candidate 'minibuffer)

  ;; Use ibus Rime data.
  (rime-user-data-dir (if (file-directory-p "~/.local/share/fcitx5/rime")
                          "~/.local/share/fcitx5/rime"
                        "~/.config/ibus/rime")))

;; ============================================================
;;  Calendar
;; ============================================================

(use-package calendar
  :bind ((:map calendar-mode-map
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

(use-package calfw)

(use-package calfw-org)

;; ============================================================
;;  Silver Brain
;; ============================================================

(use-package silver-brain
  :load-path "~/.silver-brain/emacs/"
  
  :config
  (silver-brain-install)

  :bind
  ("C-c b b" . silver-brain)
  ("C-c b o" . silver-brain-open)
  ("C-c b n" . silver-brain-new-concept)

  :custom
  (silver-brain-database-name "silver-brain")
  (silver-brain-server-port 5000))
