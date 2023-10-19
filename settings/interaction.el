;; ============================================================
;;  Which Key
;; ============================================================

;; Show hot keys when prefix keys are pressed.
(use-package which-key
  :ensure
  :delight

  :config
  (which-key-mode 1)

  :custom
  (which-key-idle-delay 0.5))

;; ============================================================
;;  Perspective
;; ============================================================

;; Manage buffers and window layouts into dynamic workspaces.
(use-package perspective
  :defer nil

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
