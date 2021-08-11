;;; Package --- Session management

;;; Commentary:

;;; Code:

(use-package desktop
  :config
  ;; Save theme setting.
  (defun desktop-load-theme ()
    (dolist (theme custom-enabled-themes)
      (load-theme theme)))

  (add-to-list 'desktop-globals-to-save 'custom-enabled-themes)

  :hook (desktop-after-read . desktop-load-theme)

  :custom
  ;; No automatic save.
  (desktop-save nil)
  ;; Don't ask me about PID etc.
  (desktop-load-locked-desktop t)
  ;; Set files.
  (desktop-base-file-name "desktop")
  (desktop-base-lock-name "lock")
  ;; For elscreen-persist
  (desktop-files-not-to-save "")
  (desktop-restore-frames nil))

;;; z3-session.el ends here
