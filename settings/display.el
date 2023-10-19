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
