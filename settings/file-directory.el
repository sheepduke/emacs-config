;; ============================================================
;;  Dired
;; ============================================================

(use-package dired
  :custom
  ;; Human readable size display
  (dired-listing-switches "-alh")

  ;; dired guesses the target directory
  (dired-dwim-target t)

  :bind (:map dired-mode-map
              ("," . dired-kill-subdir)))

(use-package dired-x
  :after dired
  
  :custom
  ;; Set omit regex in omit mode.
  (dired-omit-files "^\\.?#\\|^\\.")

  :bind (:map dired-mode-map
              ("h" . dired-omit-mode)))

;; ============================================================
;;  Backup
;; ============================================================

(use-package files
  :custom
  ;; Control where to put backup files.
  (backup-directory-alist `(("." . ,(locate-user-emacs-file "backup/"))))

  ;; Don't keep the outdated version.
  (delete-old-versions t)
  (kept-new-versions 2)
  (kept-old-versions 2))
