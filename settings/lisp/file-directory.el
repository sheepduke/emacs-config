;; ============================================================
;;  Dired
;; ============================================================

(use-package dired
  :init
  (defconst dired-open-programs
    '(("mp4" . "mpv")
      ("m4v" . "mpv")
      ("mkv" . "mpv")
      ("avi" . "mpv")
      ("jpg" . "feh")
      ("png" . "feh")))

  (defun dired-get-program (file)
    (let* ((ext (file-name-extension file)))
      (cdr (assoc-string ext dired-open-programs))))

  (defun dired-open-externally ()
    (interactive)
    (let* ((file (dired-get-file-for-visit))
           (cmd (or (dired-get-program file)
                    (error "No program defined"))))
      (start-process "dired-open" nil cmd file)))

  (defun dired-open-dwim ()
    (interactive)
    (let* ((file (dired-get-file-for-visit))
           (cmd (dired-get-program file)))
      (if cmd (dired-open-externally)
        (dired-find-file))))

  :custom
  ;; Human readable size display
  (dired-listing-switches "-alh")

  ;; dired guesses the target directory
  (dired-dwim-target t)

  ;; Set omit regex in omit mode.
  (dired-omit-files "^\\.?#\\|^\\.")

  :bind (:map dired-mode-map
              ("," . dired-kill-subdir)
              ("h" . dired-omit-mode)
              ("e" . dired-open-externally)
              ("<return>" . dired-open-dwim)))

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
