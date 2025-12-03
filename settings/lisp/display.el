;; ============================================================
;;  Time
;; ============================================================

(use-package emacs
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
  (scroll-bar-mode 0)

  (global-display-line-numbers-mode 1))

;; ============================================================
;;  Fonts
;; ============================================================

(use-package emacs
  :config
  
  (defun find-first-available-font (&rest fonts)
    (let ((installed-fonts (seq-map (lambda (x) (decode-coding-string x 'utf-8))
                                    (font-family-list))))
      (seq-find (lambda (font) (member font installed-fonts)) fonts)))

  (defun find-font (search)
    (seq-filter (lambda (x) (string-match-p search x))
                (seq-map (lambda (x) (decode-coding-string x 'utf-8))
                         (font-family-list))))

  (defun set-font (script &rest fonts)
    (set-fontset-font nil script (apply #'find-first-available-font fonts)))

  (when (and (display-graphic-p) (windows?))
    (set-font 'latin "Cascadia Code" "Consolas")
    (set-font 'han "Microsoft YaHei")
    (set-font 'symbol "Cascadia Code" "Segoe UI Symbol")
    (set-font 'emoji "Segoe UI Emoji"))

  (when (and (display-graphic-p) (linux?))
    (set-font 'latin "FiraCode Nerd Font Mono" "DejaVu Sans Mono")
    (set-font 'han "文泉驿等宽微米黑" "WenQuanYi Micro Hei")
    (set-font 'emoji "Noto Color Emoji")))

;; ============================================================
;;  Icons
;; ============================================================

;; Requires nerd fonts symbols package to properly display it.
(use-package nerd-icons-dired
  :ensure
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
