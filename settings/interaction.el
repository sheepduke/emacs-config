;; ============================================================
;;  Basic
;; ============================================================

(use-package emacs
  :custom
  ;; Content of *scratch* buffer.
  (initial-scratch-message "")

  ;; Share the clipboard with the outside X world.
  (select-enable-clipboard t)

  ;; Fix the position of cursor while scrolling window.
  (scroll-preserve-screen-position t)

  ;; Do not use any GUI pinentry for GPG!
  (epg-pinentry-mode 'loopback)

  ;; Do not ring the bell!
  (ring-bell-function 'ignore)

  ;; Set the default method of tramp.
  (tramp-default-method "ssh")

  :config
  ;; Enable some commands.
  (mapcar (lambda (command) (put command 'disabled nil))
          '(dired-find-alternate-file
            upcase-region downcase-region
            scroll-left narrow-to-region))

  ;; Always use y-or-n-p for confirmation.
  (defalias 'yes-or-no-p 'y-or-n-p))

;; ============================================================
;;  Windows OS
;; ============================================================

(use-package emacs
  :if (windows?)

  :custom
  ;; Disable Windows native cursor type.
  (w32-use-visible-system-caret nil))

;; ============================================================
;;  Bookmark
;; ============================================================

(use-package bookmark
  :custom
  ;; Set bookmark file.
  (bookmark-default-file (locate-user-data-file "bookmarks"))

  ;; Save bookmark whenever it is changed.
  (bookmark-save-flag 1))

;; ============================================================
;;  Which Key
;; ============================================================

;; Show hot keys when prefix keys are pressed.
(use-package which-key
  :demand t
  :delight ""

  :config
  (which-key-mode 1)

  :custom
  (which-key-idle-delay 0.5))

;; ============================================================
;;  Workspace Management
;; ============================================================

;; Manage buffers and window layouts into dynamic workspaces.
(use-package perspective
  :demand t

  :preface
  (defun persp-start-and-load ()
    (persp-mode 1)
    (persp-state-load persp-state-default-file))

  (defun persp-switch-to-1 ()
    (interactive)
    (persp-switch-by-number 1))

  (defun persp-switch-to-2 ()
    (interactive)
    (persp-switch-by-number 2))

  (defun persp-switch-to-3 ()
    (interactive)
    (persp-switch-by-number 3))

  (defun persp-switch-to-4 ()
    (interactive)
    (persp-switch-by-number 4))

  (defun persp-switch-to-5 ()
    (interactive)
    (persp-switch-by-number 5))

  (defun persp-switch-to-6 ()
    (interactive)
    (persp-switch-by-number 6))

  (defun persp-switch-to-7 ()
    (interactive)
    (persp-switch-by-number 7))

  (defun persp-switch-to-8 ()
    (interactive)
    (persp-switch-by-number 8))

  (defun persp-switch-to-9 ()
    (interactive)
    (persp-switch-by-number 9))

  :custom
  (persp-mode-prefix-key (kbd "C-c p"))

  ;; The default name of frame.
  (persp-initial-frame-name "1. main")

  ;; Method used to sort perspectives.
  (persp-sort 'name)

  ;; File used to load and save state file.
  (persp-state-default-file "~/.emacs.d/data/perspective.dat"))

;; ============================================================
;;  Window Management
;; ============================================================

(use-package emacs
  :custom )

;; Fast switching windows.
(use-package ace-window
  :demand t

  :custom
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

;; Quickly move between windows like a agility snake.
(use-package windmove
  :demand t
  
  :custom
  (windmove-wrap-around t))

;; Force window behavior.
(use-package shackle
  :custom
  ;; one of below, above, left, right
  (shackle-default-alignment 'below)
  ;; Don't reuse windows by default.
  (shackle-select-reused-windows nil)
  ;; Define shackle rules!
  (shackle-rules
   '(("*Bookmark List*" :select t :inhibit-window-quit t :same t)
     ("*Calendar*" :select t :inhibit-window-quit nil :size 0.3 :align below)
     ("Capture" :regexp t :select t :inhibit-window-quit t :same t)
     ("*Completions*" :select nil :inhibit-window-quit nil)
     ("*grep*" :select t)
     ("*Help*" :select t :inhibit-window-quit nil)
     ("*slime-description*" :select t :inhibit-window-quit t :same t)
     ("*toc*" :select t :inhibit-window-quit t :same t :size 0.5)))

  :config
  (shackle-mode))

;; ============================================================
;;  Completion
;; ============================================================
