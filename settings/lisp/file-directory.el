;; ============================================================
;;  Dired
;; ============================================================

(use-package dired
  :custom
  ;; Human readable size display
  (dired-listing-switches "-alh")

  ;; dired guesses the target directory
  (dired-dwim-target t)

  ;; Set omit regex in omit mode.
  (dired-omit-files "^\\.?#\\|^\\.")

  :bind (:map dired-mode-map
              ("," . dired-kill-subdir)
              ("h" . dired-omit-mode)))

;; ============================================================
;;  Backup
;; ============================================================

(use-package emacs
  :custom
  ;; Control where to put backup files.
  (backup-directory-alist `(("." . ,(locate-user-emacs-file "backup/"))))

  ;; Don't keep the outdated version.
  (delete-old-versions t)
  (kept-new-versions 2)
  (kept-old-versions 2))
