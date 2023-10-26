;; ============================================================
;;  Time
;; ============================================================

(use-package time
  :custom
  ;; Set time format
  ;; (display-time-format "(%Y/%m/%d %H:%M:%S)")
  (display-time-format " %H:%M")

  ;; Don't display load average
  (display-time-default-load-average nil)

  ;; Use email icon to notify the new email.
  (display-time-use-mail-icon t)

  ;; Refresh time every 1 second.
  (display-time-interval 60)

  :config
  (display-time))

;; ============================================================
;;  Bars
;; ============================================================

(use-package emacs
  :config
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
  (scroll-bar-mode 0))

;; ============================================================
;;  Fonts
;; ============================================================

;; Set font if X window is in use.
;; Note that Chinese font size must be 2 larger than English font for
;; alignment.
(use-package emacs
  :if (display-graphic-p)

  :preface
  (defun font-exists? (fontname)
    "Test if given FONTNAME is exist or not."
    (if (or (not fontname) (string= fontname ""))
        nil
      (if (not (x-list-fonts fontname)) nil t)))

  (defun get-first-available-font (font-list)
    "Return the first available font in FONT-LIST.
If no one was found, NIL is returned."
    (catch 'found
      (dolist (font font-list)
        (when (font-exists? font)
          (throw 'found font)))))

  (defun set-font (english-font-list chinese-font-list size-pair)
    "Setup Emacs English and Chinese font on x window system.
ENGLISH-FONT-LIST and CHINESE-FONT-LIST are lists of fonts.
SIZE-PAIR is a cons pair indicating font size."
    (let ((english-font (get-first-available-font english-font-list))
          (chinese-font (get-first-available-font chinese-font-list)))
      (if english-font
          (set-frame-font (font-spec :family english-font
                                     :size (car size-pair)))
        (warn "No available English font."))

      (if chinese-font
          (dolist (charset '(kana han symbol cjk-misc bopomofo))
            (set-fontset-font (frame-parameter nil 'font) charset
                              (font-spec :family chinese-font
                                         :size (cdr size-pair))))
        (warn "No available Chinese font."))))

  :config
  (set-font '("FiraCode Nerd Font Mono" "DejaVu Sans Mono" "Consolas")
            '("Microsoft Yahei" "文泉驿等宽微米黑" "WenQuanYi Micro Hei")
            (cl-case (display-pixel-height)
              (2160 '(25 . 30))
              (1500 '(17 . 18))
              (1445 '(17 . 20))
              (1440 '(18 . 22))
              (t '(14 . 16)))))

;; ============================================================
;;  Icons
;; ============================================================

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

;; ============================================================
;;  Mode Line
;; ============================================================

(use-package delight
  :config
  ;; Disable auto-fill mode line.
  (delight 'auto-fill-function "" t)

  :config
  (delight '(;; Major modes
             (emacs-lisp-mode "ELisp" :major)
             ;; Globally enabled modes.
             (auto-revert-mode "" auto-revert)
             (autopair-mode "" autopair)
             (eldoc-mode "" eldoc)
             (yas-minor-mode "" yasnippet)
             ;; Dired
             (dired-async-mode "" dired-async))))
